'use strict';

angular.module('utils.integerToDate', [])
    .filter('integerToDate', function() {
        return function(seconds) {
            return new Date(1970, 0, 1).setSeconds(seconds);
        };
    });