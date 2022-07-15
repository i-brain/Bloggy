import 'dart:convert';

CommentReqModel commentReqModelFromJson(String str) =>
    CommentReqModel.fromJson(json.decode(str));

String commentReqModelToJson(CommentReqModel data) =>
    json.encode(data.toJson());

class CommentReqModel {
  CommentReqModel({
    required this.postId,
    required this.body,
  });

  final int postId;
  final String body;

  factory CommentReqModel.fromJson(Map<String, dynamic> json) =>
      CommentReqModel(
        postId: json["postId"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "body": body,
      };
}
