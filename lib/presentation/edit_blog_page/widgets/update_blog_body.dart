import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/all_blogs/all_blogs_cubit.dart';
import '../../../bloc/update_blog/update_blog_cubit.dart';
import '../../../data/model/response/blog.dart';

class UpdateBlogBody extends StatefulWidget {
  const UpdateBlogBody({
    Key? key,
    required this.titleController,
    required this.bodyController,
    required this.blog,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyController;
  final Blog blog;

  final GlobalKey<FormState> formKey;

  @override
  State<UpdateBlogBody> createState() => _UpdateBlogBodyState();
}

class _UpdateBlogBodyState extends State<UpdateBlogBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.titleController.text = widget.blog.title;
      widget.bodyController.text = widget.blog.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBlogCubit, UpdateBlogState>(
      listener: (context, state) {
        if (state is UpdateBlogSuccess) {
          Fluttertoast.showToast(
              msg: 'Blog updated successfully', backgroundColor: Colors.green);
          context.read<AllBlogsCubit>().getAllBlogs();
          Navigator.pop(context);
        } else if (state is UpdateBlogFailure) {
          Fluttertoast.showToast(
              msg: state.errorMessage, backgroundColor: Colors.red);
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 100.w,
            height: 50.h,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () => updateBlog(),
              child: state is UpdateBlogLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.secondary,
                    )
                  : const Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
            ),
          ),
        );
      },
    );
  }

  void updateBlog() {
    if (widget.formKey.currentState!.validate()) {
      context.read<UpdateBlogCubit>().updateBlog(
            blog: Blog(
              title: widget.titleController.text,
              body: widget.bodyController.text,
              id: widget.blog.id,
            ),
          );
    }
  }
}
