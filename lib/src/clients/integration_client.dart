import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirrors endpoints provided by
/// Paystack's Integration API which allows you manage some
/// settings on your integration.
class IntegrationClient extends BaseClient {
  /// Create an instance of [IntegrationClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [IntegrationClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [IntegrationClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `customers` binding
  /// ## Example
  /// ```dart
  /// var client = IntegrationClient(secretKey: "<your paystack secret key>");
  /// var response = await client.timeout();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.integration.timeout();
  /// ```
  IntegrationClient({super.secretKey});

  /// Retrieve the payment session timeout for your integration.
  Future<Response> timeout() async {
    return await call(
        Uri.https(baseUrl, '/integration/payment_session_timeout'),
        HttpMethod.get);
  }

  /// Update the payment session timeout for your integration.
  ///
  /// - [timeout] is the time before stopping session (in seconds).
  /// Set to 0 to cancel session timeouts
  Future<Response> updateTimeout(int timeout) async {
    return await call(
        Uri.https(baseUrl, '/integration/payment_session_timeout'),
        HttpMethod.put,
        data: {'timeout': timeout});
  }
}
