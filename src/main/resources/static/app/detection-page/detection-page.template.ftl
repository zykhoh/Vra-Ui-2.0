<my-navbar></my-navbar>

<div class="container">
    <div class="row">
        <h2>Detect objects on your image HERE</h2>
        <p>
            The detection supports only images with .jpg extension.
        </p>
    </div>

    <div class="row">

        <div uib-alert ng-if="gotMessage" ng-class="'alert-' + (message.type)" close="closeAlert()">{{message.msg}}</div>

        <form method="POST" enctype="multipart/form-data" name="detectForm" id="detectForm" ng-submit="detect()">
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <td>File to upload:</td>
                    <td><input type="file" name="Image" required/></td>
                    <td><input class="btn btn-default" type="submit" value="submit"/></td>
                </tr>
                </tbody>
            </table>
        </form>

        <div ng-if="gotResult">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Input image</th>
                    <th>Result</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td><img src="{{ results.originalImagePath }}" class="img-responsive"></td>
                    <td><img src="{{ results.labeledFilePath }}" class="img-responsive"></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <li ng-repeat="recognition in results.recognitions">
                            <span>{{recognition.title}}</span>
                            <span> - </span>
                            <span>{{recognition.confidence}}</span>
                        </li>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>

    <div class="row">
        <div class="alert alert-info" role="alert">
            This program use YOLO (You Only Look Once) object detection algorithm.
        </div>
    </div>
    <div class="row">
        <p>
            This program used a pre-trained model and recognizes the following objects:
        </p>
        <table class="table table-bordered">
            <tbody>
            <tr>
                <td>
                    <ul>
                        <li>aeroplane</li>
                        <li>bicycle</li>
                        <li>bird</li>
                        <li>boat</li>
                        <li>bottle</li>
                        <li>bus</li>
                        <li>car</li>
                        <li>cat</li>
                        <li>chair</li>
                        <li>cow</li>
                    </ul>
                </td>
                <td>
                    <ul>
                        <li>diningtable</li>
                        <li>dog</li>
                        <li>horse</li>
                        <li>motorbike</li>
                        <li>person</li>
                        <li>pottedplant</li>
                        <li>sheep</li>
                        <li>sofa</li>
                        <li>train</li>
                        <li>tvmonitor</li>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<my-footer></my-footer>