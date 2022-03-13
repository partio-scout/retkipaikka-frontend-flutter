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
"index.html": "e3e7a163964a44e41aa39b7c0fdda039",
"/": "e3e7a163964a44e41aa39b7c0fdda039",
"main.dart.js": "263d38989d8c7c90192a2c711e6955a4",
"main.dart.js_1.part.js": "f2c61c902e74f36187d1d6a737ae0923",
"main.dart.js_10.part.js": "9b9534e983a8b0103aa8a8b53023c82a",
"main.dart.js_11.part.js": "2f8bbdd8a744a8d089fd062118838d96",
"main.dart.js_12.part.js": "1d40652606c6ebdc59f087eac0cb7a36",
"main.dart.js_13.part.js": "d950ae2547cd7cb2f1b80e498f682382",
"main.dart.js_14.part.js": "a93bb545fcba1ff185564a45cd940665",
"main.dart.js_15.part.js": "55ae8278b6ab0d701d5a97de9d290c66",
"main.dart.js_16.part.js": "48633bb65ef9b08586bdb81ec945d1d8",
"main.dart.js_17.part.js": "af596de6de5fcc415e3eeef02af046dc",
"main.dart.js_18.part.js": "8ed789100145e330661adca921b277dd",
"main.dart.js_19.part.js": "a3c6f1eda4da123b4a91f2f0a45fe0a8",
"main.dart.js_2.part.js": "597164cca74e7fd160135df7db9f602c",
"main.dart.js_20.part.js": "37771918c04f77376f8e3dca4d4791ee",
"main.dart.js_21.part.js": "3b359cdd93a807e76827a402b52c9dd1",
"main.dart.js_22.part.js": "9f46d5ce887dfb236083ddbcbe3c9879",
"main.dart.js_23.part.js": "921b36c3aa73a4bbcf9f0abd3a4027fa",
"main.dart.js_24.part.js": "f405a31b40f9044be63f8b5b7d99f679",
"main.dart.js_25.part.js": "8c613861b91bfd2284a309176f159911",
"main.dart.js_26.part.js": "74bd71180580b7816dc26fa92b1eb97d",
"main.dart.js_27.part.js": "68b71ae2f2b6f9693aff9da9ab8e3fc3",
"main.dart.js_28.part.js": "888f7759b40f683733a90d5e02c5af40",
"main.dart.js_29.part.js": "442af919edb89e719d019b35d0e11f8b",
"main.dart.js_3.part.js": "73d5396cad0a19b57cafda3796dded01",
"main.dart.js_30.part.js": "294749d41f6f8616f8d307b6a4064bb4",
"main.dart.js_31.part.js": "9501af5c148036ae3fd73124a4a97fd8",
"main.dart.js_32.part.js": "68b49434f874a9ea62a66691a381c72f",
"main.dart.js_33.part.js": "500ac7b511932144ea68a0857b3d9439",
"main.dart.js_34.part.js": "5de0a209ca068bbb1c32db47f21e89d9",
"main.dart.js_35.part.js": "cd10676748a7390b262955f994ddcda1",
"main.dart.js_36.part.js": "5056b94e813913bfb4fa1b1c8abb218a",
"main.dart.js_38.part.js": "8d0b88b6a12647653dec8ad1031a9c06",
"main.dart.js_39.part.js": "1094e7bab76bbc217de05c9edb851ae9",
"main.dart.js_4.part.js": "6621acf55b1c8f40a7ce152173da2594",
"main.dart.js_40.part.js": "2e2412b9a59a5cbb4f0c80fb02881ae9",
"main.dart.js_41.part.js": "1ca60191ecea51b32c1eb392b946cc2a",
"main.dart.js_42.part.js": "9c306e6d8cb3c3abc1ef5903d443246c",
"main.dart.js_43.part.js": "8f797fe204b93ddf5983e794605703df",
"main.dart.js_44.part.js": "dd4da04421661bb8ca710049ffa93ff5",
"main.dart.js_45.part.js": "36c03211cd62ab6fa96c51b3f8d9df48",
"main.dart.js_46.part.js": "bbf49573c5cc853f89c52c0453753fab",
"main.dart.js_47.part.js": "d3b441a2cbcde404e85d5091db8edb70",
"main.dart.js_48.part.js": "766bb0ba6ea0d85e8f9305178d3d352c",
"main.dart.js_49.part.js": "b8ae4fd4ba6145e280bc9b8fc2b4ce6a",
"main.dart.js_5.part.js": "ec67195171fc950462e91549ce446b65",
"main.dart.js_50.part.js": "5fb4815cf05aca6b544300a5ef333db6",
"main.dart.js_51.part.js": "84f3994d33e6fa7afdacec3f000d781a",
"main.dart.js_52.part.js": "d90b87f5be6ba33e19b343e9719bacbc",
"main.dart.js_53.part.js": "6d79fac403e7fee0263ce601b83cfc22",
"main.dart.js_54.part.js": "3a36d103580da7892bfc7d8b99b8c6e3",
"main.dart.js_56.part.js": "1ea5f1c5215736835650c846beaf8423",
"main.dart.js_57.part.js": "fdd0d5194fa7df9971fb1dba301782dd",
"main.dart.js_59.part.js": "d8c75e19cdbaefa30ec99ce48ac4897c",
"main.dart.js_6.part.js": "16400c3577bc2f7211d662b68f4edc10",
"main.dart.js_60.part.js": "ca6fbea36c7456d14013e628c38a09cd",
"main.dart.js_62.part.js": "444daf05195ab9cbced0b188c76e473d",
"main.dart.js_63.part.js": "8b0e293408b12c5a87332c574aa295f3",
"main.dart.js_67.part.js": "504ed7671e15605de13b745a8d859699",
"main.dart.js_68.part.js": "ae00667fccbf1ef444130b01a9550cfb",
"main.dart.js_69.part.js": "dcaff68692b1e9207c576ca7fcb8ecad",
"main.dart.js_7.part.js": "7ded7d621dceb66266287cd8ad39c47c",
"main.dart.js_71.part.js": "7834b36ae81ea411498f8f752fb2c600",
"main.dart.js_72.part.js": "c5d3073f19fa57624d52d2aef32c4b66",
"main.dart.js_73.part.js": "a7a71893c40da8ca7b36c8475f1173a6",
"main.dart.js_74.part.js": "df967fe6a664b9abc70b30709e28e596",
"main.dart.js_76.part.js": "cc1cbd502a7c089ae58100dbf758f81e",
"main.dart.js_77.part.js": "104f39fef9c8beb216a1f5137298a030",
"main.dart.js_79.part.js": "862eb240a6498e06363972647188705a",
"main.dart.js_8.part.js": "7f61194e6e1686336dd963b750ef2864",
"main.dart.js_81.part.js": "3a3514f8a22cc4df2abd509f920fe74c",
"main.dart.js_83.part.js": "7a9f2ba15230ffc75c46c2eb8793b17b",
"main.dart.js_9.part.js": "7c285b58c2bea6e5e8cf6c1c12890b3b",
"manifest.json": "9ba4aa463c0ea36fa66cbd5e615d341c",
"styles.css": "66371e182122e11c732bc58e1b9724cd",
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
