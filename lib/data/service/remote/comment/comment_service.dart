import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/config.dart';
import '../../../model/request/comment_req_model.dart';

part 'comment_service.g.dart';

@RestApi(baseUrl: Config.baseUrl)
abstract class CommentService {
  factory CommentService(Dio dio, {String baseUrl}) = _CommentService;

  @POST('/comments')
  Future<void> addComment({@Body() required CommentReqModel comment});
}
