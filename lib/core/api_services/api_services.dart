import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://bomnvaxxvzrzwkabeuse.supabase.co/rest/v1/',
      headers: {
        "apikey":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJvbW52YXh4dnpyendrYWJldXNlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQwMDYzMTIsImV4cCI6MjA1OTU4MjMxMn0.A5gkz2lcfNZuUDc_m1wQvPu_zdAwuvPw3MslXV2SSek",
      }
      )
  );

  Future<Response> getData({required String path}) async {
    return await _dio.get(path);
  }
  Future<Response> deleteData({required String path}) async {
    return await _dio.delete(path);
  }

  Future<Response> postData(
      {required String path, required Map<String, dynamic> data}) async {
    return await _dio.post(
      path,
      data: data,
    );
  }

  Future<Response>

  patchData(
      {required String path, required Map<String, dynamic> data}) async {
    return await _dio.patch(path, data: data);
  }
}
