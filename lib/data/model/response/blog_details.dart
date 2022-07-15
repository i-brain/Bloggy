import 'dart:convert';

BlogDetails blogDetailsFromJson(String str) =>
    BlogDetails.fromJson(json.decode(str));

String blogDetailsToJson(BlogDetails data) => json.encode(data.toJson());

class BlogDetails {
  BlogDetails({
    required this.id,
    required this.title,
    required this.body,
    required this.comments,
  });

  final int id;
  final String title;
  final String body;
  final List<Comment> comments;

  factory BlogDetails.fromJson(Map<String, dynamic> json) => BlogDetails(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.postId,
    required this.body,
  });

  final int id;
  final int postId;
  final String body;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        postId: json["postId"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "postId": postId,
        "body": body,
      };
}
