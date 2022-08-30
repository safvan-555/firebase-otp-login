import 'package:flutter/material.dart';
class Items extends ChangeNotifier {

  IconData? icon;
  String? title;

  Items({
    this.icon,
    this.title,
  });

  Items.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    return data;
  }
}