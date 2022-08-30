import 'package:flutter/material.dart';
import 'package:firebase_otp/provider/api.dart';
import 'package:firebase_otp/components/inputfield.dart';
import 'package:firebase_otp/screens/home.dart';
import 'package:firebase_otp/components/button.dart';
import 'package:firebase_otp/utils/style.dart';
import 'package:firebase_otp/utils/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:async';


class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<Otp> {
  @override
  bool get wantKeepAlive => true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _otpController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String?verificationId;
  String?smsOTP;

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    generateOtp();
  });
    super.initState();
  }


  Api? _api;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('did cganges');
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Method for generate otp from firebase
  Future<void> generateOtp() async {
    print('_apicart.phonenumber==========');
    print(_api?.phonenumber);
    print('verificationId ======');
    print(verificationId);

    // var pho='+918089479366' + (_apicart?.phonenumber??'');
    var pho='+918089479366';
    print('phophophophophophophophophopho-------------');
    print(pho);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: pho,
          codeAutoRetrievalTimeout: (String verId) {
            verificationId  = verId;
          },
          codeSent: (String verificationId, [int?forceResendingToken]) {
            if (mounted) {
              print('code sent');
            }
            print('code sent verificationId===');
            print(verificationId);
            setState(() {
              verificationId = verificationId;
            });
          },
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential credential) async {
            print('verificationCompleted---------------------verificationCompleted--');
            UserCredential result = await _auth.signInWithCredential(credential);
            print('result12result12result12result12--------------');
            print(result);

            if (result != null) {

              final User currentUser = await _auth.currentUser!;
              assert(result.user?.uid == currentUser.uid);
              print('succes succes successucces succes');
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));

            } else {
              var snackBar = SnackBar(content: Text('Something went wrong.'),backgroundColor: Colors.orange);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
          },
          verificationFailed: (FirebaseAuthException exception) {
            var snackBar = SnackBar(content: Text('${exception.message??''}'),backgroundColor: Colors.orange);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          });
    } catch (e) {
      if (e.toString().contains("[firebase_auth/invalid-verification-code]")) {
        var mess=e.toString().replaceAll("[firebase_auth/invalid-verification-code]",'');
        var snackBar = SnackBar(content: Text('${mess}'),backgroundColor: Colors.orange);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      if (e.toString().contains("[firebase_auth/session-expired]")) {
        var mess=e.toString().replaceAll("[firebase_auth/session-expired]",'');
        var snackBar = SnackBar(content: Text('${mess}'),backgroundColor: Colors.orange);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    }
  }


  Future<void> verifyOtp(smsOTP) async {
print('verificationId111111111111111111---');
print(verificationId);
print('smsOTPsmsOTPsmsOTPsmsOTPsmsOTP---');
print(smsOTP);
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId??'',
        smsCode: smsOTP??'',
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User currentUser = await _auth.currentUser!;
      assert(user.user?.uid == currentUser.uid);
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
    } catch (e) {

      if (e.toString().contains("[firebase_auth/invalid-verification-code]")) {
        var mess=e.toString().replaceAll("[firebase_auth/invalid-verification-code]",'');
        var snackBar = SnackBar(content: Text('${mess}'),backgroundColor: Colors.orange);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;

      }
      if (e.toString().contains("[firebase_auth/session-expired]")) {
        var mess=e.toString().replaceAll("[firebase_auth/session-expired]",'');
        var snackBar = SnackBar(content: Text('${mess}'),backgroundColor: Colors.orange);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _api = Provider.of(context);
    var devheight = MediaQuery.of(context).size.height;
    var devwidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Style.systemblue, // status bar color
    ));
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Otp",
            style: Style.normalText,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(children: [
          Container(
              height: devheight,
              width: devwidth,
              decoration: const BoxDecoration(
                color: Style.greycolor,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeAnimation(
                        3,
                        Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 40),
                          child: Container(
                            height: 200,
                            width: devwidth * 0.8,
                            margin: EdgeInsets.only(left: devwidth * 0.09),
                            child: Image.asset("assets/images/login.png"),
                          ),
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                    FadeAnimation(
                      2,
                      InputField(
                        headingText: "Otp",
                        hintText: "Otp",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        controller: _otpController,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    FadeAnimation(
                      2,
                      Button(
                        onTap: () {
                          if (_otpController.text.isEmpty) {
                            var snackBar = SnackBar(content: Text('please enter 6 digit otp'),backgroundColor: Colors.orange);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          } else {
                            verifyOtp(_otpController.text);
                          }
                        },
                        text: 'Verify',
                      ),
                    )
                  ]))
        ]))));
  }
}
