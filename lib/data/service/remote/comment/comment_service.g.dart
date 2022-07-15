// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_returning_null_for_void

class _CommentService implements CommentService {
  _CommentService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://bloggy-api.herokuapp.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<void> addComment({required comment}) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    data.addAll(comment.toJson());
    await _dio.fetch<void>(_setStreamType<void>(
        Options(method: 'POST', headers: headers, extra: extra)
            .compose(_dio.options, '/comments',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    return null;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
