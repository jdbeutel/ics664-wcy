class BootStrap {

     def init = { servletContext ->
//        def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)

         // init auth events
//        appCtx.authenticationService.events.onValidatePassword = { password ->
//            return !appCtx.myDictionaryService.containsWord(password)
//        }
     }

     def destroy = {
     }
} 