part of 'all_blogs_cubit.dart';

abstract class AllBlogsState extends Equatable {
  const AllBlogsState();

  @override
  List<Object> get props => [];
}

class AllBlogsInitial extends AllBlogsState {}

class AllBlogsLoading extends AllBlogsState {
  const AllBlogsLoading();
}

class AllBlogsSuccess extends AllBlogsState {
  final List<Blog> allBlogs;
  const AllBlogsSuccess({
    required this.allBlogs,
  });

  @override
  List<Object> get props => [allBlogs];
}

class AllBlogsFailure extends AllBlogsState {
  final String errorMessage;

  const AllBlogsFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
