import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'widgets/PetList.widget.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Varela',
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: MyHomePage(title: 'לוח אבידות ומציאות בעלי חיים'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  final String title;
  Map<String, double> _currentLocation;
  Location _location = new Location();
  bool _permission = false;
  String error;
  StreamSubscription<Map<String, double>> _locationSubscription;

  _MyHomePageState(this.title);

  doNothing() => null;

  initPlatformState() async {
    Map<String, double> location;

    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    setState(() {
      _currentLocation = location;
    });
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      setState(() {
        _currentLocation = result;
      });
    });
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("מידע"),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("נבנה ב♥ ע\"י ולדי"),
                  Text("בשיתוף עם עמותת תנו לחיות לחיות"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          "אתר העמותה",
                          style: TextStyle(color: Colors.green),
                        ),
                        onTap: () => launch("http://www.letlive.org.il/"),
                      ),
                      Text(" | "),
                      InkWell(
                        child: Text(
                          "תרומה לעמותה",
                          style: TextStyle(color: Colors.green),
                        ),
                        onTap: () =>
                            launch("http://www.letlive.org.il/?page_id=32"),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Text(
                      "תרומה למפתח",
                      style: TextStyle(color: Colors.green),
                    ),
                    onTap: () => launch("http://paypal.me/VRachlin"),
                  ),
                ]),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("סגור"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Text(this.title,
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.green)),
                      ),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: _showDialog,
                      )
                    ]))),
            Text(this._currentLocation.toString()),
            Expanded(child: PetList())
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: doNothing(),
        child: Icon(Icons.add),
      ),
    );
  }
}
