import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/data/repository/blog_repository.dart';
import 'package:test_task/data/service/local/locator.dart';

import '../../data/model/response/blog.dart';

part 'all_blogs_state.dart';

class AllBlogsCubit extends Cubit<AllBlogsState> {
  AllBlogsCubit() : super(AllBlogsInitial());

  final blogRepository = getIt<BlogRepository>();

  void getAllBlogs() async {
    emit(const AllBlogsLoading());

    try {
      final allBlogs = await blogRepository.getAllBlogs();

      emit(
        AllBlogsSuccess(allBlogs: allBlogs),
      );
    } on SocketException {
      emit(
        const AllBlogsFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const AllBlogsFailure(errorMessage: "Unknown error happened"),
      );
    }
  }
}
