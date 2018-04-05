(function (window) {
    window.__env = window.__env || {};

    // API url
    window.__env.apiUrl = 'http://dev.your-api.com';
    window.__env.coreApiUrl = 'http://localhost:8080';
    window.__env.videoBase = '/api/videos';

    // Base url
    window.__env.baseUrl = '/';

    // Whether or not to enable debug mode
    // Setting this to false will disable console output
    window.__env.enableDebug = true;
}(this));