'use strict';

angular.
module('dao.video').
factory('video',
    function ($resource) {

        return $resource('', {}, {
            add : {
                method: 'POST',
                url: window.__env.coreApiUrl + window.__env.videoBase + window.__env.addVideo,
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            },
            getVideoById : {
                method:'GET',
                url: window.__env.coreApiUrl + window.__env.videoBase + window.__env.getVideoByID
            }
        });

    }
);