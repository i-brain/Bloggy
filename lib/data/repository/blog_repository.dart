import 'package:test_task/data/service/local/locator.dart';
import 'package:test_task/data/service/remote/blog/blog_service.dart';

import '../model/request/add_blog_req_model.dart';
import '../model/response/blog.dart';
import '../model/response/blog_details.dart';

class BlogRepository {
  final blogService = getIt<BlogService>();

  Future<List<Blog>> getAllBlogs() async {
    return blogService.getAllBlogs();
  }

  Future<BlogDetails> getBlogDetails({required int id}) async {
    return blogService.getBlogDetails(id: id);
  }

  Future<void> addBlog({required AddBlogReqModel blog}) async {
    return blogService.addBlog(blog: blog);
  }

  Future<void> deleteBlog({required int id}) async {
    return blogService.deleteBlog(id: id);
  }

  Future<void> updateBlog({required Blog blog}) async {
    return blogService.updateBlog(id: blog.id, blog: blog);
  }
}
