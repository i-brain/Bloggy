import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitial());

  void login({
    required String email,
    required String password,
  }) async {
    emit(const LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(const LoginSuccess());
    } on FirebaseAuthException catch (error) {
      emit(
        LoginFailure(errorMessage: error.message!),
      );
    } on SocketException {
      emit(
        const LoginFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const LoginFailure(errorMessage: "Unknown error hapened"),
      );
    }
  }
}
