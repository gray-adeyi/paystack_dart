import 'package:paystack/src/enums.dart';

import '../base_client.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Payment Pages API that provides a quick and secure
/// way to collect payment for products.
class PaymentPageClient extends BaseClient {
  /// Create an instance of [PaymentPageClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [PaymentPageClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [PaymentPageClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `paymentPages` binding
  /// ## Example
  /// ```dart
  /// var client = PaymentPageClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.paymentPages.all();
  /// ```
  PaymentPageClient({super.secretKey});

  /// Create a payment page on your integration.
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

  /// Retrieve a list of payment pages available on your integration
  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'from': from, 'to': to});
    return await call(
        Uri.https(baseUrl, '/page', queryParameters), HttpMethod.get);
  }

  /// Retrieve a payment page on your integration by it's id or slug.
  Future<Response> fetchOne(String idOrSlug) async {
    return await call(Uri.https(baseUrl, '/page/$idOrSlug'), HttpMethod.get);
  }

  /// Update the details of a payment page on your integration
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

  /// Check the availability of a slug for a payment page
  Future<Response> checkSlug(String slug) async {
    return await call(Uri.https(baseUrl, '/page/check_slug_availability/$slug'),
        HttpMethod.get);
  }

  /// Add products to a payment page
  Future<Response> addProducts(String id, List<String> products) async {
    return await call(Uri.https(baseUrl, '/page/$id/product'), HttpMethod.post,
        data: {'product': products});
  }
}
