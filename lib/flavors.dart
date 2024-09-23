import 'package:firebase_core/firebase_core.dart';

enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Klean Dev';
      case Flavor.prod:
        return 'Klean';
      default:
        return 'title';
    }
  }

  static FirebaseOptions get android {
    switch (appFlavor) {
      case Flavor.dev:
        return const FirebaseOptions(
          apiKey: 'AIzaSyAvUrJl0WpXPbHtzv4oVpbwvqCNluurjlo',
          appId: '1:140554556568:android:65f24a7196fd472bf76ced',
          messagingSenderId: '140554556568',
          projectId: 'klean-in-prod',
          storageBucket: 'klean-in-prod.appspot.com',
        );
      case Flavor.prod:
        return const FirebaseOptions(
          apiKey: 'AIzaSyBBwLBwaj-wRLzWUUjPq88oMJT-lfgZ9M4',
          appId: '1:736081269406:android:cab9d96a0c7e4db99aa18f',
          messagingSenderId: '736081269406',
          projectId: 'klean-in-dev',
          storageBucket: 'klean-in-dev.appspot.com',
        );
      default:
        return const FirebaseOptions(
          apiKey: 'AIzaSyBBwLBwaj-wRLzWUUjPq88oMJT-lfgZ9M4',
          appId: '1:736081269406:android:cab9d96a0c7e4db99aa18f',
          messagingSenderId: '736081269406',
          projectId: 'klean-in-dev',
          storageBucket: 'klean-in-dev.appspot.com',
        );
    }
  }
}
