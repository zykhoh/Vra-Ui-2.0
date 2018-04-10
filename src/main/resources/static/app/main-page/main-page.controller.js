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

            var myButton = videojs.getComponent('Button');

            var SoftLink = videojs.extend(myButton, {

                constructor: function(player, options) {

                    myButton.apply(this, arguments);

                    if (options.text) {
                        this.updateTextContent(options.text);
                    }
                },

                // The `createEl` function of a component creates its DOM element.
                createEl: function() {
                    return videojs.createEl('button', {
                        className: 'vjs-soft-link row'
                    });
                },

                updateTextContent: function(text) {

                    if (typeof text !== 'string') {
                        text = 'Unknown';
                    }

                    videojs.emptyEl(this.el());
                    videojs.appendContent(this.el(), text);
                }
            });

            videojs.registerComponent('SoftLink', SoftLink);

            $scope.videoPlayer = videojs('currentVideo');

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
                    $scope.videoPlayer.src([
                        {type: "video/mp4", src: res.videoUrl}
                    ]);
                    $scope.seeVideo = true;
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
                });

                $scope.createSoftLink(videoId);

                $scope.videoPlayer.src([
                    {type: "video/mp4", src: videoUrl}
                ]);
                $scope.videoPlayer.currentTime(curTime);
                $scope.videoPlayer.load();
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
                $scope.videoPlayer.src([
                    {type: "video/mp4", src: $scope.selectedVideo.videoUrl}
                ]);
                $scope.videoPlayer.currentTime(curTime);
                $scope.videoPlayer.load();
            }

        }
    ]);