'use strict';

angular.
module('dao.search').
factory('search',
    function ($resource) {

        return $resource('', {}, {
            searchImage : {
                method: 'POST',
                url: window.__env.coreApiUrl + window.__env.searchBase + window.__env.searchImage,
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            },
            searchVideo : {
                method: 'POST',
                url: window.__env.coreApiUrl + window.__env.searchBase + window.__env.searchVideo,
                transformRequest: angular.identity,
                headers: {'Content-Type': undefined}
            }
        });

    }
);