// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCWnwrH4xZ0Ko-fYZE6XMpAM2tVpTnlzZo',
    appId: '1:363819011145:web:e9731fd5ac09b96d90c398',
    messagingSenderId: '363819011145',
    projectId: 'finalcafeteriasystem',
    authDomain: 'finalcafeteriasystem.firebaseapp.com',
    databaseURL: 'https://finalcafeteriasystem-default-rtdb.firebaseio.com',
    storageBucket: 'finalcafeteriasystem.appspot.com',
    measurementId: 'G-L2S09XHWEQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC85E6Fly6HiOmU46V7UPU2ygGxy0xMOek',
    appId: '1:363819011145:android:55deb81ea711a64690c398',
    messagingSenderId: '363819011145',
    projectId: 'finalcafeteriasystem',
    databaseURL: 'https://finalcafeteriasystem-default-rtdb.firebaseio.com',
    storageBucket: 'finalcafeteriasystem.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCSVQDF_Om3EPeWboRfXD5iNncD4wK_hU4',
    appId: '1:363819011145:ios:ecda50b19a44d44090c398',
    messagingSenderId: '363819011145',
    projectId: 'finalcafeteriasystem',
    databaseURL: 'https://finalcafeteriasystem-default-rtdb.firebaseio.com',
    storageBucket: 'finalcafeteriasystem.appspot.com',
    iosClientId:
        '363819011145-p3id3vampnai38l3o54cpdu4hlm1dn2k.apps.googleusercontent.com',
    iosBundleId: 'com.example.gradutionfinalv',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCSVQDF_Om3EPeWboRfXD5iNncD4wK_hU4',
    appId: '1:363819011145:ios:ecda50b19a44d44090c398',
    messagingSenderId: '363819011145',
    projectId: 'finalcafeteriasystem',
    databaseURL: 'https://finalcafeteriasystem-default-rtdb.firebaseio.com',
    storageBucket: 'finalcafeteriasystem.appspot.com',
    iosClientId:
        '363819011145-p3id3vampnai38l3o54cpdu4hlm1dn2k.apps.googleusercontent.com',
    iosBundleId: 'com.example.gradutionfinalv',
  );
}
