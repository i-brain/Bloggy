part of 'add_comment_cubit.dart';

abstract class AddCommentState extends Equatable {
  const AddCommentState();

  @override
  List<Object> get props => [];
}

class AddCommentInitial extends AddCommentState {}

class AddCommentLoading extends AddCommentState {
  const AddCommentLoading();
}

class AddCommentSuccess extends AddCommentState {
  const AddCommentSuccess();
}

class AddCommentFailure extends AddCommentState {
  final String errorMessage;

  const AddCommentFailure({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
