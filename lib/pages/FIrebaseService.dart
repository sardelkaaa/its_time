import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBzzbCP7oS84SPwNMvrrye8aWaP2xsALh8",
            appId: "1:663402310587:android:467426934e8318d850329e",
            messagingSenderId: '663402310587',
            projectId: 'it-s-time-2da27',
            storageBucket: "it-s-time-2da27.appspot.com")
    ); //Инициализация Firebase как метода
  }
}
