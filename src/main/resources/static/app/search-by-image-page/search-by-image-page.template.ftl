<script type="text/javascript" src="/js/gridify.js"></script>

<script language="JavaScript">
    serverUrlPrefix = "http://localhost:8983/solr/image/";
    // serverUrlPrefix = "lire/";

    function printResults(docs) {
        var last = $("#imagegrid");
        var options =
                {
                    srcNode: '.imageDiv',             // grid items (class, node)
                    margin: '20px',             // margin in pixel, default: 0px
                    width: '200px',             // grid item width in pixel, default: 220px
                    max_width: '',              // dynamic gird item width if specified, (pixel)
                    resizable: true,            // re-layout if window resize
                    transition: 'all 0.5s ease' // support transition for CSS3, default: all 0.5s ease
                };
        for (var i = 0; i < docs.length; i++) {
            myID = docs[i].id.toString();
            myUrl = docs[i].imageUrl.toString();
            last.append('<div class="imageDiv text-center">' +
                    '<a href="' + myUrl + '">' +
                    '<img class="img-responsive" src="' + myUrl + '"  data-toggle="tooltip" data-placement="top" title="' + docs[i].id.toString() + ' ' + (docs[i].categories_ws != null ? docs[i].categories_ws.toString() : '') + '"></a>' +
                    // '<div class="well" style="margin-top: 6px">' +
                    '<a href="javascript:search(\'' + myID + '\', \'select\', 1, \'' + myUrl + '\')" class="btn btn-default btn-xs" style="position: relative; top: -3em; opacity: 0.5;"><i class="fa fa-search-plus fa-2x" aria-hidden="true"></i></a> ' +
                    // '</div>' +
                    '</div>');
            // console.log(myUrl);
            if (i % 4 == 0) document.querySelector('.grid').gridify(options);
        }
        // make it a grid

        document.querySelector('.grid').gridify(options);
        // enable tool tips.
        $(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
        $("#waiting").hide();
    }

    /**
     *
     * @param query the docID or URL
     * @param feature the feature class
     * @param type types are 1:docID, 2:URL, 3:text
     */
    function search(query, feature, type, additionalUrl) {
        $(".imageDiv").remove();
        $("#waiting").show();
        $("#results").hide();
        $("#perf").hide();

        if (feature == 'select') {
            feature = $("#searchUrlQueryFeature").val();
        }

        var reqUrl = serverUrlPrefix;
        var searchType = $("#searchTypeSelect").val();

        if (searchType == "lireq" || type==3) { // if we go for the LireRequestHandler
            if (type == 1) {
                reqUrl += "lireq?ms=false&fl=*&field=" + feature + "&id=" + query;
            } else if (type == 2) {
                reqUrl += "lireq?ms=false&fl=*&field=" + feature + "&url=" + query;
            } else if (type == 3) {
                reqUrl += "select?wt=json&df=categories_ws&q=" + query;
            }
            reqUrl += "&rows=" + $("#numResults").val(); // number of results
            if (type != 3) {
                reqUrl += "&accuracy=" + $("#accuracyInput").val();
                reqUrl += "&candidates=" + $("#numCandidatesInput").val();
            }
            console.log(reqUrl);
            $.getJSON(reqUrl, function (myResult) {
                $("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
                $("#results").show();
                $("#perf").show();
                console.log(myResult);
                if (myResult.docs != null)
                    printResults(myResult.docs);
                else
                    printResults(myResult.response.docs);
            });
        } else if (searchType == "mlt") { // if we go more like this ...
            reqUrl += "select?wt=json&mlt=true&mlt.fl=categories_ws&q=id:\"" + query + "\"";
            reqUrl += "&mlt.count=" + $("#numResults").val(); // number of results
            console.log(reqUrl);
            $.getJSON(reqUrl, null, function (myResult) {
                // does not enter the callback function ...
                console.log(myResult.moreLikeThis);
                for (i in myResult.moreLikeThis) {
                    console.log(myResult.moreLikeThis[i]);
                    printResults(myResult.moreLikeThis[i].docs);
                }
            });
        } else if (searchType == "allsort") { // if we go for lirefunc only.
            reqUrl += "lireq?ms=false&field=" + feature + "&extract=" + additionalUrl + "&accuracy=" + $("#accuracyInput").val();
            $.getJSON(reqUrl, function (myResult) {
                $("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
                $("#results").show();
                $("#perf").show();
                console.log(myResult);
                // todo: solve caching problem ...
                var newReqUrl = serverUrlPrefix + "select?wt=json&q=*:*&sort=lirefunc(" + feature + ",%22" + myResult.histogram + "%22)%20asc";
                newReqUrl += "&rows=" + $("#numResults").val();
                console.log(newReqUrl);
                $.getJSON(newReqUrl, function (myResult) {
                    console.log(myResult);
                    printResults(myResult.response.docs);
                });
            });
        } else if (searchType == "hashsort") {
            reqUrl += "lireq?ms=false&field=" + feature + "&extract=" + additionalUrl + "&accuracy=" + $("#accuracyInput").val();
            $.getJSON(reqUrl, function (myResult) {
                $("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
                $("#results").show();
                $("#perf").show();
                console.log(myResult);
                var newReqUrl = serverUrlPrefix + "select?wt=json&q=" + feature + "_ha:(" + myResult.bs_query + ")*&sort=lirefunc(" + feature + ",%22" + myResult.histogram + "%22)%20asc";
                newReqUrl += "&rows=" + $("#numResults").val();
                console.log(newReqUrl);
                $.getJSON(newReqUrl, function (myResult) {
                    console.log(myResult);
                    printResults(myResult.response.docs);
                });
            });
        }

    }

    $(document).ready(function () {
        // add the event handlers ...

        $("#searchUrlQuery").keypress(function (event) {
            if (event.which == 10 || event.which == 13) {
                console.log("URL query: " + $("#searchUrlQuery").val());
                search($("#searchUrlQuery").val(), $("#searchUrlQueryFeature").val(), 2, $("#searchUrlQuery").val());

            }
        });

        $("#searchTextQuery").keypress(function (event) {
            if (event.which == 10 || event.which == 13) {
                console.log("Text query: " + $("#searchTextQuery").val());
                search($("#searchTextQuery").val(), $("#searchUrlQueryFeature").val(), 3, $("#searchUrlQuery").val());

            }
        });


        // get JSON-formatted data from the server
        $.getJSON(serverUrlPrefix + "lireq?rows=" + $("#numResults").val(), function (myResult) {
            $("#perf").html("Index search time: " + myResult.responseHeader.QTime + " ms");
            console.log(myResult);
            printResults(myResult.response);
        });

    });
</script>

<my-navbar></my-navbar>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>LireSolr Demo</h1>
            <p>LireSolr is a library of solr plugin to extract image feature. For more detailed information please visit <a href="https://github.com/dermotte/liresolr" target="_blank">https://github.com/dermotte/liresolr</a></p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div>

                <!-- Nav tabs -->
                <ul class="nav nav-pills" role="tablist">
                    <li role="presentation"><a class="btn btn-default" href="#!/search-by-image/#search" aria-controls="search" role="tab"
                                                              data-toggle="tab">Search Parameters</a></li>
                    <li role="presentation"><a class="btn btn-default" href="#!/search-by-image/#image" aria-controls="image" role="tab" data-toggle="tab">Search
                        by Image</a></li>
                </ul>

                <!-- Tab panes -->
                <form>
                    <fieldset id="searchfieldset">
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="search" style="padding-top:12px">
                                <div class="form-group col-md-6">
                                    <label for="searchTypeSelect" class="control-label">Search method</label>
                                    <select id="searchTypeSelect" class="form-control input-sm">
                                        <option value="lireq">Lire Request Handler</option>
                                        <option value="allsort">Match all documents and sort</option>
                                        <option value="hashsort">Hash filter query and sort</option>
                                        <option value="mlt">More like this on categories</option>
                                        <!--option>Boosted query</option-->
                                    </select>
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="searchUrlQueryFeature" class="control-label">Search feature</label>
                                    <select id="searchUrlQueryFeature" class="form-control input-sm">
                                        <option value="ph">PHOG</option>
                                        <option value="eh">Edge Histogram</option>
                                        <option value="cl">Color Layout</option>
                                        <option value="jc">JCD</option>
                                        <!--option>Boosted query</option-->
                                    </select>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="numResults" class="control-label"># Results</label>
                                    <input type="number" id="numResults" class="form-control input-sm"
                                           min="10" max="500" step="10" value="20"/>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="accuracyInput" class="control-label">Accuracy</label>
                                    <input type="number" id="accuracyInput" class="form-control input-sm" min="0.05"
                                           max="1.00" step="0.05" value="0.35"/>
                                </div>
                                <div class="form-group col-md-3">
                                    <label for="numCandidatesInput" class="control-label"># Candidates</label>
                                    <input type="number" id="numCandidatesInput" class="form-control input-sm"
                                           min="100" max="100000" step="100" value="1000"/>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="image" style="padding-top:12px">
                                <div class="form-group col-md-12">
                                    <label for="searchUrlQuery" class="control-label">Image URL</label>
                                    <input type="text" id="searchUrlQuery" class="form-control input-sm"
                                           placeholder="http://...">
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="text">
                                <div class="form-group col-md-12">
                                    <label for="searchTextQuery" class="control-label">Search query</label>
                                    <input type="text" id="searchTextQuery" class="form-control input-sm"
                                           placeholder="title:*">
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-xs-12" id="results" hidden>
            <h2>Results</h2>
        </div>
        <div class="col-xs-12 text-center" id="waiting" hidden>
            <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="margin-top: 3em"></i>
        </div>
    </div>
    <div class="row grid" id="imagegrid">

    </div>
    <div class="row">
        <div class="col-md-12 text-center" id="perf">&nbsp;</div>
    </div>
</div>

<my-footer></my-footer>
