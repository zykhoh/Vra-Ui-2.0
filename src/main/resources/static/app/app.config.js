'use strict';

angular.
module('vraUiApp').
config(['$locationProvider' ,'$routeProvider',
    function config($locationProvider, $routeProvider) {

        $routeProvider
            .when('/', {
                templateUrl: '/app/main-page/main-page.template.ftl'
            })
            .when('/detection', {
                templateUrl: '/app/detection-page/detection-page.template.ftl'
            })
            .when('/search-by-image', {
                templateUrl: '/app/search-by-image-page/search-by-image-page.template.ftl'
            })
            .when('/upload', {
                templateUrl: '/app/upload-page/upload-page.template.ftl',
                controller: 'uploadPageController'
            })
            .otherwise('/');
    }
]);