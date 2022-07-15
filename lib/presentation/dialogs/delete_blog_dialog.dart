import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/delete_blog/delete_blog_cubit.dart';

class DeleteBlogDialog {
  DeleteBlogDialog._();

  static Future<bool?> showDeleteDialog({
    required BuildContext context,
    required int id,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => DeleteBlogCubit(),
          child: BlocConsumer<DeleteBlogCubit, DeleteBlogState>(
            listener: (context, state) {
              if (state is DeleteBlogSuccess) {
                Fluttertoast.showToast(
                    msg: "Blog deleted successfully",
                    backgroundColor: Colors.green);

                Navigator.of(context).pop(true);
              } else if (state is DeleteBlogFailure) {
                Fluttertoast.showToast(
                    msg: state.errorMessage, backgroundColor: Colors.red);

                Navigator.of(context).pop(false);
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Confirm"),
                content:
                    const Text("Are you sure you wish to delete this item?"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () async {
                        context.read<DeleteBlogCubit>().deleteBlog(id: id);
                      },
                      child: const Text("DELETE")),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL"),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
