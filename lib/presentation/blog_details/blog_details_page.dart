import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/bloc/add_comment/add_comment_cubit.dart';
import 'package:test_task/bloc/blog_details/blog_details_cubit.dart';
import 'package:test_task/presentation/blog_details/widgets/add_comment_field.dart';
import 'package:test_task/presentation/blog_details/widgets/comment_list.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog details"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: BlocBuilder<BlogDetailsCubit, BlogDetailsState>(
        builder: (context, state) {
          if (state is BlogDetailsSuccess) {
            final blogDetails = state.blogDetails;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      blogDetails.title,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 200.h),
                      child: Text(
                        blogDetails.body,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    if (blogDetails.comments.isEmpty)
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No comments",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                    else
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'comments (${blogDetails.comments.length})',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocProvider(
                      create: (context) => AddCommentCubit(),
                      child: AddCommentField(blogId: blogDetails.id),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 350.sp,
                      child: CommentList(comments: blogDetails.comments),
                    ),
                    SizedBox(
                      height: 10.sp,
                    )
                  ],
                ),
              ),
            );
          }
          if (state is BlogDetailsFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 18.sp),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}
