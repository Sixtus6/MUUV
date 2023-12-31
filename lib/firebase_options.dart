// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyBDcErcxPH_4lFA0D13ZnA3RX4vKHf7AnY',
    appId: '1:1097095890706:web:32699f0cf4d90c2b4315cb',
    messagingSenderId: '1097095890706',
    projectId: 'muuv-d6cc1',
    authDomain: 'muuv-d6cc1.firebaseapp.com',
    storageBucket: 'muuv-d6cc1.appspot.com',
    measurementId: 'G-KY3340YTTV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCbF9VuL8v6Mk6Qi3to4oDBXBlMv5QJsEI',
    appId: '1:1097095890706:android:a9c3560a75964fe24315cb',
    messagingSenderId: '1097095890706',
    projectId: 'muuv-d6cc1',
    storageBucket: 'muuv-d6cc1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4mTzRabBSRx3x7cN3JqorFH0b2zK_dkE',
    appId: '1:1097095890706:ios:8979a754f4db79464315cb',
    messagingSenderId: '1097095890706',
    projectId: 'muuv-d6cc1',
    storageBucket: 'muuv-d6cc1.appspot.com',
    iosBundleId: 'com.example.muuv',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4mTzRabBSRx3x7cN3JqorFH0b2zK_dkE',
    appId: '1:1097095890706:ios:2228f8269f4b32074315cb',
    messagingSenderId: '1097095890706',
    projectId: 'muuv-d6cc1',
    storageBucket: 'muuv-d6cc1.appspot.com',
    iosBundleId: 'com.example.muuv.RunnerTests',
  );
}
