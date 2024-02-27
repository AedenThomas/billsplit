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
    apiKey: 'AIzaSyCmDS4b4qVFcbdKwqD_0pRVLLlGl_-y-y0',
    appId: '1:1001375083448:web:f8eb7bdce75261b625fd4d',
    messagingSenderId: '1001375083448',
    projectId: 'agtha-d6e45',
    authDomain: 'agtha-d6e45.firebaseapp.com',
    databaseURL: 'https://agtha-d6e45.firebaseio.com',
    storageBucket: 'agtha-d6e45.appspot.com',
    measurementId: 'G-TWDJ66QRSR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXYVeH0vCRZUKCXQyEfH3vF3yaAQ4C4sU',
    appId: '1:1001375083448:android:78689cceba566f7b25fd4d',
    messagingSenderId: '1001375083448',
    projectId: 'agtha-d6e45',
    databaseURL: 'https://agtha-d6e45.firebaseio.com',
    storageBucket: 'agtha-d6e45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsWvwoDsPdHSXosTRKKppbsbW9sWENxX4',
    appId: '1:1001375083448:ios:64744de07e307b3125fd4d',
    messagingSenderId: '1001375083448',
    projectId: 'agtha-d6e45',
    databaseURL: 'https://agtha-d6e45.firebaseio.com',
    storageBucket: 'agtha-d6e45.appspot.com',
    iosClientId: '1001375083448-ges1bof3vmg8g3gh44h28ktga9bshovv.apps.googleusercontent.com',
    iosBundleId: 'com.aeden.agtha',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsWvwoDsPdHSXosTRKKppbsbW9sWENxX4',
    appId: '1:1001375083448:ios:8b1c888f00ebbadc25fd4d',
    messagingSenderId: '1001375083448',
    projectId: 'agtha-d6e45',
    databaseURL: 'https://agtha-d6e45.firebaseio.com',
    storageBucket: 'agtha-d6e45.appspot.com',
    iosClientId: '1001375083448-0k3b0oq5f25hl0efkhpkqeejdrhe93on.apps.googleusercontent.com',
    iosBundleId: 'com.example.agtha',
  );
}