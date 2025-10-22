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
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0T4TruRFwHBgQtS9k0Z4VH-EF7NQ4z8k',
    appId: '1:694258853647:android:fd8843ed473d91b3ac007a',
    messagingSenderId: '694258853647',
    projectId: 'gbookflutter',
    storageBucket: 'gbookflutter.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDH0BSl00KopQiEdxngqNqsOzwgR9HijE',
    appId: '1:694258853647:ios:ff9291c7e4c5a9ebac007a',
    messagingSenderId: '694258853647',
    projectId: 'gbookflutter',
    storageBucket: 'gbookflutter.firebasestorage.app',
    iosBundleId: 'com.example.gbookMobile',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyASuJLzzjEz6TIkR01IQ3d8Z7CMsV2vRcg',
    appId: '1:694258853647:web:bf16687082998cdbac007a',
    messagingSenderId: '694258853647',
    projectId: 'gbookflutter',
    authDomain: 'gbookflutter.firebaseapp.com',
    storageBucket: 'gbookflutter.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDH0BSl00KopQiEdxngqNqsOzwgR9HijE',
    appId: '1:694258853647:ios:ff9291c7e4c5a9ebac007a',
    messagingSenderId: '694258853647',
    projectId: 'gbookflutter',
    storageBucket: 'gbookflutter.firebasestorage.app',
    iosBundleId: 'com.example.gbookMobile',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASuJLzzjEz6TIkR01IQ3d8Z7CMsV2vRcg',
    appId: '1:694258853647:web:89531129a96a2e7cac007a',
    messagingSenderId: '694258853647',
    projectId: 'gbookflutter',
    authDomain: 'gbookflutter.firebaseapp.com',
    storageBucket: 'gbookflutter.firebasestorage.app',
  );

}