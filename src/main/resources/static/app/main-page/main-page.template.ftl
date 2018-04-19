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
                <input type="text" class="form-control" name="searchTerm" ng-model="searchTerm" placeholder="search HERE"/>
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

<div class="clearfix"></div>

<div class="container" ng-if="searched">
    <h4 id="#video">Video Player</h4>

    <hr/>

    <div ng-class="!searched ? 'col-md-offset-2': ''" class="container col-md-8 padding-top-12">
        <div class="shadow">
            <video id="currentVideo" class="video-js vjs-default-skin" controls preload="none"
                   data-setup='{ "aspectRatio":"640:267", "playbackRates": [1, 1.5, 2] }'
                   vjs-video vjs-media="currentVideo">
            </video>

            <div class="panel padding-lr-32 padding-bottom-32" ng-if="seeVideo">
                <div class="row padding-top-12">
                    <div class="caption" ng-repeat="annotation in annotationName track by $index">
                        <a class="badge" ng-click="showLinkList(annotation)">
                            <span class="">{{annotation}}</span>
                        </a>
                    </div>
                </div>

                <hr ng-if="showLinks"/>

                <div class="row" ng-if="showLinks">
                    <div class="col-sm-4" ng-repeat="timeFrame in timeFrames track by $index">
                        <a class="timeFrame" ng-click="toSpecificTime(timeFrame)">
                            <span>{{ timeFrame | integerToDate | date:'HH:mm:ss' }}</span>
                        </a>
                    </div>
                </div>

                <hr ng-if="showLinks"/>

                <div class="row">
                    <h3>
                        <b>{{ selectedVideo.title }}</b>
                        <span class="pull-right">{{ selectedVideo.date | date:'dd/MM/yyyy'}}</span>
                    </h3>

                    <p>{{ selectedVideo.description }}</p>
                </div>

            </div>

            <div class="panel padding-lr-32 padding-bottom-32" ng-if="!seeVideo">
                <h3>
                    <b>No video selected</b>
                </h3>
            </div>
        </div>

        <div class="" ng-if="searched">
            <h4>Relevant Videos</h4>

            <hr/>

            <div ng-if="gotVideos">
                <div class="row padding-top-12 padding-bottom-12" ng-repeat="video in videos">
                    <div class="media">
                        <div class="media-left">
                            <a ng-click="toVideo(video.id)">
                                <img class="media-object" src="{{ video.imageFolder + '/000001.jpg' }}" alt="{{ video.title }}">
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
    </div>

    <div class="container col-md-4" ng-if="searched">
        <h4>Relevant Images</h4>
        <hr/>
        <div class="tz-gallery" ng-if="gotImages">
            <table>
                <tr class="row" ng-repeat="image in images">
                    <td class="thumbnail shadow">
                        <a class="lightbox" ng-click="toSpecificVideoTimeFrame(image.curTime, image.videoUrl, image.videoId)">
                            <img src="{{ image.imageUrl }}" style="max-height: 160px">
                        </a>
                        <div class="caption">
                            <span class="badge" ng-repeat="annotation in image.annotation track by $index">{{annotation}}</span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div ng-if="!gotImages">
            <p>No relevant image is found.</p>
        </div>
    </div>


</div>

<my-footer></my-footer>