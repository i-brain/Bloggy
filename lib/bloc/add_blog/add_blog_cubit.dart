import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/request/add_blog_req_model.dart';
import '../../data/repository/blog_repository.dart';
import '../../data/service/local/locator.dart';

part 'add_blog_state.dart';

class AddBlogCubit extends Cubit<AddBlogState> {
  AddBlogCubit() : super(AddBlogInitial());

  final blogRepository = getIt<BlogRepository>();

  void addBlog({required AddBlogReqModel blog}) async {
    emit(const AddBlogLoading());

    try {
      await blogRepository.addBlog(blog: blog);

      emit(
        const AddBlogSuccess(),
      );
    } on SocketException {
      emit(
        const AddBlogFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const AddBlogFailure(errorMessage: "Unknown error happened"),
      );
    }
  }
}
