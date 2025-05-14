'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "89c2e12aa5136ab1c8dc54afd42c91ce",
".git/config": "c9feeb999f66fcf18d68ef8d0fc881f4",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "b3d0c42004401b897b341011e666ca57",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "376eb780c718fa46524356b9176c5c8f",
".git/logs/refs/heads/gh-pages": "376eb780c718fa46524356b9176c5c8f",
".git/logs/refs/remotes/origin/gh-pages": "df2f9d9b7c51d96e1d7e640ce9b4d095",
".git/objects/00/72b57946217cf85cd11c677415e950a43701e9": "d02ca8fadd8663271261b5a41d13b740",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/06/5a156ad876ae75d08bca0aabc8c1e01f285abb": "1338ac20d12542d14345378e2fe2be26",
".git/objects/07/0f45e4dc04e1fb8f034102826e4f8262f634fb": "60dbf7ad4684c54c69bee1b32032ec10",
".git/objects/08/da6dd74eaf005c79e5abb99c2e44e4d61d1429": "0292a94041d380265f8d588a42a15880",
".git/objects/09/8d2fb5851c92236b72f68263cd91886db729b6": "7605759c2a5f639931d24fdc64171045",
".git/objects/0c/700a74e0cb87365d4e228fe0a4ad20879d0622": "b712169f8d4b32314ab460037516c219",
".git/objects/0e/ce32b21f9eff4335ecdfbb06e3aa3a96d39344": "80c2913974be56db7ffb06d7b30a133b",
".git/objects/11/9260f4281c9b6d613525b070ac3a66de1a7ae1": "d6f820e1e873a213179d274c4e2b6b04",
".git/objects/17/d8bc195be0fa3ad4aba48a9965467c7d844934": "1aa6688ad71c6f5e68d63083c0a2a0be",
".git/objects/19/eae70744c8d50d581dc15276628e68429bce62": "5342a1c9ee79f80f0a415fd08042ecae",
".git/objects/1c/b6eef3049a9f678880378b644fc3de134ff1af": "66ba6c0f8e968ce1b343fb4f46bbd55d",
".git/objects/1f/d952c6fa4205cced7e22be259b998cecae589e": "3758c736fd06b46a8538c5fb1208c724",
".git/objects/20/cfaa8106a96dffed3ba2ead4c5889820c86325": "871e36c33cdf0227a1ad50ee78a2a753",
".git/objects/28/12806234dc110dc94fc448969474d0ea41aa19": "df78e89969ded5699498b1ab3cd8854e",
".git/objects/28/5ded0dd3dc45852ae6a402c1f34b343d6d8791": "eaf6c357feffeed1766c11cd14bf9bd9",
".git/objects/2d/0471ef9f12c9641643e7de6ebf25c440812b41": "d92fd35a211d5e9c566342a07818e99e",
".git/objects/33/31d9290f04df89cea3fb794306a371fcca1cd9": "e54527b2478950463abbc6b22442144e",
".git/objects/35/5c2394fee9d436993317fdf1340794bebdbaae": "5eaaa52b912cdac73be49c2818d2331c",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/3a/e7e8a83f35da288a5ea64693499b73ae207201": "1e13bc581e938e7ac395d8cebf468750",
".git/objects/3b/a7e7cc55f651435e60336cb564842e5c97b1cc": "2cec5c73e14d44477fd8e567ea7a68c9",
".git/objects/3b/b0860a0981211a1ab11fced3e6dad7e9bc1834": "3f00fdcdb1bb283f5ce8fd548f00af7b",
".git/objects/3e/3520573aae1e95b92415bd3fc2cd273e824c20": "e3712be47fe7220a734032634bb2bc2b",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/45/ae9b603385867e81d9d3c5e0c85881ef3dcc95": "5f15d441e12b3256f3d787683d04c9a2",
".git/objects/4b/0fee0a37ae23ae3a4879293fc10dc6bf61a79d": "3cb369dcd12766133e27c44d1a8613d3",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/54/eb1e1b0d72d667791ba9ab65da2dc35a1f69d6": "c1decf01a08b82b8c75a07bd086334f4",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/57/da780135e7cc8dd09163e6ff69127454fbdb25": "d9c275dd514ce9aa96dccb5f0ccdf3cf",
".git/objects/5c/26097a13a2614f54a8a415c9a693cf91658b5b": "044298235829334b84120201e33a78c4",
".git/objects/5c/800e1ea7b4f9e61efa7b471e9c782650831884": "bcbdfd90b209f6aa1922e231f9d686e7",
".git/objects/5d/73fd0c4192208cde38eb1acba7c20cb2c88804": "a0f28abb1c2584eed75de296a00d76aa",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/60/1de710934f0256db0aed6d6d4ef63738cd11a8": "c0152daef05afc54df770e38ea768033",
".git/objects/64/5116c20530a7bd227658a3c51e004a3f0aefab": "f10b5403684ce7848d8165b3d1d5bbbe",
".git/objects/6a/2d2213e47ac6403d5a84b511c6c41b5438c251": "13ca53b5705d45761d94970bd40af0e7",
".git/objects/6f/0cd3a48608ab8b2c6e346d5ccbf7a8ba7405a9": "f79ba482aac38b56e1f491d34db04fe0",
".git/objects/73/1a5a0c2cd3898fe6f7f5ab9340526b7f4847c4": "f0b803a833552ba69292eb85d6de1129",
".git/objects/75/859563cc6f7947fa9f89161a867727691e4d97": "61f5f69479b3da5106aaaf87444cbf8a",
".git/objects/76/1fae2538cd754bdaee43d624fb4a68535b72fc": "3520723420fca29de1df579f27579ec9",
".git/objects/7b/ae90f9a18843144b0037deb8d7b2e98c8b0390": "17dcb446b03488c4421258f7f0923625",
".git/objects/7c/ccf5e65c234e29b57d90bf0007f255e658d38e": "99e096b39c08f39397e7eeebd465deb5",
".git/objects/83/26585a2978dc856852077fe667d7507f039d00": "396a0db313fad2a744652f5ad929627d",
".git/objects/84/f829ae368e2eb646fdf85d313f9d01deedf551": "54a5c5bbbf64c247f2b182662250288d",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/89/dd43a4d4d7a330afe7e1025fb5d258ff527dcc": "de989e9d55c814773bea1f202783c5d7",
".git/objects/8a/3cbfbea60d5a49b39f7c5ccec2b677720dee1d": "d8b94ab2a8ef8532e6952b272ea7c921",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/93/be7fd9b9dcdd8564dafd7040a0c8c8f68d4080": "b27ff257c793a735fc818ff37f392ff9",
".git/objects/94/06f681d685de68199ac0bcb11bf8d1ecc781ba": "d7c86ec990b8e7fa9a42f8f23d734df7",
".git/objects/94/c89dfe34a5cefa792573a0682c49d5fe30b238": "7776bd324672d6858e02eddfa7ac91b6",
".git/objects/95/c8cea5f97c56b68eb9d89f999242786a6e5935": "086c09dc86cd2637dd84c0d359765cb8",
".git/objects/99/eed3b8b12a69525fb7712c03273fc6922eb247": "d5757af2ad2fc73c937e23fe3e2477bb",
".git/objects/9a/0377702e5f75b5f1d80d10f68925a368890782": "68bfb2de42e7bcad4324ee742213c819",
".git/objects/a1/d521cdb7a2547bc1fe4dbe6c018344b9e630cf": "8dca7cb8ef41af6e9065a07ec2c8adf2",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/a9/5814b8a62a55b39283e447fc615f9572b916de": "98c398ba4177ad284d05d74da526a32c",
".git/objects/ac/222df2c13a8b11386b31711e22a154c0ded475": "c0d8ff719eb80c8eecc0419fbaa3997a",
".git/objects/b2/0f5a67851044666215f49380ffbcc3fd2c44a9": "0ae96400dc5f362bb1175f5b26558fe9",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/be/31cd88269483bf9d21415872c70cc33e53b23d": "33b57896284a236b9b27c31617b77789",
".git/objects/c7/7663172ca915a99a594ca17d06f527db05657d": "6335b074b18eb4ebe51f3a2c609a6ecc",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/95c0fe8e98e4eb0022cb1778587948b27833f0": "58be6bbba311548fccc9fd199c9dd2e0",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d7/a45feeeed31f6c1c039b3d343af825dc6b54ef": "cc5857cdac307f7cd32192c0197b16a4",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/e0/ac8e4186085022578d7eaa8b4d4b9d1ce3fadf": "006f11ff08d67cea9488fc1288c7dfa1",
".git/objects/e5/b6d29d3b86f68ae0631f0335eb8d84aa390d1a": "1838f33ad6b5192e6999af829f47890e",
".git/objects/ea/2c722a2b4382ef340b601458a8d4bb76a1120e": "981e4b7e7eeb75dacd6934878ab8ca28",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/9edc4140dc02924c20e18491ac6ef36e6e30d2": "ca023fe8de536108bb7419b84ec768dc",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f1/1b6487ba92549b51cb1aa152c2362d5ef1f37b": "81af599ff1d5b1a4ff443453006266d6",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f7/5b7a3a51082b8e2c66d4f5786ff5ba98d9e447": "9b65724bd3fff3af81f94cb816862af5",
".git/objects/f8/efe7a98dcf37deda5227fe2646c9e38c3b067c": "22005a29cc71553e16b8f253d3e336f6",
".git/objects/fd/522b2875785be128a1d38ca7a1b760f86af20a": "98340fc99e8227d81316d234b8547c35",
".git/refs/heads/gh-pages": "78c6f12ba42f1bd2791c997478b35dc3",
".git/refs/remotes/origin/gh-pages": "78c6f12ba42f1bd2791c997478b35dc3",
"assets/AssetManifest.bin": "24b44e90f5c6f1066f9eaafd45a54f73",
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
"flutter_bootstrap.js": "28856544272d189279896e1e56118c53",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "23fe1a03e2295b1fa41d1557224645ab",
"/": "23fe1a03e2295b1fa41d1557224645ab",
"main.dart.js": "86aaeb852d43b6be2be8d0c425a605bf",
"manifest.json": "53f675599bd0f9b7f77e67fe88a23d3f",
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
