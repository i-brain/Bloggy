import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_task/data/repository/blog_repository.dart';

import 'package:test_task/data/service/remote/blog/blog_service.dart';

import '../../repository/comment_repository.dart';
import '../remote/comment/comment_service.dart';

final getIt = GetIt.instance;

final dio = Dio();

void setupLocator() {
  getIt.registerLazySingleton<BlogService>(() => BlogService(dio));
  getIt.registerLazySingleton<BlogRepository>(() => BlogRepository());

  getIt.registerLazySingleton<CommentService>(() => CommentService(dio));
  getIt.registerLazySingleton<CommentRepository>(() => CommentRepository());
}
