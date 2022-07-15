part of 'delete_blog_cubit.dart';

abstract class DeleteBlogState extends Equatable {
  const DeleteBlogState();

  @override
  List<Object> get props => [];
}

class DeleteBlogInitial extends DeleteBlogState {}

class DeleteBlogLoading extends DeleteBlogState {
  const DeleteBlogLoading();
}

class DeleteBlogSuccess extends DeleteBlogState {
  const DeleteBlogSuccess();
}

class DeleteBlogFailure extends DeleteBlogState {
  final String errorMessage;

  const DeleteBlogFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
