import org.springframework.web.context.support.WebApplicationContextUtils
import com.getsu.wcy.User
import com.getsu.wcy.Connection.ConnectionType
import org.codehaus.groovy.runtime.DefaultGroovyMethodsSupport
import com.getsu.wcy.Person
import com.getsu.wcy.Notification
import java.text.SimpleDateFormat
import com.getsu.wcy.WcyDomainBuilder
import com.getsu.wcy.PhoneNumber.PhoneNumberType

class BootStrap {

     def init = { servletContext ->
        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)

         // init auth events
         def events = appCtx.authenticationService.events // start with defaults
         events.onNewUserObject = { loginID -> User.createSignupInstance(loginID) }
         events.onSignup = { params ->
             def includes = [ 'preferredName', 'honorific', 'firstGivenName', 'middleGivenNames', 'familyName',
                     'suffix', 'photo', 'photoFileName', 'birthDate',
                     'connections[0].place.addresses[0].city',
                     'connections[0].place.addresses[0].state',
                     'connections[0].place.addresses[0].streetType'
             ]
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
        def builder = new WcyDomainBuilder()
        builder.classNameResolver = 'com.getsu.wcy'
        def joe = builder.user(login:'joe.cool@example.com', password:passwordEncoder('password')) {
            person(firstGivenName:'Joe', middleGivenNames:'B.', familyName:'Cool', photoFileName:'david-n-ben.JPG',
                    photo: getBytes(BootStrap.class.getResourceAsStream('dev/david-n-ben.JPG'))
            ) {
                connection(type:ConnectionType.HOME) {
                    place {
                        address(streetType:true, line1:'123 King St.', city:'Honolulu', state:'HI')
                    }
                }
            }
            settings(dateFormat:new SimpleDateFormat('yyyy-MM-dd HH:mm'), timeZone:TimeZone.default )
        }
        joe.save(failOnError:true)
    }

    private static addJane(Closure passwordEncoder) {
        def builder = new WcyDomainBuilder()
        builder.classNameResolver = 'com.getsu.wcy'
        def jane = builder.user(login:'jane.cool@rr.net', password:passwordEncoder('password')) {
            person(firstGivenName:'Jane', familyName:'Cool', photoFileName:'ben-tea.JPG',
                    photo: getBytes(BootStrap.class.getResourceAsStream('dev/ben-tea.JPG'))
            ) {
                connection(type:ConnectionType.HOME) {
                    place {
                        address(streetType:true, postalType:true, line1:'222 Kapiolani Blvd.', city:'Honolulu', state:'HI')
                    }
                    phoneNumber(type:PhoneNumberType.LANDLINE, number:'555-1111')
                }
                connection(type:ConnectionType.WORK) {
                    place {
                        address(streetType:true, line1:'42 Nuuanu Ave.', city:'Honolulu', state:'HI')
                        address(postalType:true, line1:'P.O.Box 1001', city:'Honolulu', state:'HI')
                        phoneNumber(type:PhoneNumberType.LANDLINE, number:'555-3333')
                        phoneNumber(type:PhoneNumberType.FAX, number:'555-4444')
                    }
                    phoneNumber(type:PhoneNumberType.LANDLINE, number:'555-3333 x123')
                    emailAddress(name:'Jane Cool, V.P. Sales', address:'jane@foo.com')
                }
                phoneNumber(type:PhoneNumberType.MOBILE, number:'555-5555')
                emailAddress(name:'Jane Cool', address:'jane.cool@rr.net')
            }
            settings(dateFormat:new SimpleDateFormat('yyyy-MM-dd HH:mm'), timeZone:TimeZone.default )
        }
        jane.save(failOnError:true)
    }

    // not sure why, but had to make this method static to have it found at runtime without any parameters
    private static addGranny() { // no User, only Person
        def builder = new WcyDomainBuilder()
        builder.classNameResolver = 'com.getsu.wcy'
        def granny = builder.person(firstGivenName:'Bertha', familyName:'Cool', photoFileName:'slippers.JPG',
                                        photo: getBytes(BootStrap.class.getResourceAsStream('dev/slippers.JPG'))
        ) {
            connection(type:ConnectionType.HOME) {
                place {
                    address(streetType:true, line1:'333 Date St.', city:'Honolulu', state:'HI')
                    phoneNumber(type:PhoneNumberType.LANDLINE, number:'555-2222')
                }
            }
        }
        granny.save(failOnError:true)
    }

    private static Date daysFromNow(days) {
        long DAYS_MILLIS = 1000 * 60 * 60 * 24;
        Date now = new Date()
        now.setTime((long)(now.time + days * DAYS_MILLIS))
        return now
    }

    private static addNotifications() {
        def joe = User.findByLogin('joe.cool@example.com')
        def jane = User.findByLogin('jane.cool@rr.net')
        def granny = Person.findByFirstGivenName('Bertha')

        new Notification(recipient:joe, date:daysFromNow(-5.7), subject:jane, verb:'shared with you', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:daysFromNow(-3.5), subject:jane, verb:'updated home address', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:daysFromNow(-2.05), subject:jane, verb:'added home phone', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:daysFromNow(-2.04), subject:jane, verb:'updated home phone', object:granny).save(failOnError:true)
        new Notification(recipient:joe, date:daysFromNow(-2.02), subject:jane, verb:'deleted work phone', object:granny).save(failOnError:true)
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
