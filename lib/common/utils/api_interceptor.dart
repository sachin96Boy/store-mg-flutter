import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_mg_fl/common/utils/apis.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      final sharedprefAsync = SharedPreferencesAsync();

      final token = await sharedprefAsync.getString('token');

      request.headers[HttpHeaders.contentTypeHeader] = "application/json";
      request.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    } catch (e) {
      throw Exception(e);
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    final sharedprefAsync = SharedPreferencesAsync();

    if (response.statusCode == 401) {
      final token = await sharedprefAsync.getString('token');

      if (token == null) {
        // Refresh token
        final refreshToken = await sharedprefAsync.getString('refreshToken');

        final refreshResponse =
            await http.post(Uri.parse(Api.refreshUrl), body: {
          'refresh_token': refreshToken,
        });

        final body = refreshResponse.body as Map<String, dynamic>;

        if (refreshResponse.statusCode == 200) {
          // Save new token
          await sharedprefAsync.setString('token', body['jwt']);
        }
      }
    }
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }
}
