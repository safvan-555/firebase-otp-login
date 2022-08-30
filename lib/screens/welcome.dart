import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_otp/screens/home.dart';
import 'package:firebase_otp/screens/signin.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((value) async {
      final User?user = _auth.currentUser;
      print(user?.uid);
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
        }else{
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Signin()));
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0XFF2C241F),
      backgroundColor: Color(0XFFFFFFFF),
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Center(
                  child:Image.asset(
                    'assets/images/Spinner.gif',
                    // fit: BoxFit.fitHeight,
                    // width: 54,
                    // height: 84,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
