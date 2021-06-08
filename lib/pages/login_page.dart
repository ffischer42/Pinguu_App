import 'package:flutter/material.dart';
import 'package:pinguu_bot/services/ProgressHUD.dart';
import 'package:pinguu_bot/services/api_service.dart';
import 'package:pinguu_bot/utils/form_helper.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _username = "";
  String _pwd = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: ProgressHUD(
          child: _loginUISetup(context),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: null,
        ),
      ),
    );
  }

  Widget _loginUISetup(BuildContext context) {
    return new SingleChildScrollView(
      child: new Container(
          child: new Form(
        key: globalFormKey,
        child: _loginUI(context),
      )),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black87, Colors.black87],
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(150),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                    "https://pinguu.tech/wp-content/uploads/2021/01/penguin-1.png",
                    fit: BoxFit.contain,
                    width: 100),
              ),
              Spacer(),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 40),
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 20,
            top: 20,
          ),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(Icons.verified_user),
            "username",
            "Benutzername",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Hast du hier nicht was vergessen?';
              }
              return null;
            },
            (onSavedValue) {
              _username = onSavedValue.toString().trim();
            },
            suffixIcon: Text(""),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 20,
          ),
          child: FormHelper.inputFieldWidget(
            context,
            Icon(Icons.lock),
            "password",
            "Passwort",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Hast du hier nicht was vergessen?';
              }
              return null;
            },
            (onSavedValue) {
              _pwd = onSavedValue.toString().trim();
            },
            initialValue: "",
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.redAccent.withOpacity(0.4),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        new Center(
          child: FormHelper.saveButton(
            "Login",
            () {
              if (validateAndSave()) {
                log("Username : $_username");
                log("Password : $_pwd");

                setState(() {
                  this.isApiCallProcess = true;
                });

                APIServices.loginCustomer(_username, _pwd).then((response) {
                  setState(() {
                    this.isApiCallProcess = false;
                  });
                  if (response) {
                    globalFormKey.currentState!.reset();
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    FormHelper.showMessage(
                        context, "Pinguu Login", "Ups.. vertippt?", "Ok", () {
                      Navigator.of(context).pop();
                    });
                  }
                });
              }
            },
          ),
        )
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
