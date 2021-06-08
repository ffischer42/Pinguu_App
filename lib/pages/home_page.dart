import 'package:flutter/material.dart';
import 'package:pinguu_bot/services/shared_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pinguu Dashboard"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                SharedService.logout(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Text("Dashboard"),
        ));
  }
}
