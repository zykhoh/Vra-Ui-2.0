<my-navbar></my-navbar>

<div class="container padding-32">

    <div class="row">
        <h2>Upload Video Here</h2>
        <p>
            The video uploaded will be taken into several processes typically image feature extraction, object detection and indexing. Currently, only mp4 video format is supported. The maximum file size limitation is up to 150MB.
        </p>
    </div>

    <br/>

    <div uib-alert ng-if="gotMessage" ng-class="'alert-' + (message.type)" close="closeAlert()">{{message.msg}}</div>
    <form enctype="multipart/form-data" name="addVideoForm" id="addVideoForm" ng-submit="addVideo()">

        <div class="form-group">
            <div class="input-group col-sm-4">
                <input type="file" class="form-control" name="videoFile" ng-model="newVideo.videoFile" placeholder="Drop here"/>
            </div>
        </div>

        <div class="form-group">
            <div class="input-group col-sm-4">
                <input type="text" class="form-control" name="title" ng-model="newVideo.title" placeholder="Video Title"/>
            </div>
        </div>

        <div class="form-group">
            <div class="input-group col-sm-4">
                <input type="date" class="form-control" name="date" ng-model="newVideo.date" placeholder="Video Captured Date"/>
            </div>
        </div>

        <div class="form-group">
            <textarea class="form-control" name="description" ng-model="newVideo.description" placeholder="Description"></textarea>
        </div>

        <div class="form-group">
            <div class="input-group">
                <input class="btn btn-default" type="submit" value="submit"/>
            </div>
        </div>

    </form>
</div>

<my-footer></my-footer>