'use strict';

angular.
module('dao.image').
factory('image',
    function ($resource) {

        return $resource('', {}, {
            add : {
                method: 'POST',
                url: window.__env.coreApiUrl + window.__env.imageBase + window.__env.detect,
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }
        });

    }
);