'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "b86f9c13a975af31e7787ddf85dc0219",
"assets/assets/i18n/en.json": "54e5a1a026314c488eb02ede7a464070",
"assets/assets/i18n/fi.json": "72790c63c6f166a31b585ec7a846c0c3",
"assets/assets/i18n/smn.json": "95e24eaa03deff9ee32a9b3794037345",
"assets/assets/i18n/sv.json": "95e24eaa03deff9ee32a9b3794037345",
"assets/assets/icons/map-cluster-small.svg": "2d00a1cb73c5cb8e202fd74de1a0cf18",
"assets/assets/icons/map_marker.svg": "e520d929e9b943fe70576099da40308c",
"assets/assets/images/frontpage_img.jpg": "f70b7a933ffd48235ee0722b0c042136",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "4c2f619add1fcaf6f0fd43d6167707b3",
"assets/packages/cool_alert/assets/flare/error_check.flr": "d9f54791d0d79935d22206966707e4b3",
"assets/packages/cool_alert/assets/flare/info_check.flr": "f6b81c2aa3ae36418c13bfd36d11ac04",
"assets/packages/cool_alert/assets/flare/loading.flr": "b6987a8e6de74062b8c002539d2d043e",
"assets/packages/cool_alert/assets/flare/success_check.flr": "9d163bcc6f6b58566e0abde7761a67a0",
"assets/packages/cool_alert/assets/flare/warning_check.flr": "ff4a110b8d905dedb4d4639a17399703",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "ec1c618ac5dcebeeecad7f752c9c95b3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b6fd610db7b270f5fd4c13357a6b3977",
"/": "b6fd610db7b270f5fd4c13357a6b3977",
"main.dart.js": "76f3b19703d86c9a09a3acb03c7516b4",
"main.dart.js_1.part.js": "c03aaa889e07283620f075b0de287675",
"main.dart.js_10.part.js": "1c23f7938e7557397b0ce8b2c9c884ca",
"main.dart.js_11.part.js": "ea5a5c42ab448a251f08e7c82a5356a8",
"main.dart.js_12.part.js": "fae991bc87d4974af405f88ea3fe4671",
"main.dart.js_13.part.js": "817efa94f7e68940fba33e77c1260a60",
"main.dart.js_14.part.js": "8192c605b70a94b346c2e7bf9787ef4b",
"main.dart.js_15.part.js": "409864ee7fdc8297e0b10cde6ad9b146",
"main.dart.js_16.part.js": "73f401836c9280f2329c7a7e137acfa9",
"main.dart.js_17.part.js": "7a034bca5a8e6d3fc2e003332997c60f",
"main.dart.js_18.part.js": "090371a46f61c96fbe361bcbe41a72d1",
"main.dart.js_19.part.js": "fdfe7313b43f181e91a1cb21ea8fcfc8",
"main.dart.js_2.part.js": "2c2452c9e6fc309abf133b7d354faa07",
"main.dart.js_20.part.js": "0a0e95b63ae68d6eabed8a99ee4baf6d",
"main.dart.js_21.part.js": "c1bebcdefbfa5d717d0262e089866504",
"main.dart.js_22.part.js": "9f46d5ce887dfb236083ddbcbe3c9879",
"main.dart.js_23.part.js": "ed314b706595f22e27a7fde05efc4d7b",
"main.dart.js_24.part.js": "10ce8f605b2ca4b5a6adfcdfb26f3cc2",
"main.dart.js_25.part.js": "448d54e0f912fac2ea3eb8c4d1830d96",
"main.dart.js_26.part.js": "1a741290a06dcb27825ac1b973ec17bf",
"main.dart.js_27.part.js": "ca8369ad57d005ebc7b7a1d1b8b2535d",
"main.dart.js_28.part.js": "16dd0e41bf19fbad69d6218cb92f2700",
"main.dart.js_29.part.js": "d23edc2002e3b8efc8d388df3205c111",
"main.dart.js_3.part.js": "4bf6043daed4688c1a7381eeac734d63",
"main.dart.js_30.part.js": "d3b6d618000842aab036f6a712a62b04",
"main.dart.js_31.part.js": "faed72b5494e83e8c3e6c9284e4bef25",
"main.dart.js_32.part.js": "bba9a7aeb4d34ba417caa500ed3f39f9",
"main.dart.js_33.part.js": "9f820f22290a236ede0216a4e0d2069f",
"main.dart.js_34.part.js": "5e118cde2754eae0321ab6750719fe02",
"main.dart.js_35.part.js": "dbd7561ce02e70de7851a5c2e7dd5c1b",
"main.dart.js_36.part.js": "2baf355272e4fc6d68f1180b9914b6c4",
"main.dart.js_37.part.js": "3c5b871795bc2232a19e648546baab6d",
"main.dart.js_38.part.js": "e5f0ae2e98f582c372defe3586fd7270",
"main.dart.js_39.part.js": "8dd2a2bac3a6a00af2f576f9cf4a04da",
"main.dart.js_4.part.js": "ae7d8991a49cb388621c39a73a83fd03",
"main.dart.js_40.part.js": "1094e7bab76bbc217de05c9edb851ae9",
"main.dart.js_41.part.js": "70d862ada220c23dbdcfa4d3126b1349",
"main.dart.js_42.part.js": "54dffd2fd9e3b998018def8f816f895a",
"main.dart.js_43.part.js": "0ccc506a1f51e741a37f98d74af3cc58",
"main.dart.js_44.part.js": "12a1de64f659598ecba78fb207581a32",
"main.dart.js_45.part.js": "6cc9ce52da6213c9d2d934e071d59060",
"main.dart.js_46.part.js": "591995deea6d38c547c72ef20a7cb616",
"main.dart.js_47.part.js": "44a4700d961da0f66aa4a1c0d0153362",
"main.dart.js_48.part.js": "ecbb94e0ec27666e47f02da97f1f05c8",
"main.dart.js_49.part.js": "c1eee0fa3d1548db95c2c37c37787901",
"main.dart.js_5.part.js": "3b79ee210c781de3d2cb89ccbebc47d2",
"main.dart.js_50.part.js": "5fb4815cf05aca6b544300a5ef333db6",
"main.dart.js_51.part.js": "84f3994d33e6fa7afdacec3f000d781a",
"main.dart.js_52.part.js": "d90b87f5be6ba33e19b343e9719bacbc",
"main.dart.js_53.part.js": "6d79fac403e7fee0263ce601b83cfc22",
"main.dart.js_54.part.js": "3a36d103580da7892bfc7d8b99b8c6e3",
"main.dart.js_56.part.js": "1ea5f1c5215736835650c846beaf8423",
"main.dart.js_57.part.js": "fdd0d5194fa7df9971fb1dba301782dd",
"main.dart.js_59.part.js": "d8c75e19cdbaefa30ec99ce48ac4897c",
"main.dart.js_6.part.js": "b41eb60a768da69241b9186004d56995",
"main.dart.js_60.part.js": "ca6fbea36c7456d14013e628c38a09cd",
"main.dart.js_62.part.js": "444daf05195ab9cbced0b188c76e473d",
"main.dart.js_63.part.js": "8b0e293408b12c5a87332c574aa295f3",
"main.dart.js_67.part.js": "504ed7671e15605de13b745a8d859699",
"main.dart.js_68.part.js": "ae00667fccbf1ef444130b01a9550cfb",
"main.dart.js_69.part.js": "dcaff68692b1e9207c576ca7fcb8ecad",
"main.dart.js_7.part.js": "d446354a152e5127ccec815a4e66e50f",
"main.dart.js_71.part.js": "7834b36ae81ea411498f8f752fb2c600",
"main.dart.js_72.part.js": "c5d3073f19fa57624d52d2aef32c4b66",
"main.dart.js_73.part.js": "a7a71893c40da8ca7b36c8475f1173a6",
"main.dart.js_74.part.js": "df967fe6a664b9abc70b30709e28e596",
"main.dart.js_76.part.js": "cc1cbd502a7c089ae58100dbf758f81e",
"main.dart.js_77.part.js": "104f39fef9c8beb216a1f5137298a030",
"main.dart.js_79.part.js": "862eb240a6498e06363972647188705a",
"main.dart.js_8.part.js": "eb26a4cc6e623f0d5fa4f8db4f408b09",
"main.dart.js_81.part.js": "3a3514f8a22cc4df2abd509f920fe74c",
"main.dart.js_83.part.js": "7a9f2ba15230ffc75c46c2eb8793b17b",
"main.dart.js_9.part.js": "9eb67fca09cd8fe6d8389d8659f23419",
"manifest.json": "9ba4aa463c0ea36fa66cbd5e615d341c",
"styles.css": "f4a6d5385d202cf39a5ca85a75403067",
"version.json": "84e8244329dbff0983e637ef205e0921"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
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
