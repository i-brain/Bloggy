import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/blog_details.dart';
import '../../data/repository/blog_repository.dart';
import '../../data/service/local/locator.dart';

part 'blog_details_state.dart';

class BlogDetailsCubit extends Cubit<BlogDetailsState> {
  BlogDetailsCubit() : super(BlogDetailsInitial());

  final blogRepository = getIt<BlogRepository>();

  void getBlogDetails({required int id}) async {
    if (state is BlogDetailsInitial) {
      emit(const BlogDetailsLoading());
    }

    try {
      final blogDetails = await blogRepository.getBlogDetails(id: id);

      emit(
        BlogDetailsSuccess(blogDetails: blogDetails),
      );
    } on SocketException {
      emit(
        const BlogDetailsFailure(errorMessage: "No internet connected"),
      );
    } catch (error) {
      emit(
        const BlogDetailsFailure(errorMessage: "Unknown error happened"),
      );
    }
  }
}
