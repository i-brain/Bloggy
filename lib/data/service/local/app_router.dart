import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/app.dart';
import 'package:test_task/bloc/blog_details/blog_details_cubit.dart';
import 'package:test_task/constants/routes.dart';
import 'package:test_task/presentation/blog_details/blog_details_page.dart';

import '../../../presentation/edit_blog_page/edit_blog_page.dart';
import '../../model/response/blog.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.blogDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => BlogDetailsCubit()
              ..getBlogDetails(
                id: settings.arguments as int,
              ),
            child: const BlogDetailsPage(),
          ),
        );
      case Routes.editBlogPage:
        final blog = settings.arguments as Blog?;

        return MaterialPageRoute(
          builder: (context) => EditBlogPage(blog: blog),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const MyApp(),
        );
    }
  }
}
