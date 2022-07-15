import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_task/bloc/login/login_cubit.dart';

import '../auth/widgets/auth_button.dart';
import '../auth/widgets/auth_textfield.dart';

enum AuthTextFieldType {
  email,
  password,
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.onRegisterClick,
  }) : super(key: key);

  final Function() onRegisterClick;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 40.sp),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AuthTextField(
                      controller: _emailController,
                      textFieldType: AuthTextFieldType.email,
                      hint: 'Email'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AuthTextField(
                      controller: _passwordController,
                      textFieldType: AuthTextFieldType.password,
                      hint: 'Password'),
                ),
                SizedBox(
                  height: 50.h,
                ),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Fluttertoast.showToast(
                        msg:
                            'Logged in as ${FirebaseAuth.instance.currentUser!.email!}',
                        backgroundColor: Colors.green,
                      );
                    } else if (state is LoginFailure) {
                      Fluttertoast.showToast(
                        msg: state.errorMessage,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.center,
                      child: AuthButton(
                        title: 'Login',
                        onTap: () => login(),
                        isLoading: state is LoginLoading,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => widget.onRegisterClick(),
                      child: const Text('Register'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (_formkey.currentState!.validate() == false) {
      return;
    }
    context.read<LoginCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
  }
}
