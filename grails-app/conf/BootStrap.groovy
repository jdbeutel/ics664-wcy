import org.springframework.web.context.support.WebApplicationContextUtils
import com.getsu.wcy.User
import com.getsu.wcy.PhysicalAddress
import com.getsu.wcy.Place
import com.getsu.wcy.Connection
import com.getsu.wcy.Connection.ConnectionType
import org.codehaus.groovy.runtime.DefaultGroovyMethodsSupport
import com.getsu.wcy.Person
import com.getsu.wcy.Notification

class BootStrap {

     def init = { servletContext ->
        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)

         // init auth events
         def events = appCtx.authenticationService.events // start with defaults
         events.onNewUserObject = { loginID -> User.createSignupInstance(loginID) }
         events.onSignup = { params ->
             def includes = [ 'preferredName', 'honorific', 'firstGivenName', 'middleGivenNames', 'familyName',
                     'suffix', 'photo', 'photoFileName', 'birthDate' ]
             params.user.person.properties[includes] = params.params
             params.user.person.save(failOnError:true)
         }
//         events.onValidatePassword = { password -> return !appCtx.myDictionaryService.containsWord(password) }

         environments {
             development {
                 addJoe(events.onEncodePassword)
                 addJane(events.onEncodePassword)
                 addGranny()
                 addNotifications()
             }
         }
     }

    private static addJoe(Closure passwordEncoder) {
        def a = new PhysicalAddress(line1:'123 King St.', city:'Honolulu', state:'HI', streetType:true)
        a.save(failOnError:true)
        def home = new Place().addToAddresses(a)
        home.save(failOnError:true)
        def u = User.createSignupInstance('joe.cool@example.com')
        u.password = passwordEncoder('password')
        u.person.firstGivenName = 'Joe'
        u.person.middleGivenNames = 'B.'
        u.person.familyName = 'Cool'
        u.person.photo = getBytes(BootStrap.class.getResourceAsStream('dev/david-n-ben.JPG'))
        u.person.photoFileName = 'david-n-ben.JPG'
        def c = new Connection(place:home, type:ConnectionType.HOME)
        c.save(failOnError:true)
        u.person.addToConnections(c)
        u.save(failOnError:true)
    }

    private static addJane(Closure passwordEncoder) {
        def a = new PhysicalAddress(line1:'222 Kapiolani Blvd.', city:'Honolulu', state:'HI', streetType:true)
        a.save(failOnError:true)
        def home = new Place().addToAddresses(a)
        home.save(failOnError:true)
        def u = User.createSignupInstance('jane.cool@example.com')
        u.password = passwordEncoder('password')
        u.person.firstGivenName = 'Jane'
        u.person.familyName = 'Cool'
        u.person.photo = getBytes(BootStrap.class.getResourceAsStream('dev/ben-tea.JPG'))
        u.person.photoFileName = 'ben-tea.JPG'
        def c = new Connection(place:home, type:ConnectionType.HOME)
        c.save(failOnError:true)
        u.person.addToConnections(c)
        u.save(failOnError:true)
    }

    // not sure why, but had to make this method static to have it found at runtime without any parameters
    private static addGranny() { // no User, only Person
        def a = new PhysicalAddress(line1:'333 Date St.', city:'Honolulu', state:'HI', streetType:true)
        a.save(failOnError:true)
        def home = new Place().addToAddresses(a)
        home.save(failOnError:true)
        def person = new Person(firstGivenName:'Bertha', familyName:'Cool')
        person.photo = getBytes(BootStrap.class.getResourceAsStream('dev/slippers.JPG'))
        person.photoFileName = 'ben-tea.JPG'
        def c = new Connection(place:home, type:ConnectionType.HOME)
        c.save(failOnError:true)
        person.addToConnections(c)
        person.save(failOnError:true)
    }

    private static addNotifications() {
        def joe = User.findByLogin('joe.cool@example.com')
        def jane = User.findByLogin('jane.cool@example.com')
        def granny = Person.findByFirstGivenName('Bertha')
        new Notification(recipient:joe, date:new Date() - 5, subject:jane, verb:'added', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:new Date() - 3, subject:jane, verb:'updated home address', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:new Date() - 2, subject:jane, verb:'updated home phone', object:granny).save(failOnError:true)
    }

    // from Groovy 1.7.1
    private static byte[] getBytes(InputStream is) throws IOException {
        ByteArrayOutputStream answer = new ByteArrayOutputStream();
        // reading the content of the file within a byte buffer
        byte[] byteBuffer = new byte[8192];
        int nbByteRead /* = 0*/;
        try {
            while ((nbByteRead = is.read(byteBuffer)) != -1) {
                // appends buffer
                answer.write(byteBuffer, 0, nbByteRead);
            }
            is.close();
        } finally {
            DefaultGroovyMethodsSupport.closeWithWarning(is);
        }
        return answer.toByteArray();
    }

     def destroy = {
     }
} 