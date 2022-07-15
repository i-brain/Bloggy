part of 'blog_details_cubit.dart';

abstract class BlogDetailsState extends Equatable {
  const BlogDetailsState();

  @override
  List<Object> get props => [];
}

class BlogDetailsInitial extends BlogDetailsState {}

class BlogDetailsLoading extends BlogDetailsState {
  const BlogDetailsLoading();
}

class BlogDetailsSuccess extends BlogDetailsState {
  final BlogDetails blogDetails;
  const BlogDetailsSuccess({
    required this.blogDetails,
  });

  @override
  List<Object> get props => [blogDetails];
}

class BlogDetailsFailure extends BlogDetailsState {
  final String errorMessage;

  const BlogDetailsFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
