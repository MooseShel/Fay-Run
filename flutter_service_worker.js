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
"assets/AssetManifest.bin.json": "d7eb79c5fc51bf8c9ea69817c2f9eef0",
"assets/assets/images/ernie.png": "f994d220040069c6e690b5241a4cba42",
"assets/assets/images/bgs/bg_fay_10.webp": "603bd2b69e636574a15bcf5188f1ba92",
"assets/assets/images/bgs/bg_fay_1.webp": "65388d8270a5c02b5c866e7309f9da6b",
"assets/assets/images/bgs/bg_fay_3.webp": "3de96bd230079af92b84db854059ebf9",
"assets/assets/images/bgs/bg_fay_5.webp": "e2f4ddddb61656770bfdafb6fd48fa78",
"assets/assets/images/bgs/bg_fay_8.webp": "fab76423bdc108d3e8e5b7fc0c1d7b29",
"assets/assets/images/bgs/bg_fay_4.webp": "c68fbbc89c5c4ba1ebd7c319b6be6fa8",
"assets/assets/images/bgs/bg_fay_7.webp": "c7a9851bed764f1b5d760f4c775d65d0",
"assets/assets/images/bgs/bg_fay_6.webp": "3399fbfe93657ca28e3222aa3e0abaf5",
"assets/assets/images/bgs/bg_fay_9.webp": "d2704ed9685fa7dcb34b35f51d6892cc",
"assets/assets/images/bgs/bg_fay_2.webp": "4668cf36cc069fbbae46b23c10f81c26",
"assets/assets/images/ernie_run.png": "cd6d56c76a585a36ce7f718e9d4293ff",
"assets/assets/images/ernie_crash.png": "9db0f595e015d10df04e427c2cf88053",
"assets/assets/images/ernie_run_3.png": "734569e2d38aea6286db67d5da32079c",
"assets/assets/images/ernie_jump.png": "f994d220040069c6e690b5241a4cba42",
"assets/assets/images/staff/staff_english.webp": "e24bd3fc604cecb2b52ce0b3984bb7cb",
"assets/assets/images/staff/staff_coach.webp": "daec398c12f756739ddb572025f04859",
"assets/assets/images/staff/staff_prek2.webp": "9ebc27be54f2fc5d358263d35dd71d60",
"assets/assets/images/staff/staff_pe.webp": "d0301d9a32a5880070e56c8b57bfaddc",
"assets/assets/images/staff/staff_firstg.webp": "efa3f4f9ad4ac429ac1f9ca23da06e1e",
"assets/assets/images/staff/staff_head.webp": "faad057834c442489fdb842d9cbd1952",
"assets/assets/images/staff/staff_dean.webp": "f4ac7420ee86ccf4064875d162d2bdd6",
"assets/assets/images/staff/staff_librarian.webp": "93927544e4d677d49c8611a1bcd9eeac",
"assets/assets/images/staff/staff_science.webp": "ab7b718ec01bda5e496dc2d79c13a4d6",
"assets/assets/images/obstacles/obstacle_gym_mat_2.png": "3587c02223a318ba61029f1f45c58dd2",
"assets/assets/images/obstacles/obstacle_milk_cart_1.png": "7e8b1c12386ac7638ba06d12ad587cc7",
"assets/assets/images/obstacles/obstacle_apple.png": "1ae6096e0e0a59494eaeb1e415f43633",
"assets/assets/images/obstacles/obstacle_basket_ball_1.png": "c95337149bcc4c80c510ed5cc9e9a988",
"assets/assets/images/obstacles/obstacle_burger_1.png": "83c2392527217738bcb8d60b9ea17502",
"assets/assets/images/obstacles/obstacle_gym_mat_1.png": "c2530909849c19324117587dfeda5bbf",
"assets/assets/images/obstacles/obstacle_flower_pot_2.png": "45cf899d8a73b19dfdc30942e0aa7f6d",
"assets/assets/images/obstacles/obstacle_wild_flowers_1.png": "0b86f000a0c011e9fa7a7740cefe3c73",
"assets/assets/images/obstacles/obstacle_bucket_2.png": "ad5a9c6fae335c66c845bf2943731b68",
"assets/assets/images/obstacles/obstacle_puddle_2.png": "f0ff9c26e843108aa1d23d1f176892aa",
"assets/assets/images/obstacles/obstacle_bench_2.png": "cfdcb0636140016e7df0276235987584",
"assets/assets/images/obstacles/obstacle_backpack.png": "3218aa1a3b55fbec7cee6a113e2d2174",
"assets/assets/images/obstacles/obstacle_cone_2.png": "d817fc12b7856b9759d123736dbd6417",
"assets/assets/images/obstacles/obstacle_books_2.png": "75200660f197a0dfdc8bc7ecaa8db917",
"assets/assets/images/obstacles/obstacle_lunch_tray_2.png": "9f0e489520f1bfcb8bf5483b44d62b4e",
"assets/assets/images/obstacles/obstacle_milk_cart_3.png": "ab931a3e2da46c47b2de7472cc1b6162",
"assets/assets/images/obstacles/obstacle_gnome_1.png": "d3180fb92e6dfff941f1495d9996044b",
"assets/assets/images/obstacles/obstacle_log.png": "6b84e3dfd7acf4a077aa6fb7e7612d23",
"assets/assets/images/obstacles/obstacle_hydrant_2.png": "b9cfbfcc0f17ea3efda20f993357261a",
"assets/assets/images/obstacles/obstacle_log_2.png": "19ed89e7dfa3b94c21cdef4bfdd7b070",
"assets/assets/images/obstacles/obstacle_soccer_ball_1.png": "70a52a58d5069bb95eab6137f9db86ba",
"assets/assets/images/obstacles/obstacle_food_2.png": "360e06240d8e97a00ba2f02395b1cdd6",
"assets/assets/images/obstacles/obstacle_basket_ball_2.png": "722ea88f4662988c3a23475721887e88",
"assets/assets/images/obstacles/obstacle_puddle.png": "01b7adc670bb9a57c63ff4de1b5560c8",
"assets/assets/images/obstacles/obstacle_gnome_2.png": "b54e2485ad1b4b545f1ff5c2cdc9cb84",
"assets/assets/images/obstacles/obstacle_flower_pot_1.png": "dd9d5138bc7d1506365fdd6a3bfb0d1f",
"assets/assets/images/obstacles/obstacle_rock_2.png": "fe6a150f412d27cecb131fdae35f687b",
"assets/assets/images/obstacles/obstacle_lunch_tray_1.png": "5c888ac4b41a24ccdee1fecc863ec0d2",
"assets/assets/images/obstacles/obstacle_tire_2.png": "c18e54eec257a9e0c12476bd5309f751",
"assets/assets/images/obstacles/obstacle_burger_2.png": "a47fdb4374e8fc6cd0545f5f2149eb3e",
"assets/assets/images/obstacles/obstacle_soccer_ball_2.png": "8307502516d1644c265aed9ac74e1978",
"assets/assets/images/obstacles/obstacle_tire_1.png": "fbb2b268866a3c37ec9e99610fc75eac",
"assets/assets/images/obstacles/obstacle_rock.png": "ffad3ccc5b48c31b7c0b01afbb235985",
"assets/assets/images/obstacles/obstacle_milk_cart_2.png": "c53a45ee692133ff2a4e318bd4f07d4f",
"assets/assets/images/obstacles/obstacle_bench_1.png": "b4d829ae9833731eed64000e6ecb8860",
"assets/assets/images/obstacles/item_golden_book.png": "b21a93e63da14f24b4da922bcdcb4f81",
"assets/assets/images/obstacles/obstacle_books.png": "3aafe5947030ede819848bb956b1154b",
"assets/assets/images/obstacles/obstacle_food.png": "94d5a916caf8f8c6fa06bc0e7584bea2",
"assets/assets/images/obstacles/obstacle_wild_flowers_2.png": "a8e0a4955a3178cfbb76917bcd081f6e",
"assets/assets/images/obstacles/obstacle_banana.png": "6323f16a78b5765fb66c06f2ce00bddc",
"assets/assets/images/obstacles/obstacle_hydrant_1.png": "e967995defc38bf669774cca988706f6",
"assets/assets/images/obstacles/obstacle_backpack_2.png": "46ee04b314b26ccf8e6f1847d5dc7d9a",
"assets/assets/images/obstacles/obstacle_bucket.png": "9fb30f2610f93eea8a310e7814b9043a",
"assets/assets/images/obstacles/obstacle_cone.png": "279c4044bcad5980003063f785360528",
"assets/assets/images/obstacles/obstacle_trash_can_2.png": "4945f5dc63a50884321ebc922cb4d93c",
"assets/assets/images/obstacles/obstacle_trash_can_1.png": "01caddd4ef66b2222ca1314b2806b2f0",
"assets/assets/images/bg_characters/boy_2.png": "75948da83cf323875f913e3ae4069faf",
"assets/assets/images/bg_characters/dog_1.png": "ad363c09bcf4ffb6ba8219123fc7da37",
"assets/assets/images/bg_characters/butterfly_1.png": "7cfb1015bc2bece4635213ae3ee88197",
"assets/assets/images/bg_characters/girl_2.png": "d8ef181530e7dedde048bd7f0331edfd",
"assets/assets/images/bg_characters/squirrel_2.png": "22101e3e3de8ba30e09b555ce63e9d5f",
"assets/assets/images/bg_characters/dog_4.png": "d93c0aa78913e2dd8dd9e0b91d013526",
"assets/assets/images/bg_characters/squirrel_3.png": "25c5f5542ebdc8fb1d8858be36335b28",
"assets/assets/images/bg_characters/squirrel_4.png": "60e2a4e742362db5accc5946fb549364",
"assets/assets/images/bg_characters/butterfly_2.png": "d1e1233ea4870b5e9bb174312a1943ad",
"assets/assets/images/bg_characters/dog_3.png": "e738b6ca4ecd6403bc62c5ea36b34a0f",
"assets/assets/images/bg_characters/squirrel_1.png": "b0b6fa492eced0678aec09ae7205db20",
"assets/assets/images/bg_characters/girl_1.png": "4bb22b10c92c1af18466443e49fe0ef3",
"assets/assets/images/bg_characters/dog_2.png": "b736bddafe410e7c4856f28473e01cae",
"assets/assets/images/bg_characters/boy_1.png": "b26014530af9cdd1f8d06a1f5d554a8f",
"assets/assets/images/bg_characters/janitor_1.png": "229d114ab0b2ec7b6753dffafb811197",
"assets/assets/images/bg_characters/janitor_2.png": "020fb7bb5f1f3fe8c8bfe37b84073a33",
"assets/assets/images/ernie_run_2.png": "5d4dc4032ee2444ba3fa52b3b8578eac",
"assets/assets/audio/staff_firstg.mp3": "386abce98b012168f5971a36cd4b1116",
"assets/assets/audio/music_garden.mp3": "dd2c504d974b0aba79a53cb9498b2615",
"assets/assets/audio/music_bayou_4.mp3": "d1668f587df994a861d774c1fe765b54",
"assets/assets/audio/ding.mp3": "49f022c2efd0ac6d8a248a42b41a66e2",
"assets/assets/audio/staff_coach.mp3": "9f440f5c489f83f6bc1ec0bcf8f1d9fa",
"assets/assets/audio/music_bayou_2.mp3": "082e5c4be7eccaa3d57ec695dbcc4ec7",
"assets/assets/audio/bonk.mp3": "7fcb8aec6a84ed7045db95f7eff16db9",
"assets/assets/audio/jump.mp3": "915822522d1618433c16283c1ca3688c",
"assets/assets/audio/music_medow.mp3": "86a899c95520c8dc2b829ed537f47023",
"assets/assets/audio/staff_pe.mp3": "a5add550c75d42dda9a7eb82240d5d88",
"assets/assets/audio/music_bayou_1.mp3": "291f1b0cc5656777785d780edea5a307",
"assets/assets/audio/staff_dean.mp3": "b940b60fc8272d3a10b7894aac248063",
"assets/assets/audio/staff_prek2.mp3": "cf8832f634ef277051f7d4956a0655c6",
"assets/assets/audio/music_bayou_6.mp3": "e9cf897f0dbdf40a0d995d5180d87afe",
"assets/assets/audio/music_cafeteria.mp3": "a964cb47e998cdd1bb60edf901c63791",
"assets/assets/audio/staff_english.mp3": "a17341aa28e31de8dcb5c5e0e75394e4",
"assets/assets/audio/staff_head.mp3": "9612c7cfc5037558dd6b4f81ca0c69c7",
"assets/assets/audio/music_bayou_5.mp3": "46dbdf5512f69906f75cb8599fe72da6",
"assets/assets/audio/music_bayou_3.mp3": "06619bcdc99653345d43880dbae1d6e4",
"assets/assets/audio/staff_science.mp3": "ccb390041319c92246b0e0fd72fda30d",
"assets/assets/audio/staff_librarian.mp3": "290691422e7abecb56c6338c4092791b",
"assets/assets/audio/powerup.mp3": "610d5cb803804fd42b4ceaacfee7c3f3",
"assets/assets/audio/music_playground.mp3": "541f43f1a4f7d20069d02213896f32cd",
"assets/fonts/MaterialIcons-Regular.otf": "1b20a38c8496d5be41af6f9da6f8b3aa",
"assets/NOTICES": "f254c8b0934740fdcd4e895c8a00b3a2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin": "1416c6141801e621cfd42b74d88fc0d5",
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
"main.dart.wasm": "4c4ebf206babdded0ac179becd4b24f1",
"flutter_bootstrap.js": "86c9dea64697985c3f19bd9c75dd3a70",
"version.json": "3db6807c9e6d2e3c86179d25c587bd0b",
"main.dart.js": "d07043643e9485495f9692eb4d8125a6"};
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
