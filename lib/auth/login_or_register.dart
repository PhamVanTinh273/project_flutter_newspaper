import 'package:flutter/material.dart';
import 'package:page_login/pages/login_page.dart';
import 'package:page_login/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => LoginOrRegisterState();
}

class LoginOrRegisterState extends State<LoginOrRegister> {

  //ininitially ,show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage =!showLoginPage;
    });
  } // toggle between login



  @override
  Widget build(BuildContext context) {
    if(showLoginPage) {
      return LoginPage(onTap: togglePages,);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}