<!DOCTYPE html>

<html lang="en" ng-app="vraUiApp">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>VRA</title>

<#-- Static Required Files -->

    <link rel="stylesheet" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="webjars/font-awesome/5.0.2/web-fonts-with-css/css/fontawesome.min.css"/>
    <script src="webjars/jquery/1.11.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>

    <script src="webjars/angularjs/1.6.6/angular.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-route.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-resource.js"></script>
    <script src="webjars/angular-ui-bootstrap/2.2.0/ui-bootstrap-tpls.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-animate.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-touch.min.js"></script>

    <link rel="stylesheet" href="/css/app.css"/>


<#-- AngularJs Files -->

    <script src="/app/env.js"></script>
    <script src="/app/app.module.js"></script>
    <script src="/app/app.config.js"></script>

<#-- Core-Data -->



<#--  Common-components  -->

    <script src="/app/common-components/common-components.module.js"></script>
    <script src="/app/common-components/my-navbar/my-navbar.module.js"></script>
    <script src="/app/common-components/my-navbar/my-navbar.component.js"></script>

<#--  Main-Page  -->

    <script src="/app/main-page/main-page.module.js"></script>

<#--  Detection-Page  -->

    <script src="/app/detection-page/detection-page.module.js"></script>

<#--  Search-By-Image-Page  -->

    <script src="/app/search-by-image-page/search-by-image-page.module.js"></script>

<#--  Upload-Page  -->

    <script src="/app/upload-page/upload-page.module.js"></script>



</head>

<body>

    <div ng-view></div>

</body>

</html>