import '../base_client.dart';
import '../enums.dart';

class ProductClient extends BaseClient {
  ProductClient({super.secretKey});

  Future<Response> create(
      String name, String description, int price, Currency currency,
      {bool? unlimited, int? quantity}) async {
    var data = {
      'name': name,
      'description': description,
      'price': price,
      'currency': currency.paystackValue,
      'unlimited': unlimited,
      'quantity': quantity,
    };
    return await call(Uri.https(baseUrl, '/product'), HttpMethod.post,
        data: data);
  }

  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, '/product', queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, '/product/$id'), HttpMethod.get);
  }

  Future<Response> update(
      String id, String name, String description, int price, Currency currency,
      {bool? unlimited, int? quantity}) async {
    var data = {
      'name': name,
      'description': description,
      'price': price,
      'currency': currency.paystackValue,
      'unlimited': unlimited,
      'quantity': quantity,
    };
    return await call(Uri.https(baseUrl, '/product/$id'), HttpMethod.put,
        data: data);
  }
}
