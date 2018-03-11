'use strict';

angular.
module('vraUiApp').
config(['$locationProvider' ,'$routeProvider',
    function config($locationProvider, $routeProvider) {

        $locationProvider.hashPrefix('!');

        $routeProvider
            .when('/', {
                template: '<div>hello</div>'
            })
            .otherwise('/');
    }
]);