'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"version.json": "89978f640d6fcff28e2911f8f170fb36",
"main.dart.js": "35e6ead8530755e8df57175d9e01a454",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "daa17102cdb9465a9768f1ef7c396612",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "f162c865571564f082ae0fbd7f13a3f9",
"assets/shaders/ink_sparkle.frag": "450f915059eb6b973f9ae9be0ba160fb",
"assets/AssetManifest.json": "01f6a0c2b48b6e43d7c1218ddf769acd",
"assets/assets/images/ai-icon-7.png": "8ec1262abe9edaa7dea4bc5959e49352",
"assets/assets/images/image1.png": "879f9aa85f46007c55888b9b41c075f8",
"assets/assets/images/ai-icon-white-8.png": "be79028624811c9ccaa88b330d833853",
"assets/assets/images/ai-icon-white-6.png": "3535476d684d063dc545de17be6cdaee",
"assets/assets/images/ai-icon-3.png": "0374046c32c28b6a3ef21026f7d909c6",
"assets/assets/images/meeting-icon.png": "d1b4d175d80780f52a7d08d0a8bdf537",
"assets/assets/images/ai-icon-white-4.png": "6df4248d7d8be80c2ec80d0829c95145",
"assets/assets/images/chart-icon.png": "e200056b9678e8f89f4bef3eb0379369",
"assets/assets/images/attachment-icon.png": "e7daac77a0031efd27058461cd6ad941",
"assets/assets/images/ai-icon-white-11.png": "5f81e7b20836d4f1119b9de144f07def",
"assets/assets/images/man-11.png": "ff4280d0f5e48aef3f09dce7b45f0dba",
"assets/assets/images/ai-icon-1.png": "4407f5e35829cbf5ef80080caa2cc5f0",
"assets/assets/images/TEAMS.png": "109e052b23e4658c3589b61675352c54",
"assets/assets/images/man-12.png": "e77acb222b8193f645754272e9171550",
"assets/assets/images/ai-icon-4.png": "cbb03a3a2efcd9396dafb38026a8f0b5",
"assets/assets/images/AI_Button.png": "3b24b1a158d3b1eff94620d2cb448b16",
"assets/assets/images/man-7.png": "7f36c2d1ad521864d29429d2888ff0a3",
"assets/assets/images/man-3.png": "5e932765f70bdb0ce2f72fbb803f2256",
"assets/assets/images/person-icon.png": "2ac97cdc248d7b8df82ebc65a58a7dda",
"assets/assets/images/image2.png": "68665bec3bf3c3739ee5228c4febca7d",
"assets/assets/images/ai-icon-white-2.png": "cb789a82fd4f9e1df5fedc35f70159ec",
"assets/assets/images/ai-icon-9.png": "084cff06d1a0b91c79422194d5e6817c",
"assets/assets/images/man-9.png": "dc94fe279ffb6d7a6ff2f9400d449684",
"assets/assets/images/man-16.png": "dffd663ac4fff746d4d22beca2fd8d38",
"assets/assets/images/Zoom.png": "4455b4b026d0d3691298b87398af1729",
"assets/assets/images/man-8.png": "ba32596d3733ff9b887063749c4d0acd",
"assets/assets/images/meeting-white-icon.png": "31ea27ab428cc5aeeb601d63a8c3e66a",
"assets/assets/images/ai-icon-5.png": "fa9f81ae1dfd00e4c5bcc54637f66786",
"assets/assets/images/man-4.png": "11b174d6e0aef663cdf8a87d39cced72",
"assets/assets/images/group-icon.png": "99911335612c52d144e5caee9477a675",
"assets/assets/images/man-1.png": "99ba6ed9f4aae96b0ae96ddddcb11651",
"assets/assets/images/ai-icon-10.png": "7264b2876eb23b0f42083b799c5d9028",
"assets/assets/images/man-5.png": "64a0acafdd8862b300a380d70a555cea",
"assets/assets/images/man-17.png": "4a997b3585008668eb60f93f4fd95c14",
"assets/assets/images/man-13.png": "1f0d95eb0b8565b345f012b29a713e9a",
"assets/assets/images/ai-icon-white-3.png": "e734b2d030f8581b469f6eb00b83f4a9",
"assets/assets/images/man-2.png": "4a997b3585008668eb60f93f4fd95c14",
"assets/assets/images/man-6.png": "b6ec0f52723bf3344b5b16f6d971cdbc",
"assets/assets/images/ai-icon-white-7.png": "77d962bb5add80a287acffef62c23372",
"assets/assets/images/woman-3.png": "3c695f450d7765eaaccbee1a53db8798",
"assets/assets/images/remote-icon.png": "9304ac302f4435b8a1c4489a2e983f74",
"assets/assets/images/ai-icon-6.png": "6026570609aebd56bef6a38335309a21",
"assets/assets/images/man-10.png": "36f05f340eb72a000a156fc3f087213b",
"assets/assets/images/MEET.png": "29aa0e7b625ec24e0b5d1230eef63f48",
"assets/assets/images/ai-icon-white-9.png": "b0d37c770095aac9de293f6476c7cce5",
"assets/assets/images/ai-icon-white-10.png": "fc49dc541d9c327bea9437366df7f884",
"assets/assets/images/camera.png": "76b0ca893dc67c61946e95feb3d61e23",
"assets/assets/images/ai-icon-white-5.png": "552c3a354288256f38d419bad8176792",
"assets/assets/images/ai-icon-white-1.png": "48d27451738bf8b3c8f307b6cdb98984",
"assets/assets/images/man-15.png": "8886466813ebcf71b84e564f65e1d0b8",
"assets/assets/images/WEBex.png": "213605fe610563219d3efd60f1e9a25d",
"assets/assets/images/man-14.png": "186e28004b7cffda34e220b21044e102",
"assets/assets/images/ai-icon-8.png": "9ca4d349aebd0ed3ad6ca6bf875e33bb",
"assets/assets/images/ai-icon-2.png": "f6f2e3d51fd96ade67ca6270b2033762",
"assets/assets/images/send-message-icon.png": "ac37290f0fb5caa47d459c8f19223ae5",
"assets/assets/images/ai-icon-11.png": "a262a5e469947a2c961ab552a0e7db49",
"assets/assets/images/woman-3-1.png": "389e7ddf7b39e11441268ffc39f2e3bc",
"assets/assets/images/checkmark-circle.png": "a24dba7456c9b2d52df1eeba1f0e0f2f",
"assets/assets/animations/piggy_bank.json": "cb28469a63da81ee30c157de4995e30b",
"assets/assets/animations/bird.json": "613a1d4786a4e9042edf022cab6fe31e",
"assets/assets/animations/chameleon.json": "36a5599eb1644c699d168b6b67ef148e",
"assets/assets/animations/giraffe.json": "a2d027ea69ba585ed7d1539de83e0f38",
"assets/assets/animations/dog.json": "ce955622d0180fa14c6b5e726dd41ba4",
"assets/assets/question.png": "4394095d9e6f3e54a56741b9df1588dc",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"index.html": "df4d740ddd31badd36e3003375392f31",
"/": "df4d740ddd31badd36e3003375392f31"
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
