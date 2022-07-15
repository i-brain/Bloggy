import 'package:test_task/data/service/local/locator.dart';
import 'package:test_task/data/service/remote/comment/comment_service.dart';

import '../model/request/comment_req_model.dart';

class CommentRepository {
  final commentService = getIt<CommentService>();

  Future<void> addComment({required CommentReqModel comment}) async {
    return await commentService.addComment(comment: comment);
  }
}
