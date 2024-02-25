import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Products API which allows you create and manage
/// inventories on your integration.
class ProductClient extends BaseClient {
  /// Create an instance of [ProductClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [ProductClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [ProductClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `products` binding
  /// ## Example
  /// ```dart
  /// var client = ProductClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.products.all();
  /// ```
  ProductClient({super.secretKey});

  /// Create a product on your integration
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

  /// Retrieve a list of products available on your integration
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

  /// Retrieve the details of a product on your integration
  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, '/product/$id'), HttpMethod.get);
  }

  /// Update the details of a product on your integration
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
