import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:test_task/bloc/all_blogs/all_blogs_cubit.dart';
import 'package:test_task/constants/routes.dart';

import 'package:test_task/presentation/home/widgets/blog_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<AllBlogsCubit>().getAllBlogs(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, Routes.editBlogPage),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Bloggy"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.secondary,
                ))
          ],
        ),
        body: BlocBuilder<AllBlogsCubit, AllBlogsState>(
          builder: (context, state) {
            if (state is AllBlogsSuccess) {
              final allBlogs = state.allBlogs;
              if (allBlogs.isEmpty) {
                return Center(
                  child: Text(
                    "No blogs available",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 18.sp, color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                itemCount: allBlogs.length,
                itemBuilder: (context, index) {
                  final blog = allBlogs[index];
                  return BlogItem(
                    blog: blog,
                  );
                },
              );
            }
            if (state is AllBlogsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 18.sp, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () =>
                            context.read<AllBlogsCubit>().getAllBlogs(),
                        child: const Text('Refresh'))
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary),
            );
          },
        ),
      ),
    );
  }
}
