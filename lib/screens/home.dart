import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_otp/provider/api.dart';

class Home extends StatefulWidget {
  Home({Key?key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  bool get wantKeepAlive => true;

  Api? _apicart;




  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _apicart?.setItemArray();
    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('ssssssssssssssssssssssssss');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    DateTime currentBackPressTime;
    _apicart = Provider.of(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          // ),
          title: Text(
            "Basic App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body:
        // SingleChildScrollView(
        //     child:
        Container(
            child:GridView.count(
                padding: EdgeInsets.only(top: 20),
                crossAxisCount: 3,
                children: List.generate(_apicart?.items.length??0, (index) {
                  return Center(
                      child: Card(
                          color:  Color.fromRGBO(143, 148, 251, 1),

                          child: Center(child:
                          Padding(
                            padding:EdgeInsets.all(16),
                            child:Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(child: Icon(_apicart?.items[index].icon, color: Colors.white, size:50.0, )),
                                  Text(_apicart?.items[index].title??'',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ]
                            ),
                          )
                          )
                      )
                  );
                })
            )
          // )
        )
    );
  }
}