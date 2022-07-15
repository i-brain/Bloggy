import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/bloc/add_blog/add_blog_cubit.dart';
import 'package:test_task/bloc/update_blog/update_blog_cubit.dart';

import '../../data/model/response/blog.dart';
import 'widgets/add_blog_body.dart';
import 'widgets/update_blog_body.dart';

class EditBlogPage extends StatefulWidget {
  const EditBlogPage({
    Key? key,
    this.blog,
  }) : super(key: key);
  final Blog? blog;

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 15.h,
              ),
              const Text('Title'),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: _titleController,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Add title ...'),
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text('Body'),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: _bodyController,
                keyboardType: TextInputType.multiline,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Body is required";
                  }
                  return null;
                },
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add body ...',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (widget.blog == null)
                BlocProvider(
                  create: (context) => AddBlogCubit(),
                  child: AddBlogBody(
                    bodyController: _bodyController,
                    titleController: _titleController,
                    formkey: _formkey,
                  ),
                )
              else
                BlocProvider(
                  create: (context) => UpdateBlogCubit(),
                  child: UpdateBlogBody(
                    titleController: _titleController,
                    bodyController: _bodyController,
                    blog: widget.blog!,
                    formKey: _formkey,
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
