// Copyright © 2022 Nevis Security AG. All rights reserved.

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/io.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:nevis_mobile_authentication_sdk/nevis_mobile_authentication_sdk.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/credentials.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/login_request.dart';
import 'package:nevis_mobile_authentication_sdk_example_app_flutter/domain/model/login/login_response.dart';

abstract class LoginDataSource {
  Future<Credentials> login({
    required Uri uri,
    required LoginRequest loginRequest,
  });
}

@Injectable(as: LoginDataSource)
class LoginDataSourceImpl implements LoginDataSource {
  final Dio dio;
  final CookieJar cookieJar;

  LoginDataSourceImpl()
      : dio = Dio(),
        cookieJar = CookieJar() {
    dio.interceptors.add(CookieManager(cookieJar));
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );
  }

  @override
  Future<Credentials> login({
    required Uri uri,
    required LoginRequest loginRequest,
  }) async {
    await cookieJar.deleteAll();
    final options = Options(contentType: Headers.formUrlEncodedContentType);
    final response = await dio.postUri(
      uri,
      data: loginRequest.toJson(),
      options: options,
    );
    final cookies = await cookieJar.loadForRequest(uri);
    return await _makeCredentials(uri, response, cookies);
  }

  Future<Credentials> _makeCredentials(
      Uri uri, Response response, List<Cookie> cookies) {
    AuthorizationProvider? authorizationProvider;
    if (cookies.isNotEmpty) {
      final List<CookieContainer> containers = cookies
          .map((cookie) => CookieContainer(
                uri: uri,
                cookie: cookie.toString(),
              ))
          .toList();
      authorizationProvider =
          CookieAuthorizationProvider(cookieContainers: containers);
    }

    final loginResponse = LoginResponse.fromJson(response.data);
    final credentials = Credentials(
      username: loginResponse.extId,
      authorizationProvider: authorizationProvider,
    );

    return Future.value(credentials);
  }
}
