import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/data/model/request/comment_req_model.dart';

import '../../data/repository/comment_repository.dart';
import '../../data/service/local/locator.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit() : super(AddCommentInitial());

  final commentRepository = getIt<CommentRepository>();

  void addComment({required CommentReqModel comment}) async {
    emit(const AddCommentLoading());

    try {
      await commentRepository.addComment(comment: comment);

      emit(
        const AddCommentSuccess(),
      );
    } on SocketException {
      emit(
        const AddCommentFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const AddCommentFailure(errorMessage: "Unknown error happened"),
      );
    }
  }
}
