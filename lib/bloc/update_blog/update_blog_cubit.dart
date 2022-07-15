import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/blog.dart';
import '../../data/repository/blog_repository.dart';
import '../../data/service/local/locator.dart';

part 'update_blog_state.dart';

class UpdateBlogCubit extends Cubit<UpdateBlogState> {
  UpdateBlogCubit() : super(UpdateBlogInitial());

  final blogRepository = getIt<BlogRepository>();

  void updateBlog({required Blog blog}) async {
    emit(const UpdateBlogLoading());

    try {
      await blogRepository.updateBlog(blog: blog);

      emit(
        const UpdateBlogSuccess(),
      );
    } on SocketException {
      emit(
        const UpdateBlogFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const UpdateBlogFailure(errorMessage: "Unknown error hapened"),
      );
    }
  }
}
