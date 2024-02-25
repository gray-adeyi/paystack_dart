import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Settlements API which allows you gain insights into
/// payouts made by Paystack to your bank account.
class SettlementClient extends BaseClient {
  /// Create an instance of [SettlementClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [SettlementClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [SettlementClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `settlements` binding
  /// ## Example
  /// ```dart
  /// var client = SettlementClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.settlements.all();
  /// ```
  SettlementClient({super.secretKey});

  /// Retrieve a list of settlements made to your settlement accounts
  Future<Response> all(
      {int perPage = 50,
      int page = 50,
      SettlementStatus? status,
      String? subaccount,
      String? from,
      String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'status': status?.name,
      'subaccount': subaccount,
      'from': from,
      'to': to
    });
    return await call(
        Uri.https(baseUrl, '/settlement', queryParameters), HttpMethod.get);
  }

  /// Retrieve the transactions that make up a particular settlement
  Future<Response> transactions(String settlementId,
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    return await call(
        Uri.https(baseUrl, '/settlement/$settlementId/transactions'),
        HttpMethod.get);
  }
}
