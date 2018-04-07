(function (window) {
    window.__env = window.__env || {};

    // API url
    window.__env.apiUrl = 'http://dev.your-api.com';
    window.__env.coreApiUrl = 'http://localhost:8080';

    // Base url
    window.__env.baseUrl = '/';
    window.__env.videoBase = '/api/videos';
    window.__env.imageBase = '/api/images';
    window.__env.searchBase = '/api/search';

    // Keyword
    window.__env.addVideo = '/add';
    window.__env.detect = '/detect';
    window.__env.searchVideo = '/video';
    window.__env.searchImage = '/image';

    // Whether or not to enable debug mode
    // Setting this to false will disable console output
    window.__env.enableDebug = true;
}(this));