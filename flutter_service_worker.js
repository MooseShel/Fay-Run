'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "e92b8bcb637683d9b86f0f5bef86a19d",
"main.dart.mjs": "708732cdf0d0c182165e2a08a61f0a4a",
"index.html": "cc5a68cadaab6ee4bedf5b56ffb7ca89",
"/": "cc5a68cadaab6ee4bedf5b56ffb7ca89",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "52172d148ecae99c729611ad75cb65ff",
"assets/assets/images/ernie.png": "f994d220040069c6e690b5241a4cba42",
"assets/assets/images/obstacle_bucket_2.png": "ad5a9c6fae335c66c845bf2943731b68",
"assets/assets/images/obstacle_puddle_2.png": "f0ff9c26e843108aa1d23d1f176892aa",
"assets/assets/images/staff_science.jpg": "e43041a894767da6e20bfb465b61374e",
"assets/assets/images/staff_head.jpg": "d533d343aed74e49cd5ddba097fde555",
"assets/assets/images/ernie_run.png": "734569e2d38aea6286db67d5da32079c",
"assets/assets/images/obstacle_cone_2.png": "d817fc12b7856b9759d123736dbd6417",
"assets/assets/images/obstacle_books_2.png": "75200660f197a0dfdc8bc7ecaa8db917",
"assets/assets/images/staff_pe.png": "d8f1aa60ec0535beb22067b062c6826c",
"assets/assets/images/staff_librarian.jpg": "1b7f5ef3cfbb2c842b9e8df575262461",
"assets/assets/images/obstacle_log.png": "6b84e3dfd7acf4a077aa6fb7e7612d23",
"assets/assets/images/bg_carpool.png": "3a85aa4e738706579d051d753a02c0a5",
"assets/assets/images/obstacle_log_2.png": "19ed89e7dfa3b94c21cdef4bfdd7b070",
"assets/assets/images/ernie_crash.png": "9db0f595e015d10df04e427c2cf88053",
"assets/assets/images/obstacle_food_2.png": "360e06240d8e97a00ba2f02395b1cdd6",
"assets/assets/images/obstacle_puddle.png": "01b7adc670bb9a57c63ff4de1b5560c8",
"assets/assets/images/obstacle_rock_2.png": "fe6a150f412d27cecb131fdae35f687b",
"assets/assets/images/obstacle_suv_2.png": "63db71d734f83028fec073f1bae32553",
"assets/assets/images/obstacle_suv.png": "3dca483038eb351c932e955ef9706f94",
"assets/assets/images/staff_coach.jpg": "ffebd7465867f0da37f8e7a909bd8dc5",
"assets/assets/images/obstacle_rock.png": "ffad3ccc5b48c31b7c0b01afbb235985",
"assets/assets/images/ernie_jump.png": "f994d220040069c6e690b5241a4cba42",
"assets/assets/images/bg_layer_trees.png": "1d211e070680b6280f0711ac3cef617b",
"assets/assets/images/item_golden_book.png": "1cb12ba6f06448c79dfa617cd233bc8c",
"assets/assets/images/staff_dean.jpg": "29098ba48ad5d0e66dd76dd50a53ffab",
"assets/assets/images/obstacle_books.png": "3aafe5947030ede819848bb956b1154b",
"assets/assets/images/obstacle_food.png": "94d5a916caf8f8c6fa06bc0e7584bea2",
"assets/assets/images/bg_cafeteria.png": "d4a56dc0a61fa2b7c2f69fab81693a57",
"assets/assets/images/obstacle_bucket.png": "9fb30f2610f93eea8a310e7814b9043a",
"assets/assets/images/obstacle_cone.png": "279c4044bcad5980003063f785360528",
"assets/assets/images/bg_science_lab.png": "2b2079714887a9e2e483ef485dae70e6",
"assets/assets/images/bg_layer_lockers.png": "fb3cf630ca1fb40f3d274c42eda78ff0",
"assets/assets/images/ernie_run_2.png": "6a5aaadc7bbc5e3d1727be503e47b723",
"assets/assets/audio/ding.mp3": "49f022c2efd0ac6d8a248a42b41a66e2",
"assets/assets/audio/staff_coach.mp3": "9f440f5c489f83f6bc1ec0bcf8f1d9fa",
"assets/assets/audio/bonk.mp3": "7fcb8aec6a84ed7045db95f7eff16db9",
"assets/assets/audio/jump.mp3": "915822522d1618433c16283c1ca3688c",
"assets/assets/audio/music_hallway.mp3": "86a899c95520c8dc2b829ed537f47023",
"assets/assets/audio/staff_pe.mp3": "a5add550c75d42dda9a7eb82240d5d88",
"assets/assets/audio/staff_dean.mp3": "b940b60fc8272d3a10b7894aac248063",
"assets/assets/audio/music_cafeteria.mp3": "a964cb47e998cdd1bb60edf901c63791",
"assets/assets/audio/music_carpool.mp3": "541f43f1a4f7d20069d02213896f32cd",
"assets/assets/audio/music_bayou.mp3": "291f1b0cc5656777785d780edea5a307",
"assets/assets/audio/staff_head.mp3": "9612c7cfc5037558dd6b4f81ca0c69c7",
"assets/assets/audio/staff_science.mp3": "ccb390041319c92246b0e0fd72fda30d",
"assets/assets/audio/staff_librarian.mp3": "290691422e7abecb56c6338c4092791b",
"assets/assets/audio/powerup.mp3": "610d5cb803804fd42b4ceaacfee7c3f3",
"assets/assets/audio/music_lab.mp3": "dd2c504d974b0aba79a53cb9498b2615",
"assets/fonts/MaterialIcons-Regular.otf": "4a82412e6e5d88dcb5f0ef199b8c34a5",
"assets/NOTICES": "f254c8b0934740fdcd4e895c8a00b3a2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "de52faaba36930f5f2431cf5b97edf97",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.wasm": "f9f8313f9d6c2388b2f3d412d03651b4",
"flutter_bootstrap.js": "859cf4d2829fb9d816e74c4be26e420b",
"version.json": "c41982e2534aa0d199b69d529a91d374",
"main.dart.js": "808c231cf390ef1a607f589381f84299"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
