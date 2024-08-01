// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyARevjzT1a6X2bC6-YReKJMTp3l1c9K4GM',
    appId: '1:837916050508:web:7cdd7ac840bec2309820e9',
    messagingSenderId: '837916050508',
    projectId: 'lets-enlist',
    authDomain: 'lets-enlist.firebaseapp.com',
    storageBucket: 'lets-enlist.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqkrY6mURLrE2uwx54eUTfEkbPWRuQOws',
    appId: '1:837916050508:ios:762ec097dbac275c9820e9',
    messagingSenderId: '837916050508',
    projectId: 'lets-enlist',
    storageBucket: 'lets-enlist.appspot.com',
    iosClientId: '837916050508-j875hk5962so6kkot3s47l7a16890s4d.apps.googleusercontent.com',
    iosBundleId: 'com.lets-enlist.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqMv6bfqVuf-6AxF4-M90lHj8V6BvUrbI',
    appId: '1:837916050508:android:d9cb1a633fa5d9179820e9',
    messagingSenderId: '837916050508',
    projectId: 'lets-enlist',
    storageBucket: 'lets-enlist.appspot.com',
  );

}