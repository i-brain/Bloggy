import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/blog_repository.dart';
import '../../data/service/local/locator.dart';

part 'delete_blog_state.dart';

class DeleteBlogCubit extends Cubit<DeleteBlogState> {
  DeleteBlogCubit() : super(DeleteBlogInitial());

  final blogRepository = getIt<BlogRepository>();

  void deleteBlog({required int id}) async {
    emit(const DeleteBlogLoading());

    try {
      await blogRepository.deleteBlog(id: id);

      emit(
        const DeleteBlogSuccess(),
      );
    } on SocketException {
      emit(
        const DeleteBlogFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const DeleteBlogFailure(errorMessage: "Unknown error happened"),
      );
    }
  }
}
