import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/add_comment/add_comment_cubit.dart';
import '../../../bloc/blog_details/blog_details_cubit.dart';
import '../../../data/model/request/comment_req_model.dart';

class AddCommentField extends StatefulWidget {
  const AddCommentField({Key? key, required this.blogId}) : super(key: key);

  final int blogId;

  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCommentCubit, AddCommentState>(
      listener: (context, state) {
        if (state is AddCommentSuccess) {
          context.read<BlogDetailsCubit>().getBlogDetails(id: widget.blogId);
        }
        if (state is AddCommentFailure) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16.r)),
          height: 60.h,
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'add comment',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 14.sp, color: Colors.black),
              suffixIcon: TextButton(
                onPressed: () => addComment(),
                child: const Text('send'),
              ),
            ),
          ),
        );
      },
    );
  }

  void addComment() {
    if (_commentController.text.trim().isEmpty) return;
    context.read<AddCommentCubit>().addComment(
          comment: CommentReqModel(
            postId: widget.blogId,
            body: _commentController.text,
          ),
        );

    _commentController.clear();
  }
}
