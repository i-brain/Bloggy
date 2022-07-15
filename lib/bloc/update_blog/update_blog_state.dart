part of 'update_blog_cubit.dart';

abstract class UpdateBlogState extends Equatable {
  const UpdateBlogState();

  @override
  List<Object> get props => [];
}

class UpdateBlogInitial extends UpdateBlogState {}

class UpdateBlogLoading extends UpdateBlogState {
  const UpdateBlogLoading();
}

class UpdateBlogSuccess extends UpdateBlogState {
  const UpdateBlogSuccess();
}

class UpdateBlogFailure extends UpdateBlogState {
  final String errorMessage;

  const UpdateBlogFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
