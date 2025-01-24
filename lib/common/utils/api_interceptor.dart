import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/auth/providers/common_providers.dart';

class ApiInterceptor implements InterceptorContract {
  final SharedPreferencesAsync sharedPrefLocal;

  ApiInterceptor({required this.sharedPrefLocal});

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    try {
      final token = await sharedPrefLocal.getString('token') ?? '';

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
    if (response.statusCode == 401) {
      final token = await sharedPrefLocal.getString('token');

      if (token == null) {
        // Refresh token
        final refreshToken = await sharedPrefLocal.getString('refreshToken');

        final refreshResponse =
            await http.post(Uri.parse(Api.refreshUrl), body: {
          'refresh_token': refreshToken,
        });

        final body = refreshResponse.body as Map<String, dynamic>;

        if (refreshResponse.statusCode == 200) {
          // Save new token
          await sharedPrefLocal.setString('token', body['jwt']);
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

class ApiInterceptorNotifier extends Notifier<ApiInterceptor> {
  @override
  ApiInterceptor build() {
    // TODO: implement build
    final sharedPrefLocal = ref.read(sharedPrefLocalProvider);
    return ApiInterceptor(sharedPrefLocal: sharedPrefLocal.asyncPrefs);
  }

  Client getClientInterceptor() {
    Client client = InterceptedClient.build(interceptors: [
      state,
    ]);

    return client;
  }
}

final apiInterceptorProvider =
    NotifierProvider<ApiInterceptorNotifier, ApiInterceptor>(() {
  return ApiInterceptorNotifier();
});
