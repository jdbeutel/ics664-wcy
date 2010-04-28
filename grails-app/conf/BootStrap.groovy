import org.springframework.web.context.support.WebApplicationContextUtils
import com.getsu.wcy.User
import com.getsu.wcy.PhysicalAddress
import com.getsu.wcy.Place
import com.getsu.wcy.Connection
import com.getsu.wcy.Connection.ConnectionType
import org.codehaus.groovy.runtime.DefaultGroovyMethodsSupport

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
                 def a = new PhysicalAddress(line1:'123 King St.', city:'Honolulu', state:'HI', street:true)
                 a.save(failOnError:true)
                 def home = new Place().addToAddresses(a)
                 home.save(failOnError:true)
                 def u = User.createSignupInstance('joe.cool@example.com')
                 u.password = events.onEncodePassword('password')
                 u.person.firstGivenName = 'Joe'
                 u.person.middleGivenNames = 'B.'
                 u.person.familyName = 'Cool'
                 u.person.photo = getBytes(getClass().getResourceAsStream('dev/ben-tea.JPG'))
                 u.person.photoFileName = 'ben-tea.JPG'
                 def c = new Connection(place:home, type:ConnectionType.HOME)
                 c.save(failOnError:true)
                 u.person.addToPlaces(c)
                 u.save(failOnError:true)
             }
         }
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