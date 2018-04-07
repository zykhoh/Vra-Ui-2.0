<my-navbar></my-navbar>

<div class="jumbotron"  ng-if="!searched">
    <div class="container">
        <h1  class=" text-center">Welcome!</h1>
    </div>
</div>

<div class="container">
    <form class="padding-top-24 padding-bottom-24" name="searchForm" id="searchForm" ng-submit="search()">
        <div class="row">
            <div ng-class="searched ? 'col-md-6 input-group' : 'col-md-6 col-md-offset-3 input-group'">
                <input type="text" class="form-control" name="searchTerm" ng-model="searchTerm" placeholder="search term... ..."/>
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="container" ng-if="!searched">
    <blockquote>
        <p>
            This is a platform for video and image retrieval website. It performs object detection, feature extraction, automated indexing and support retrieval. Try searching with single or multiple words or term.
        </p>
        <footer>
            E.g. person or yyyy/dd/MM
        </footer>
    </blockquote>
</div>

<div class="container" ng-if="searched">
    <h4>Relevant Videos</h4>

    <div ng-if="gotVideos">
        <div class="row col-md-8 padding-top-12 padding-bottom-12" ng-repeat="video in videos">
            <div class="media">
                <div class="media-left">
                    <a href="#">
                        <img class="media-object" src="{{ video.videoUrl }}" alt="{{ video.id }}">
                    </a>
                </div>
                <div class="media-body">
                    <h5 class="media-heading">
                        {{ video.title }}
                        <span class="pull-right">{{ video.date | date:'dd/MM/yyyy'}}</span>
                    </h5>
                    {{ video.description }}
                </div>
            </div>
        </div>
    </div>

    <div ng-if="!gotVideos">
        <p>No relevant video is found.</p>
    </div>
</div>

<div class="container" ng-if="searched">
    <hr/>
    <h4>Relevant Images</h4>
    <div class="tz-gallery" ng-if="gotImages">
        <div class="col-sm-6 col-md-4" ng-repeat="image in images">
            <div class="thumbnail shadow">
                <a class="lightbox" href="#">
                    <img src="{{ image.imageUrl }}" style="max-height: 160px">
                </a>
                <div class="caption">
                    <span class="badge" ng-repeat="annotation in image.annotation track by $index">{{annotation}}</span>
                </div>
            </div>
        </div>
    </div>

    <div ng-if="!gotImages">
        <p>No relevant image is found.</p>
    </div>
</div>

<my-footer></my-footer>