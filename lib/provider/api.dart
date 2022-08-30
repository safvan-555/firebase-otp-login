import 'package:flutter/material.dart';
import 'package:firebase_otp/modelschemas/Items.dart';
class Api extends ChangeNotifier {
  String phonenumber = '';
  List<Items> items = [];


  setPhone(String phn){
    this.phonenumber = phn;
    notifyListeners();
    return;
  }
  setItemArray() async {
    var choicearray=[
      {"title": 'Home', "icon": Icons.home },
      {"title": 'Contact', "icon": Icons.contacts },
      {"title": 'Map', "icon": Icons.map },
      {"title": 'Phone', "icon": Icons.phone },
      {"title": 'Camera', "icon": Icons.camera_alt },
      {"title": 'Setting', "icon": Icons.settings },
      {"title": 'Album', "icon": Icons.photo_album },
      {"title": 'WiFi', "icon": Icons.wifi },
      {"title": 'GPS', "icon": Icons.gps_fixed },

      {"title": 'Home', "icon": Icons.home },
      {"title": 'Contact', "icon": Icons.contacts },
      {"title": 'Map', "icon": Icons.map },
      {"title": 'Phone', "icon": Icons.phone },
      {"title": 'Camera', "icon": Icons.camera_alt },
      {"title": 'Setting', "icon": Icons.settings },
      {"title": 'Album', "icon": Icons.photo_album },
      {"title": 'WiFi', "icon": Icons.wifi },
      {"title": 'GPS', "icon": Icons.gps_fixed },

      {"title": 'Home', "icon": Icons.home },
      {"title": 'Contact', "icon": Icons.contacts },
      {"title": 'Map', "icon": Icons.map },
      {"title": 'Phone', "icon": Icons.phone },
      {"title": 'Camera', "icon": Icons.camera_alt },
      {"title": 'Setting', "icon": Icons.settings },
      {"title": 'Album', "icon": Icons.photo_album },
      {"title": 'WiFi', "icon": Icons.wifi },
      {"title": 'GPS', "icon": Icons.gps_fixed },

    ];
    choicearray.forEach((v) {
      items.add(new Items.fromJson(v));
    });
    notifyListeners();
    return true;
  }


}
