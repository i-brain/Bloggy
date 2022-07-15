import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/register/register_cubit.dart';
import '../auth/widgets/auth_button.dart';
import '../auth/widgets/auth_textfield.dart';
import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    required this.onLoginClick,
  }) : super(key: key);

  final Function() onLoginClick;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    'Register',
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
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AuthTextField(
                      controller: _confirmPasswordController,
                      textFieldType: AuthTextFieldType.password,
                      hint: 'Confirm Password'),
                ),
                SizedBox(
                  height: 50.h,
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Fluttertoast.showToast(
                        msg:
                            'Logged in as ${FirebaseAuth.instance.currentUser!.email!}',
                        backgroundColor: Colors.green,
                      );
                    } else if (state is RegisterFailure) {
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
                        title: 'Register',
                        onTap: () => register(),
                        isLoading: state is RegisterLoading,
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => widget.onLoginClick(),
                      child: const Text('Login'),
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

  void register() {
    if (_formkey.currentState!.validate() == false) {
      return;
    }
    context.read<RegisterCubit>().register(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
        );
  }
}
