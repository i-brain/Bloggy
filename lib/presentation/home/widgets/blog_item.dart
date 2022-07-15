import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/presentation/dialogs/delete_blog_dialog.dart';

import '../../../constants/routes.dart';
import '../../../data/model/response/blog.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({
    Key? key,
    required this.blog,
  }) : super(key: key);

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(blog.id.toString()),
      resizeDuration: const Duration(milliseconds: 200),
      confirmDismiss: (confirmDismiss) async {
        if (confirmDismiss == DismissDirection.startToEnd) {
          Navigator.pushNamed(context, Routes.editBlogPage, arguments: blog);
          return false;
        }
        return DeleteBlogDialog.showDeleteDialog(context: context, id: blog.id);
      },
      secondaryBackground: Container(
        padding: EdgeInsets.only(right: 20.w),
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
      background: Container(
        padding: EdgeInsets.only(left: 20.w),
        alignment: AlignmentDirectional.centerStart,
        color: Colors.yellow,
        child: const Icon(
          Icons.edit,
        ),
      ),
      child: ListTile(
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.pushNamed(
          context,
          Routes.blogDetails,
          arguments: blog.id,
        ),
        title: Text(
          blog.title,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black, fontSize: 20.sp),
        ),
      ),
    );
  }
}
