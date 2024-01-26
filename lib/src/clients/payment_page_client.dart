import 'package:paystack/src/enums.dart';

import '../base_client.dart';

class PaymentPageClient extends BaseClient {
  Future<Response> create(String name,
      {String? description,
      int? amount,
      String? splitCode,
      String? slug,
      Map<String, dynamic>? metadata,
      String? redirectUrl,
      List<String>? customFields}) async {
    var data = {
      'name': name,
      'description': description,
      'amount': amount,
      'split_code': splitCode,
      'slug': slug,
      'metadata': metadata,
      'redirect_url': redirectUrl,
      'custom_fields': customFields
    };
    return await call(Uri.https(baseUrl, '/page'), HttpMethod.post, data: data);
  }

  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'from': from, 'to': to});
    return await call(
        Uri.https(baseUrl, '/page', queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String idOrSlug) async {
    return await call(Uri.https(baseUrl, '/page/$idOrSlug'), HttpMethod.get);
  }

  Future<Response> update(String idOrSlug, String name, String description,
      {int? amount, bool? active}) async {
    var data = {
      'name': name,
      'description': description,
      'amount': amount,
      'active': active
    };
    return await call(Uri.https(baseUrl, '/page/$idOrSlug'), HttpMethod.put,
        data: data);
  }

  Future<Response> checkSlug(String slug) async {
    return await call(Uri.https(baseUrl, '/page/check_slug_availability/$slug'),
        HttpMethod.get);
  }

  Future<Response> addProducts(String id, List<String> products) async {
    return await call(Uri.https(baseUrl, '/page/$id/product'), HttpMethod.post,
        data: {'product': products});
  }
}
