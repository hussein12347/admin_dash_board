'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "24b44e90f5c6f1066f9eaafd45a54f73",
"assets/AssetManifest.bin.json": "bbe06c6cc004fc07fad715d0731b2a44",
"assets/AssetManifest.json": "a140ae06c69dc6391ffd087a3ed9b7e3",
"assets/assets/fonts/Cairo-Bold.ttf": "ad486798eb3ea4fda12b90464dd0cfcd",
"assets/assets/image/images/arrow-swap-horizontal.svg": "951659ba772a52d8815f55c5b75c0427",
"assets/assets/image/images/edit.svg": "f06654b96b252dcd22cfc0fc154cc0bd",
"assets/assets/image/images/element-3.svg": "95dee4ec5d2ee9eed5efaeb38976823e",
"assets/assets/image/images/Ellipse.svg": "d1c6479e4c69978c77ef90d2408eedd8",
"assets/assets/image/images/facebook.svg": "56d32d8bc831336f76baaaa8791b2125",
"assets/assets/image/images/fillter.svg": "687db0fd30187bfbe7c2a797304cec26",
"assets/assets/image/images/google.svg": "a9d0b7138187663890fb0541edfd20a1",
"assets/assets/image/images/heart.svg": "71e2db267ad263f9b36673b1629590e0",
"assets/assets/image/images/home.svg": "38212593c820de5bb3240546ad72f6fe",
"assets/assets/image/images/img_1.png": "4d7a83cfd33b8109b4d598248f142e07",
"assets/assets/image/images/location.svg": "df616e2492cb2c1c0cd8359750a4fb43",
"assets/assets/image/images/notification.svg": "3b813045b7fb0b512f9720762023df4b",
"assets/assets/image/images/person.svg": "514902b3e67186d1ec6338768733ccbe",
"assets/assets/image/images/redheart.svg": "6ae8c966629df047335a403ff44ef3d0",
"assets/assets/image/images/search.svg": "d6f6c824554f67fb4e2a5599417996af",
"assets/assets/image/images/search_unavilable.svg": "c809716309358a4fa9f29396a680e5f9",
"assets/assets/image/images/shopping-cart.svg": "2b175f0df26e75bcc813ab438e72fbd7",
"assets/assets/image/images/test.png": "82754f65aa75d39b9eb003b4acf83d19",
"assets/assets/image/images/trash.svg": "d4dee92a406a9e72314b714455090ecf",
"assets/assets/image/images/user.svg": "36c4fec9d2a7075c3d88f4f23a3f03e3",
"assets/assets/image/logo/1.png": "d1f31daf3cf9c2632f4fd39b8e1dec54",
"assets/assets/image/logo/2.png": "c45cdb516d06808ca84353a299305558",
"assets/assets/image/tracking_images/accept.svg": "d4044c65e963403aab41023025f2ff21",
"assets/assets/image/tracking_images/delevery.svg": "f12a28dc6a056c6dc882f387f5d2cada",
"assets/assets/image/tracking_images/done.svg": "9c783bb0645e0a010bba8fdd34aa4569",
"assets/assets/image/tracking_images/order.svg": "4be86e74a82acb273a0fd7b58ff98aed",
"assets/assets/image/tracking_images/send.svg": "9bda58ebacbfe488a6014c3cb231e701",
"assets/assets/image/tracking_images/track_order.svg": "6fd2c7eb790a5d3b8df5f84a77f711a3",
"assets/assets/json/success.json": "3986c6bbbb3c88dec60b3d5fa568af0a",
"assets/FontManifest.json": "36710987b524f419d73e67a62c57d7e2",
"assets/fonts/MaterialIcons-Regular.otf": "580b80732fcbd79f89dc4487d6687bd7",
"assets/NOTICES": "6ffe7b26744be264eb392f3cd50df902",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "4c547ada6c164a77a3cfce8b7feee86d",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "4732bc6e79b984eda6fdaff7f3db79f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "7d7c01b6de087d43f3791ac418cfabef",
"/": "7d7c01b6de087d43f3791ac418cfabef",
"main.dart.js": "86aaeb852d43b6be2be8d0c425a605bf",
"manifest.json": "5e332fa66da93c597a3bfd8eccdf5c52",
"version.json": "5feca97c571dc7459db818403fa2843c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
