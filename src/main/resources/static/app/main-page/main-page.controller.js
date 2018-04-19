'use strict';

angular
    .module('mainPage')
    .controller('mainPageController', ['search', 'video', '$scope',
        function mainPageController(search, video, $scope){

            $scope.gotVideos = false;
            $scope.gotImages = false;
            $scope.searched = false;
            $scope.seeVideo = false;
            $scope.showLinks = false;

            // $scope.currentVideo = {
            //     sources: [
            //         {
            //             src: '/Users/zykhoh/Downloads/sample.mp4',
            //             type: 'video/mp4'
            //         }
            //     ]
            // };
            var videoPlayer;
            $scope.init = function () {
                videoPlayer = videojs('currentVideo');
            };

            $scope.videos = {};
            $scope.images = {};
            $scope.selectedVideo = {};
            $scope.annotations = {};
            $scope.annotationName = [];
            $scope.timeFrames = [];

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

            $scope.toVideo = function(videoId) {
                video.getVideoById({id:videoId}, function(res) {
                    $scope.selectedVideo.title = res.title;
                    $scope.selectedVideo.description = res.description;
                    $scope.selectedVideo.date = res.date;
                    $scope.selectedVideo.videoUrl = res.videoUrl;

                    // var videoPlayer = {
                    //     sources : [
                    //         {
                    //             src: res.videoUrl,
                    //             type: 'video/mp4'
                    //         }
                    //     ]
                    // };
                    // $scope.currentVideo = videoPlayer;

                    videoPlayer.src([
                        {type: "video/mp4", src: res.videoUrl}
                    ]);

                    $scope.seeVideo = true;
                    $scope.showLinks = false;
                });

                $scope.createSoftLink(videoId);
            };

            $scope.toSpecificVideoTimeFrame = function (curTime, videoUrl, videoId) {
                video.getVideoById({id:videoId}, function(res) {
                    $scope.selectedVideo.title = res.title;
                    $scope.selectedVideo.description = res.description;
                    $scope.selectedVideo.date = res.date;
                    $scope.selectedVideo.videoUrl = res.videoUrl;
                    $scope.seeVideo = true;
                    $scope.showLinks = false;
                });

                $scope.createSoftLink(videoId);

                // var videoPlayer = {
                //     sources : [
                //         {
                //             src: videoUrl,
                //             type: 'video/mp4'
                //         }
                //     ]
                // };
                // $scope.currentVideo = videoPlayer;

                videoPlayer.src([
                    {type: "video/mp4", src: videoUrl}
                ]);
                videoPlayer.currentTime(curTime);
                videoPlayer.load();
            };

            $scope.createSoftLink = function (videoId) {
                search.videoByIdAndFacetOnAnnotation({id:videoId}, function(res) {
                    $scope.annotationName = [];
                    $scope.annotations = {};

                    angular.forEach(res, function (key, value) {
                        if (!(value === "$promise") && !(value === "$resolved")) {
                            $scope.annotations[value] = key;
                            $scope.annotationName.push(value);
                        }
                    });
                    // angular.forEach($scope.annotations, function (key, value) {
                    //     // $scope.videoPlayer.addChild('SoftLink', {
                    //     //     text: value
                    //     // });
                    // });
                });
            };

            $scope.showLinkList = function (annotationName) {
                $scope.timeFrames = $scope.annotations[annotationName];
                $scope.showLinks = true;
            };

            $scope.toSpecificTime = function (curTime) {
                var videoPlayer = {
                    sources : [
                        {
                            src: $scope.selectedVideo.videoUrl,
                            type: 'video/mp4'
                        }
                    ]
                };
                $scope.currentVideo = videoPlayer;

                videoPlayer.src([
                    {type: "video/mp4", src: $scope.selectedVideo.videoUrl}
                ]);
                videoPlayer.currentTime(curTime);
                videoPlayer.load();
            }

        }
    ]);