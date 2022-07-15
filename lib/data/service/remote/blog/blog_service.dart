import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config/config.dart';
import '../../../model/request/add_blog_req_model.dart';
import '../../../model/response/blog.dart';
import '../../../model/response/blog_details.dart';

part 'blog_service.g.dart';

@RestApi(baseUrl: Config.baseUrl)
abstract class BlogService {
  factory BlogService(Dio dio, {String baseUrl}) = _BlogService;

  @GET('/posts')
  Future<List<Blog>> getAllBlogs();

  @GET('/posts/{id}?_embed=comments')
  Future<BlogDetails> getBlogDetails({
    @Path("id") required int id,
  });

  @POST('/posts')
  Future<void> addBlog({@Body() required AddBlogReqModel blog});

  @DELETE('/posts/{id}')
  Future<void> deleteBlog({@Path() required int id});

  @PUT('/posts/{id}')
  Future<void> updateBlog(
      {@Path() required int id, @Body() required Blog blog});
}
