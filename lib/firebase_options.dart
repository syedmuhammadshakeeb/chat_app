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
    apiKey: 'AIzaSyD6jNHaaGiIOuuctf3ecsegEcT_sUdhY_8',
    appId: '1:1051723971365:web:eb31b8b0a2e3697520b8cc',
    messagingSenderId: '1051723971365',
    projectId: 'chatapp-61fbe',
    authDomain: 'chatapp-61fbe.firebaseapp.com',
    storageBucket: 'chatapp-61fbe.appspot.com',
    measurementId: 'G-HPYV7DJLKF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbjxGaHNguPHpUG2gQTsyJXvE-qBPJWLk',
    appId: '1:1051723971365:android:7a9f540b5d5696b720b8cc',
    messagingSenderId: '1051723971365',
    projectId: 'chatapp-61fbe',
    storageBucket: 'chatapp-61fbe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDAeeMapMku6CvkK9EP5-z2gsnOPX5NdU',
    appId: '1:1051723971365:ios:f0a009ad7db60f6c20b8cc',
    messagingSenderId: '1051723971365',
    projectId: 'chatapp-61fbe',
    storageBucket: 'chatapp-61fbe.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDAeeMapMku6CvkK9EP5-z2gsnOPX5NdU',
    appId: '1:1051723971365:ios:7550f3c5877c8d1c20b8cc',
    messagingSenderId: '1051723971365',
    projectId: 'chatapp-61fbe',
    storageBucket: 'chatapp-61fbe.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
