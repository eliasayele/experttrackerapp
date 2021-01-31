import 'package:experttrack/dataprovider/appdata.dart';
import 'package:experttrack/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final FirebaseApp app = await Firebase.initializeApp(
  //   name: 'db2',
  //   options: Platform.isIOS || Platform.isMacOS
  //       ? FirebaseOptions(
  //           appId: '1:297855924061:ios:c6de2b69b03a5be8',
  //           apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
  //           projectId: 'flutter-firebase-plugins',
  //           messagingSenderId: '297855924061',
  //           databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
  //         )
  //       : FirebaseOptions(
  //           appId: '1:708258166471:android:9ef54da4473ec87c0030e2',
  //           apiKey: 'AIzaSyD2RIzGNDH6Jf_mnEjOhJ_ill7L1GD2_Bc',
  //           messagingSenderId: '297855924061',
  //           projectId: 'flutter-firebase-plugins',
  //           databaseURL: 'https://expertize-9e28a-default-rtdb.firebaseio.com',
  //         ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the r+oot of My application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expert Tracker',
        theme: ThemeData(
          fontFamily: 'Brand-Regular',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(), //calls the second screen
        // routes: {
        //   RegistrationPage.id: (context) => RegistrationPage(),
        //   LoginPage.id: (context) => LoginPage(),
        //   MainPage.id: (context) => MainPage(),
        // },
      ),
    );
  }
}
