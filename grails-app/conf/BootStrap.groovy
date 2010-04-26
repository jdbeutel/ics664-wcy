import org.springframework.web.context.support.WebApplicationContextUtils
import com.getsu.wcy.User

class BootStrap {

     def init = { servletContext ->
        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)

         // init auth events
         def events = appCtx.authenticationService.events // start with defaults
         events.onNewUserObject = { loginID -> User.createInstance(loginID) }
         events.onSignup = { params ->
             def includes = [ 'preferredName', 'honorific', 'firstGivenName', 'middleGivenNames', 'familyName',
                     'suffix', 'photo', 'photoFileName', 'birthDate' ]
             params.user.person.properties[includes] = params.params
             params.user.person.save(failOnError:true)
         }
//         events.onValidatePassword = { password -> return !appCtx.myDictionaryService.containsWord(password) }
     }

     def destroy = {
     }
} 