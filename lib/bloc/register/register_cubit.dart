import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterInitial());

  void register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(const RegisterFailure(errorMessage: 'Passwords doesn\'t match!'));

      return;
    }

    emit(const RegisterLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(const RegisterSuccess());
    } on FirebaseAuthException catch (error) {
      emit(
        RegisterFailure(errorMessage: error.message!),
      );
    } on SocketException {
      emit(
        const RegisterFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const RegisterFailure(errorMessage: "Unknown error hapened"),
      );
    }
  }
}
