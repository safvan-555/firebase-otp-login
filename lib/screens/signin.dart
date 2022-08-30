import 'package:flutter/material.dart';
import 'package:firebase_otp/provider/api.dart';
import 'package:firebase_otp/components/inputfield.dart';
import 'package:firebase_otp/screens/otp.dart';
import 'package:firebase_otp/components/button.dart';
import 'package:firebase_otp/utils/style.dart';
import 'package:firebase_otp/utils/FadeAnimation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'dart:io' show Platform;

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<Signin> {
  @override
  bool get wantKeepAlive => true;
  Api? _api;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _phoneController = TextEditingController();
  // String get phone => _phoneController.text.trim();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
    if (Platform.isAndroid) {
      Future<void>.delayed(
          const Duration(milliseconds: 100), _tryPasteCurrentPhone);
    }
    super.initState();
  }


  Future _tryPasteCurrentPhone() async {
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      await _api?.setPhone( phone.replaceAll("+91", ""));
      _phoneController.text = phone.replaceAll("+91", "");
    } on PlatformException catch (e) {
      var snackBar = SnackBar(content: Text('${e.message}'),backgroundColor: Colors.orange);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
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
            "Login",
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
                        headingText: "Phone",
                        hintText: "Phone",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        controller: _phoneController,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    FadeAnimation(
                      2,
                      Button(
                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Otp()));
                        },
                        text: 'Sign In',
                      ),
                    )
                  ]))
        ]))));
  }
}
