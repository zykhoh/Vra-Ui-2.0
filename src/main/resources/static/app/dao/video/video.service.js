'use strict';

angular.
module('dao.video').
factory('video',
    function ($resource) {

        return $resource('', {}, {
            query   : {
                method:'GET',
                url: window.__env.coreApiUrl + window.__env.videoBase
            },
            add : {
                method: 'POST',
                url: window.__env.coreApiUrl + window.__env.videoBase + '/add',
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }
        });

    }
);