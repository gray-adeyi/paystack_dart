import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Refunds API which allows you create and
/// manage transaction refunds.
class RefundClient extends BaseClient {
  /// Create an instance of [RefundClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [RefundClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [RefundClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `refunds` binding
  /// ## Example
  /// ```dart
  /// var client = RefundClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.refunds.all();
  /// ```
  RefundClient({super.secretKey});

  /// Initiate a refund on your integration
  Future<Response> create(
    String transaction, {
    int? amount,
    Currency? currency,
    String? customerNote,
    String? merchantNote,
  }) async {
    var data = {
      'transaction': transaction,
      'amount': amount,
      'currency': currency?.paystackValue,
      'customer_note': customerNote,
      'merchant_note': merchantNote,
    };
    return await call(Uri.https(baseUrl, '/refund'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a list of refunds on your integration
  Future<Response> all(String reference, Currency currency,
      {String? from, String? to, int perPage = 50, int page = 1}) async {
    return await call(Uri.https(baseUrl, '/refund'), HttpMethod.get);
  }

  /// Retrieve a refund by it's id in your integration
  Future<Response> fetchOne(String reference) async {
    return await call(Uri.https(baseUrl, '/refund/$reference'), HttpMethod.get);
  }
}
