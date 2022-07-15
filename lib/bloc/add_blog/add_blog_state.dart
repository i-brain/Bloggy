part of 'add_blog_cubit.dart';

abstract class AddBlogState extends Equatable {
  const AddBlogState();

  @override
  List<Object> get props => [];
}

class AddBlogInitial extends AddBlogState {}

class AddBlogLoading extends AddBlogState {
  const AddBlogLoading();
}

class AddBlogSuccess extends AddBlogState {
  const AddBlogSuccess();
}

class AddBlogFailure extends AddBlogState {
  final String errorMessage;

  const AddBlogFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
