<!DOCTYPE html>

<html lang="en" ng-app="vraUiApp">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>VRA</title>

<#-- Static Required Files -->

    <link rel="stylesheet" href="webjars/bootstrap/3.3.7-1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="webjars/video-js/5.10.7/video-js.min.css"/>
    <link rel="stylesheet" href="webjars/font-awesome/5.0.10/web-fonts-with-css/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="webjars/font-awesome/5.0.10/web-fonts-with-css/css/fontawesome-all.min-jsf.css">
    <script src="webjars/jquery/1.11.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.7-1/js/bootstrap.min.js"></script>
    <script src="webjars/video-js/5.10.7/video.min.js"></script>

    <script src="webjars/angularjs/1.6.6/angular.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-route.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-resource.js"></script>
    <script src="webjars/angular-ui-bootstrap/2.2.0/ui-bootstrap-tpls.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-animate.min.js"></script>
    <script src="webjars/angularjs/1.6.6/angular-touch.min.js"></script>
    <script src="/js/angular-videojs.js"></script>

    <link rel="stylesheet" href="/css/app.css"/>


<#-- AngularJs Files -->

    <script src="/app/env.js"></script>
    <script src="/app/app.module.js"></script>
    <script src="/app/app.config.js"></script>

<#-- dao - data access object -->

    <script src="/app/dao/dao.module.js"></script>
    <script src="/app/dao/video/video.module.js"></script>
    <script src="/app/dao/video/video.service.js"></script>
    <script src="/app/dao/image/image.module.js"></script>
    <script src="/app/dao/image/image.service.js"></script>
    <script src="/app/dao/search/search.module.js"></script>
    <script src="/app/dao/search/search.service.js"></script>

<#--  Utils  -->

    <script src="/app/utils/utils.module.js"></script>
    <script src="/app/utils/integer-to-date/integer-to-date.module.js"></script>
    <script src="/app/utils/integer-to-date/integer-to-date.filter.js"></script>

<#--  Common-components  -->

    <script src="/app/common-components/common-components.module.js"></script>
    <script src="/app/common-components/my-navbar/my-navbar.module.js"></script>
    <script src="/app/common-components/my-navbar/my-navbar.component.js"></script>
    <script src="/app/common-components/my-footer/my-footer.module.js"></script>
    <script src="/app/common-components/my-footer/my-footer.component.js"></script>

<#--  Main-Page  -->

    <script src="/app/main-page/main-page.module.js"></script>
    <script src="/app/main-page/main-page.controller.js"></script>

<#--  Detection-Page  -->

    <script src="/app/detection-page/detection-page.module.js"></script>
    <script src="/app/detection-page/detection-page.controller.js"></script>

<#--  Search-By-Image-Page  -->

    <script src="/app/search-by-image-page/search-by-image-page.module.js"></script>

<#--  Upload-Page  -->

    <script src="/app/upload-page/upload-page.module.js"></script>
    <script src="/app/upload-page/upload-page.controller.js"></script>


</head>

<body>

    <div ng-view></div>

</body>

</html>