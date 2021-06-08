import 'package:flutter/material.dart';
import 'package:pinguu_bot/pages/home_page.dart';
import 'package:pinguu_bot/services/shared_service.dart';

import 'pages/login_page.dart';

Widget _defaultHome = new LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = new HomePage();
  }
  runApp(Pinguu());
}

class Pinguu extends StatefulWidget {
  const Pinguu({Key? key}) : super(key: key);

  @override
  _PinguuState createState() => _PinguuState();
}

class _PinguuState extends State<Pinguu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinguu Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.cyan[600],
      ),
      home: _defaultHome,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}
