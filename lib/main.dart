import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './login.dart';
import './calculator.dart';

// removes scroll
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      home: BaseApp(),
      routes: <String, WidgetBuilder>{
        '/Login': (context) => Login(),
        '/Calculator': (context) => Calculator()
      },
    );
  }
}

class BaseApp extends StatelessWidget {
  final bool loginStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ButtonTheme(
            height: 50,
            minWidth: 100,
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.5),
                  side: BorderSide(color: Colors.white)),
              child: Text('Login'),
              onPressed: () {
                if (loginStatus == true) {
                  Navigator.pushNamed(context, '/Calculator');
                } else {
                  Navigator.pushNamed(context, '/Login');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
