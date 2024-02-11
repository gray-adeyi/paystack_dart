import '../base_client.dart';
import '../enums.dart';

class ApplePayClient extends BaseClient {
  ApplePayClient({super.secretKey});

  Future<Response> register(String domainName) async {
    return await call(Uri.https(baseUrl, '/apple-pay/domain'), HttpMethod.post,
        data: {'domainName': domainName});
  }

  Future<Response> all(bool useCursor, {String? next, String? previous}) async {
    var queryParameters = normalizeQueryParameters({
      'next': next,
      'previous': previous,
    });
    return await call(Uri.https(baseUrl, '/apple-pay/domain', queryParameters),
        HttpMethod.get);
  }

  Future<Response> unregister(String domainName) async {
    return await call(
        Uri.https(baseUrl, '/apple-pay/domain'), HttpMethod.delete,
        data: {'domainName': domainName});
  }
}
