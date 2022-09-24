'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "b86f9c13a975af31e7787ddf85dc0219",
"assets/assets/i18n/en.json": "9d3ab1af5e89b639c9e6dec0888f72f6",
"assets/assets/i18n/fi.json": "27a3251ab481154b667c970807244d82",
"assets/assets/i18n/smn.json": "db840f26ecb2b9cdb8e8084700efc98d",
"assets/assets/i18n/sv.json": "db840f26ecb2b9cdb8e8084700efc98d",
"assets/assets/icons/map-cluster-small.svg": "2d00a1cb73c5cb8e202fd74de1a0cf18",
"assets/assets/icons/map_marker.svg": "e520d929e9b943fe70576099da40308c",
"assets/assets/images/frontpage_img.jpg": "f70b7a933ffd48235ee0722b0c042136",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "6699ad82cd5abe8f1eda459c471ccc51",
"assets/packages/cool_alert/assets/flare/error_check.flr": "d9f54791d0d79935d22206966707e4b3",
"assets/packages/cool_alert/assets/flare/info_check.flr": "f6b81c2aa3ae36418c13bfd36d11ac04",
"assets/packages/cool_alert/assets/flare/loading.flr": "b6987a8e6de74062b8c002539d2d043e",
"assets/packages/cool_alert/assets/flare/success_check.flr": "9d163bcc6f6b58566e0abde7761a67a0",
"assets/packages/cool_alert/assets/flare/warning_check.flr": "ff4a110b8d905dedb4d4639a17399703",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "ec1c618ac5dcebeeecad7f752c9c95b3",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"icons/Icon-192.png": "d9b15672bdefe5834eb7f7b887a8a382",
"icons/Icon-512.png": "93907d8228581a083678a5755a6a9093",
"icons/Icon-maskable-192.png": "d9b15672bdefe5834eb7f7b887a8a382",
"icons/Icon-maskable-512.png": "93907d8228581a083678a5755a6a9093",
"index.html": "470b1556651371ed681930509b700ba9",
"/": "470b1556651371ed681930509b700ba9",
"main.dart.js": "0ec2378788b02b7bb172dc15c5544d30",
"main.dart.js_1.part.js": "5f14c246ff1dfad02cb5eca49cf2b44f",
"main.dart.js_10.part.js": "a61cb3d52ba0991d6659448b9ab5d50e",
"main.dart.js_11.part.js": "ed9d620aea3b5b623236511726de7859",
"main.dart.js_12.part.js": "2511b6c94a62e242cbce237a2d7acf84",
"main.dart.js_15.part.js": "843597ecf64bc7e7fbf4e6a799133a22",
"main.dart.js_17.part.js": "29f4d28137b34f9aa88e695b79388e14",
"main.dart.js_18.part.js": "ca5d396376f8d7b3aafba02be3de6862",
"main.dart.js_19.part.js": "2d581ce695bcaf6ea2ccf86dc03c4a35",
"main.dart.js_2.part.js": "2d06658bbc09868bcce2e0ae5bcd76b9",
"main.dart.js_20.part.js": "e789bdc73b01e619399ed0f2cf43a682",
"main.dart.js_21.part.js": "163d805d07c99dad127fcce6c94a550f",
"main.dart.js_22.part.js": "c0f6f7d75754fbe0ddcc6ad68ba0b159",
"main.dart.js_24.part.js": "2434a1a73b0f247ca54ccfc6e8de561a",
"main.dart.js_26.part.js": "625482053a70675bae78de57b9e733d2",
"main.dart.js_27.part.js": "40cfeb9a603f8dbb54c5c1a870b90593",
"main.dart.js_28.part.js": "6dc2979c4e36cec45244048d5ef159cb",
"main.dart.js_29.part.js": "83dfd98a7da85f8f1d92a9e4174be971",
"main.dart.js_3.part.js": "b359688cbe28615920eb39033818efdd",
"main.dart.js_31.part.js": "c6a2570b6f13435c9e7f6598491fda5b",
"main.dart.js_32.part.js": "00be0d5f67bf8e7086288e48b31ca03f",
"main.dart.js_33.part.js": "3d21193cf7db6297cd5d8685e868c6f0",
"main.dart.js_34.part.js": "dc7daf995590c3c85e8c10c5dcc195ea",
"main.dart.js_36.part.js": "cd922f09c6e993453f84d82636448958",
"main.dart.js_37.part.js": "60f596b5aaf5bad48164c74e1def2838",
"main.dart.js_38.part.js": "3b86bd5a9657ed38526067f050adcea9",
"main.dart.js_39.part.js": "299419ed67f99b7fb4b9b3b9b0dc2861",
"main.dart.js_4.part.js": "f76ec8aec472b0a82cea9652b137f4c3",
"main.dart.js_41.part.js": "e673fa1988d37107c60dc652320e835f",
"main.dart.js_42.part.js": "7cd547909fa7ee968934ab4253626384",
"main.dart.js_43.part.js": "49f14997f642795eef0c49e1ab063a03",
"main.dart.js_5.part.js": "c0e2397cfcf08b459c484c62398de82e",
"main.dart.js_6.part.js": "e6a747578717e352d13f62fea492f2c7",
"main.dart.js_7.part.js": "c7e627f70e033a20a51a1bd06c21e3f7",
"main.dart.js_8.part.js": "f911f4dec763c456db71d8a6c36a6610",
"main.dart.js_9.part.js": "8067cecebc6b0232034865b902a3b190",
"manifest.json": "eacb15a9079a829c51af65bf70400c9e",
"styles.css": "f4a6d5385d202cf39a5ca85a75403067",
"version.json": "84e8244329dbff0983e637ef205e0921"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
