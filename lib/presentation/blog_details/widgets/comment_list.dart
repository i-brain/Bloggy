import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/data/model/response/blog_details.dart';

class CommentList extends StatelessWidget {
  const CommentList({Key? key, required this.comments}) : super(key: key);

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return ListTile(
          trailing: Icon(
            Icons.comment,
            color: Theme.of(context).primaryColor,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          title: Text(
            comment.body,
            style: Theme.of(context).textTheme.headline3,
          ),
          subtitle: const Divider(),
        );
      },
    );
  }
}
