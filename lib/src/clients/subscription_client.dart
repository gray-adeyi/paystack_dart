import 'package:paystack/src/enums.dart';

import '../base_client.dart';

class SubscriptionClient extends BaseClient {
  Future<Response> create(String customer, String plan, String authorization,
      {String? startDate}) async {
    var data = {
      'customer': customer,
      'plan': plan,
      'authorization': authorization,
      'start_date': startDate
    };
    return await call(Uri.https(baseUrl, '/subscription'), HttpMethod.post,
        data: data);
  }

  Future<Response> all(
      {int perPage = 50, int page = 1, String? customer, String? plan}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'customer': customer, 'plan': plan});
    return await call(Uri.https(baseUrl, '/subscription'), HttpMethod.get);
  }

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/subscription/$idOrCode'), HttpMethod.get);
  }

  Future<Response> enable(String code, String token) async {
    return await call(
        Uri.https(baseUrl, '/subscription/enable'), HttpMethod.post,
        data: {'code': code, 'token': token});
  }

  Future<Response> disable(String code, String token) async {
    return await call(
        Uri.https(baseUrl, '/subscription/disable'), HttpMethod.post,
        data: {'code': code, 'token': token});
  }

  Future<Response> generateLink(String code) async {
    return await call(
        Uri.https(baseUrl, '/subscription/$code/manage/link/'), HttpMethod.get);
  }

  Future<Response> sendLink(String code) async {
    return await call(Uri.https(baseUrl, '/subscription/$code/manage/email/'),
        HttpMethod.post);
  }
}
