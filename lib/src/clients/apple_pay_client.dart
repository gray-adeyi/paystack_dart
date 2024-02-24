import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Apple Pay API which allows you register your application's
/// top-level domain or subdomain.
class ApplePayClient extends BaseClient {
  /// Create an instance of [ApplePayClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [ApplePayClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [ApplePayClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `applePay` binding
  /// ## Example
  /// ```dart
  /// var client = ApplePayClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.applePay.all();
  /// ```
  ApplePayClient({super.secretKey});

  /// Register a top-level domain or subdomain for your Apple Pay integration.
  ///
  /// - [domainName] is the domain name to be registered
  Future<Response> register(String domainName) async {
    return await call(Uri.https(baseUrl, '/apple-pay/domain'), HttpMethod.post,
        data: {'domainName': domainName});
  }

  /// Lists all registered domains on your integration.
  ///
  /// Returns an empty array if no domains have been added.
  Future<Response> all(bool useCursor, {String? next, String? previous}) async {
    var queryParameters = normalizeQueryParameters({
      'next': next,
      'previous': previous,
    });
    return await call(Uri.https(baseUrl, '/apple-pay/domain', queryParameters),
        HttpMethod.get);
  }

  /// Unregister a top-level domain or subdomain previously used for
  /// your Apple Pay integration.
  ///
  /// - [domainName] is the domain name you want to unregister.
  Future<Response> unregister(String domainName) async {
    return await call(
        Uri.https(baseUrl, '/apple-pay/domain'), HttpMethod.delete,
        data: {'domainName': domainName});
  }
}
