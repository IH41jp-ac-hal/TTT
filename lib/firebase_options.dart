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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAezb-m7q-N7AE3wAKCTkgmnOo7TbLn7dQ',
    appId: '1:741180300675:web:1e5916f8639dbc35022ab6',
    messagingSenderId: '741180300675',
    projectId: 'ih14---ih4c',
    authDomain: 'ih14---ih4c.firebaseapp.com',
    databaseURL: 'https://ih14---ih4c-default-rtdb.firebaseio.com',
    storageBucket: 'ih14---ih4c.appspot.com',
    measurementId: 'G-KFLQ0QGEN1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjPEcMoxyUSmXxHGhPbHFnYUgQzcG7s2A',
    appId: '1:741180300675:android:5267030ed0af3c84022ab6',
    messagingSenderId: '741180300675',
    projectId: 'ih14---ih4c',
    databaseURL: 'https://ih14---ih4c-default-rtdb.firebaseio.com',
    storageBucket: 'ih14---ih4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDd4A7FLC8mFRB5-xofbbSS-cnBwcshUjk',
    appId: '1:741180300675:ios:f891a0aa21c138ce022ab6',
    messagingSenderId: '741180300675',
    projectId: 'ih14---ih4c',
    databaseURL: 'https://ih14---ih4c-default-rtdb.firebaseio.com',
    storageBucket: 'ih14---ih4c.appspot.com',
    iosClientId: '741180300675-a0r4vpit6c1hd357he1vehpmhs1u6ttn.apps.googleusercontent.com',
    iosBundleId: 'com.example.trukkertrakker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDd4A7FLC8mFRB5-xofbbSS-cnBwcshUjk',
    appId: '1:741180300675:ios:f891a0aa21c138ce022ab6',
    messagingSenderId: '741180300675',
    projectId: 'ih14---ih4c',
    databaseURL: 'https://ih14---ih4c-default-rtdb.firebaseio.com',
    storageBucket: 'ih14---ih4c.appspot.com',
    iosClientId: '741180300675-a0r4vpit6c1hd357he1vehpmhs1u6ttn.apps.googleusercontent.com',
    iosBundleId: 'com.example.trukkertrakker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAezb-m7q-N7AE3wAKCTkgmnOo7TbLn7dQ',
    appId: '1:741180300675:web:1e5916f8639dbc35022ab6',
    messagingSenderId: '741180300675',
    projectId: 'ih14---ih4c',
    authDomain: 'ih14---ih4c.firebaseapp.com',
    databaseURL: 'https://ih14---ih4c-default-rtdb.firebaseio.com',
    storageBucket: 'ih14---ih4c.appspot.com',
    measurementId: 'G-KFLQ0QGEN1',
  );

}
