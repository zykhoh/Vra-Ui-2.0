'use strict';

var env = {};

// Import variables if present (from env.js)
if(window){
    Object.assign(env, window.__env);
}

// Define AngularJS application
var ngModule = angular.module('vraUiApp', [
    'ngRoute',
    'commonComponents',
    'mainPage',
    'detectionPage',
    "searchByImagePage",
    "uploadPage"
]);

// Register environment in AngularJS as constant
ngModule.constant('__env', env);
