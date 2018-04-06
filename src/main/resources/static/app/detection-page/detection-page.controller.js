'use strict';

angular
    .module('detectionPage')
    .controller('detectionPageController', ['image', '$scope',
        function detectionPageController(image, $scope){

            $scope.gotMessage = false;
            $scope.gotResult = false;
            $scope.message = {};
            $scope.results = {};

            $scope.detect = function(){
                $scope.gotMessage = true;
                $scope.message.msg = 'Detecting image... ...';
                $scope.message.type = 'info';

                var form = document.getElementById('detectForm');
                var formData = new FormData(form);

                image.add(formData, function(res) {
                    $scope.gotResult = true;
                    $scope.message.msg = 'Detection Done';
                    $scope.message.type = 'success';
                    $scope.results.originalImagePath = res.originalImagePath;
                    $scope.results.labeledFilePath = res.labeledFilePath;
                    $scope.results.recognitions = res.recognitions;
                    document.getElementById("detectForm").reset();
                }, function(error) {
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