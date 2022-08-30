import 'package:flutter/material.dart';
import 'package:firebase_otp/utils/style.dart';
class Button extends StatelessWidget {
  final String text;
  final Function() onTap;

  const Button({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            color:Style.systemblue ,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            text,
            style:TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color:Style.greycolor),
          ),
        ),
      ),
    );
  }
}
