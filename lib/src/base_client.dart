// TODO: Put public facing types in this file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import './enums.dart';
import './exceptions.dart';

typedef NativeJsonData = Map<String, dynamic>;
typedef Response = Future<({int statusCode, NativeJsonData data})>;

const String packageVersion = "0.0.1";

class BaseClient {
  late String _secretKey;
  String secretKeyEnvironmentalVariableName = "PAYSTACK_SECRET_KEY";
  http.Client client = http.Client();

  BaseClient({String? secretKey}) {
    if (secretKey != null) {
      _secretKey = secretKey;
    } else {
      var value = Platform.environment[secretKeyEnvironmentalVariableName];
      if (value == null) {
        throw MissingSecretKeyException(
            "Paystack secret not provided on client instantiation or set"
            " in the environmental variables as "
            "`$secretKeyEnvironmentalVariableName`");
      }
      _secretKey = value;
    }
  }

  String get baseUrl => "api.paystack.co";

  Map<String, String> get headers => {
        "Authorization": "Bearer $_secretKey",
        "Content-Type": "application/json",
        "User-Agent": ("paystack $packageVersion "
            "https://github.com/gray-adeyi/paystack_dart")
      };

  // TODO: Provide concrete type for data
  Response call(Uri url, HttpMethod method, {NativeJsonData? data}) async {
    http.Response response;
    var jsonEncodedData = jsonEncode(data);
    // TODO: Find out how to do parameter destructuring into a function to replace
    // the switch statement below.
    switch (method) {
      case HttpMethod.get:
        response = await client.get(url, headers: headers);
      case HttpMethod.post:
        response =
            await client.post(url, headers: headers, body: jsonEncodedData);
      case HttpMethod.put:
        response =
            await client.put(url, headers: headers, body: jsonEncodedData);
      case HttpMethod.patch:
        response =
            await client.patch(url, headers: headers, body: jsonEncodedData);
      case HttpMethod.delete:
        response =
            await client.delete(url, headers: headers, body: jsonEncodedData);
      case HttpMethod.head:
        response = await client.head(url, headers: headers);
    }
    return _parseResponse(response);
  }

  Map<String, dynamic> normalizeQueryParameters(
      Map<String, dynamic> queryParameters) {
    Map<String, dynamic> normalizedQueryParameter = {};
    for (var param in queryParameters.entries) {
      if (param.value == null) continue;
      var value = param.value;
      if (value is int) value = value.toString();
      normalizedQueryParameter[param.key] = value;
    }
    return normalizedQueryParameter;
  }

  ({int statusCode, NativeJsonData data}) _parseResponse(
      http.Response response) {
    var data = jsonDecode(utf8.decode(response.bodyBytes)) as NativeJsonData;
    return (statusCode: response.statusCode, data: data);
  }
}
