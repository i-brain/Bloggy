import 'dart:convert';

AddBlogReqModel addblogReqModelFromJson(String str) =>
    AddBlogReqModel.fromJson(json.decode(str));

String addblogReqModelToJson(AddBlogReqModel data) =>
    json.encode(data.toJson());

class AddBlogReqModel {
  AddBlogReqModel({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;

  factory AddBlogReqModel.fromJson(Map<String, dynamic> json) =>
      AddBlogReqModel(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
