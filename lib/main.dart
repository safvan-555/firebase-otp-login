import 'package:flutter/material.dart';
import 'package:firebase_otp/screens/signin.dart';
import 'package:firebase_otp/provider/api.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Api()),
        ],
        child: LayoutBuilder(builder: (context, constraints) {
          return MaterialApp(
            title: 'Firebase Otp Login',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.white,
              fontFamily: 'OpenSans',
            ),
            home: const Signin(),
          );
        }
    ));
  }
}

