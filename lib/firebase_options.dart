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
    apiKey: 'AIzaSyDP8jAH_vV92KuOJFj2hUVGejd_Yn3aMGs',
    appId: '1:619367552569:web:254660d728293f38cf1fe8',
    messagingSenderId: '619367552569',
    projectId: 'notification-dbfdb',
    authDomain: 'notification-dbfdb.firebaseapp.com',
    storageBucket: 'notification-dbfdb.appspot.com',
    measurementId: 'G-KQF7LV2ZP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYEmn3n4PYooo5Mwtwkn4vgiwlWsn0mKk',
    appId: '1:619367552569:android:eea9ef9fd1617f13cf1fe8',
    messagingSenderId: '619367552569',
    projectId: 'notification-dbfdb',
    storageBucket: 'notification-dbfdb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgtsVWVM8pYbH_f2rCrIk0kc9ui5UgzJM',
    appId: '1:619367552569:ios:274f9a22429582b2cf1fe8',
    messagingSenderId: '619367552569',
    projectId: 'notification-dbfdb',
    storageBucket: 'notification-dbfdb.appspot.com',
    iosClientId: '619367552569-3g247v2g8btoh9qdj5r3bg8s887g4bah.apps.googleusercontent.com',
    iosBundleId: 'com.example.notification',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgtsVWVM8pYbH_f2rCrIk0kc9ui5UgzJM',
    appId: '1:619367552569:ios:274f9a22429582b2cf1fe8',
    messagingSenderId: '619367552569',
    projectId: 'notification-dbfdb',
    storageBucket: 'notification-dbfdb.appspot.com',
    iosClientId: '619367552569-3g247v2g8btoh9qdj5r3bg8s887g4bah.apps.googleusercontent.com',
    iosBundleId: 'com.example.notification',
  );
}