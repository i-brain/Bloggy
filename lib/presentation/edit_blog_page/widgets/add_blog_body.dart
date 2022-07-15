import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/add_blog/add_blog_cubit.dart';
import '../../../bloc/all_blogs/all_blogs_cubit.dart';
import '../../../data/model/request/add_blog_req_model.dart';

class AddBlogBody extends StatelessWidget {
  const AddBlogBody({
    Key? key,
    required this.titleController,
    required this.bodyController,
    required this.formkey,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyController;

  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddBlogCubit, AddBlogState>(
      listener: (context, state) {
        if (state is AddBlogSuccess) {
          Fluttertoast.showToast(
              msg: 'Blog added successfully', backgroundColor: Colors.green);
          context.read<AllBlogsCubit>().getAllBlogs();
          Navigator.pop(context);
        } else if (state is AddBlogFailure) {
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
              onPressed: () => addBlog(context),
              child: state is AddBlogLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )
                  : const Text('Add'),
            ),
          ),
        );
      },
    );
  }

  void addBlog(BuildContext context) {
    if (formkey.currentState!.validate()) {
      context.read<AddBlogCubit>().addBlog(
            blog: AddBlogReqModel(
                title: titleController.text, body: bodyController.text),
          );
    }
  }
}
