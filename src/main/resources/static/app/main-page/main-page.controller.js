'use strict';

angular
    .module('mainPage')
    .controller('mainPageController', ['search', '$scope',
        function mainPageController(search, $scope){

            $scope.gotVideos = false;
            $scope.gotImages = false;
            $scope.searched = false;

            $scope.videos = {};
            $scope.images = {};

            $scope.search = function(){
                var form = document.getElementById('searchForm');
                var formData = new FormData(form);
                $scope.searched = true;

                search.searchVideo(formData, function(res) {
                    $scope.videos = res.content;
                    if (res.content[0]) {
                        $scope.gotVideos = true;
                    }
                    else {
                        $scope.gotVideos = false;
                    }
                }, function(error) {
                    $scope.gotVideos = false;
                    if (error.status === 404){
                        console.log(error.status);
                    }
                    else{
                        console.log(error.status);
                    }
                });

                search.searchImage(formData, function(res) {
                    $scope.images = res.content;
                    if (res.content[0]) {
                        $scope.gotImages = true;
                    }
                    else {
                        $scope.gotImages = false;
                    }
                }, function(error) {
                    $scope.gotImages = false;
                    if (error.status === 404){
                        console.log(error.status);
                    }
                    else{
                        console.log(error.status);
                    }
                });

            };

        }
    ]);