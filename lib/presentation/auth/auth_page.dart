import 'package:flutter/widgets.dart';
import 'package:test_task/presentation/login/login_page.dart';
import 'package:test_task/presentation/register/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) => isLoginPage
      ? LoginPage(
          onRegisterClick: switchPage,
        )
      : RegisterPage(
          onLoginClick: switchPage,
        );

  void switchPage() {
    setState(() {
      isLoginPage = !isLoginPage;
    });
  }
}
