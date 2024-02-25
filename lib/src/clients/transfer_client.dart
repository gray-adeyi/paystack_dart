import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Transfers API which allows you automate sending
/// money to your customers.
class TransferClient extends BaseClient {
  /// Create an instance of [TransferClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [TransferClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [TransferClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `transfers` binding
  /// ## Example
  /// ```dart
  /// var client = TransferClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.transfers.all();
  /// ```
  TransferClient({super.secretKey});

  /// Send money to your customers.
  //
  // Status of transfer object returned in the [Response.data] will be pending
  // if OTP is disabled. In the event that an OTP is required,
  // status will read otp.
  Future<Response> initiate(int amount, String recipient,
      {String source = 'balance',
      String? reason,
      Currency? currency,
      String? reference}) async {
    var data = {
      'amount': amount,
      'recipient': recipient,
      'source': source,
      'reason': reason,
      'currency': currency?.paystackValue,
      'reference': reference
    };
    return await call(Uri.https(baseUrl, '/transfer'), HttpMethod.post,
        data: data);
  }

  /// Finalize an initiated transfer
  Future<Response> finalize(String transferCode, String otp) async {
    return await call(
        Uri.https(baseUrl, '/transfer/finalize_transfer'), HttpMethod.post,
        data: {'transfer_code': transferCode, 'otp': otp});
  }

  /// Initiate multiple transfers in a single call as a batch.
  //
  // You need to disable the Transfers OTP requirement to
  // use this method.
  Future<Response> initiateBulk(List<Transfer> transfers,
      {String source = 'balance', Currency? currency}) async {
    var data = {
      'transfers': transfers.map((t) => t.toMap()).toList(),
      'source': source,
      'currency': currency?.paystackValue
    };
    return await call(Uri.https(baseUrl, '/transfer/bulk'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a list of transfers on your integration
  Future<Response> all(
      {int perPage = 50,
      int page = 1,
      String? customer,
      String? from,
      String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'customer': customer,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, '/transfer', queryParameters), HttpMethod.get);
  }

  /// Retrieve a transfer by its id or code
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transfer/$idOrCode'), HttpMethod.get);
  }

  /// Verify the status of a transfer on your integration
  Future<Response> verify(String reference) async {
    return await call(
        Uri.https(baseUrl, '/transfer/verify/$reference'), HttpMethod.get);
  }
}
