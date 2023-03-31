'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"version.json": "6a959a2fedfdf2d3adb1a71bcd98ab27",
"main.dart.js": "8ec0dff3b9559091f3e6eadc97bca8ec",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons%20copy/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons%20copy/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons%20copy/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons%20copy/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "a120d913439b9c2cea1e2da58d8412fd",
"favicon%20copy.png": "5dcef449791fa27946b3d35ad8803796",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "6198fef177566bfc37baec186896aee9",
"assets/NOTICES": "2220b992d80991e6e681a7d5eb06e315",
"assets/image_2.jpg": "47d678dd0288bb49a1c80c500203b630",
"assets/shaders/ink_sparkle.frag": "450f915059eb6b973f9ae9be0ba160fb",
"assets/AssetManifest.json": "7f54fae80f3363b922337d304baab45b",
"assets/assets/image_1.jpg": "e69de6c13cec5a08683559672dc1d1a2",
"assets/assets/app/app-release.apk": "a5f4c3cbcd1814aed0068e7acfa0a035",
"assets/assets/monster-10.png": "7587f96c36a0a8e37675cdebf12f4575",
"assets/assets/monster-6.png": "281f6db4ec2f54b1a595e4e55b61e1c6",
"assets/assets/image_6.jpg": "1d8162c14d871303420c903281e6f072",
"assets/assets/image_5.jpg": "d9ce37a06aae1ba124def6fa361a6193",
"assets/assets/monster-7.png": "3a2fa9e3c32a1fdd45b662077e93bb9a",
"assets/assets/image_2.jpg": "47d678dd0288bb49a1c80c500203b630",
"assets/assets/monster-4.png": "ee46394cf9d06075a39f4428a94e2c64",
"assets/assets/monster-8.png": "8820ba371957aaf5a963ccd9a8a2376a",
"assets/assets/image_3.jpg": "f65171ec1bd56a6769e12cc953f613dc",
"assets/assets/image_4.jpg": "b5ad9a220cfc588c3665cb77c47133ea",
"assets/assets/GSP-logo.png": "1374c4d147b27fe461635c2296572d21",
"assets/assets/monster-19.png": "e30ea5b63258273753ae18f7e8cfb0a4",
"assets/assets/fonts/RockoFLF.ttf": "072bff49d3ebbc7543f3796ca611a34f",
"assets/assets/fonts/Bello-Script.ttf": "d5bfd2106ebb712542d805ed474a3863",
"assets/assets/fonts/Feather-Bold.ttf": "14936bb7a4b6575fd2eee80a3ab52cc2",
"assets/assets/fonts/Feather-Write.ttf": "b86054b7c34906b8b1abbcb55f77928a",
"assets/fonts/RockoFLF.ttf": "072bff49d3ebbc7543f3796ca611a34f",
"assets/fonts/Bello-Script.ttf": "d5bfd2106ebb712542d805ed474a3863",
"assets/fonts/Feather-Bold.ttf": "14936bb7a4b6575fd2eee80a3ab52cc2",
"assets/fonts/Feather-Write.ttf": "b86054b7c34906b8b1abbcb55f77928a",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"index.html": "f23810a52f5ab0cd06ae05a54564e609",
"/": "f23810a52f5ab0cd06ae05a54564e609",
"fonts/RockoFLF.ttf": "072bff49d3ebbc7543f3796ca611a34f",
"fonts/Bello-Script.ttf": "d5bfd2106ebb712542d805ed474a3863",
"fonts/Feather-Bold.ttf": "14936bb7a4b6575fd2eee80a3ab52cc2",
"fonts/Feather-Write.ttf": "b86054b7c34906b8b1abbcb55f77928a"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
