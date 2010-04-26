<html>
    <head>
        <title><g:layoutTitle default="We'll Call You" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
        <nav:resources/>
    </head>
    %{-- Do not add an onload attribute to body elements.  Instead, locally add a Prototype observer, e.g.
        $(document).observe('dom:loaded', function() {ChangeManager.init($('htmlForm'), $('doSignup'), [])});
    --}%
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
        <div id="auth">
            <nav:render group="authOptions"/>
        </div>
        <div class="logo"><h1>We'll Call You</h1></div>
        <div id="menu">
            <nav:render group="tabs"/>
        </div>
        <g:layoutBody />
    </body>
</html>