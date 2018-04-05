'use strict';

angular
    .module('uploadPage')
    .controller('uploadPageController', ['video', '$scope',
        function uploadPageController(video, $scope){

            $scope.gotMessage = false;
            $scope.message = {};
            $scope.newVideo = {};

            $scope.addVideo = function(){
                var form = document.getElementById('addVideoForm');
                var formData = new FormData(form);

                video.add(formData, function(res) {
                    $scope.gotMessage = true;
                    $scope.message.msg = 'Video uploaded and successfully added';
                    $scope.message.type = 'success';
                    document.getElementById("addVideoForm").reset();
                }, function(error) {
                    $scope.gotMessage = true;
                    if (error.status === 404){
                        $scope.message.msg = 'Ops!!! Server Not Found';
                        $scope.message.type = 'danger';
                    }
                    else{
                        console.log(error.status);
                        $scope.message.msg = error.data.message;
                        $scope.message.type = 'danger';
                    }
                });

            };

            $scope.closeAlert = function() {
                $scope.gotMessage = false;
            };

        }
    ]);