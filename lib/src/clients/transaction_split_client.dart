import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Transaction Splits API which enables merchants split
/// the settlement for a transaction across their payout account,
/// and one or more subaccounts.
class TransactionSplitClient extends BaseClient {
  /// Create an instance of [TransactionSplitClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [TransactionSplitClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [TransactionSplitClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `transactionSplits` binding
  /// ## Example
  /// ```dart
  /// var client = TransactionSplitClient(
  /// secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.transactionSplits.all();
  /// ```
  TransactionSplitClient({super.secretKey});

  /// Create a split payment on your integration
  Future<Response> create(
      String name,
      SplitMode type,
      Currency currency,
      List<Subaccount> subaccounts,
      SubaccountChargeBearer bearerType,
      String bearerSubaccount) async {
    Map<String, dynamic> data = {
      "name": name,
      "type": type.name,
      "currency": currency.paystackValue,
      "subaccounts": subaccounts.map((s) => s.toMap()).toList(),
      "bearer_type": bearerType,
      "bearer_subaccount": bearerSubaccount
    };
    return await call(Uri.https(baseUrl, "/split"), HttpMethod.post,
        data: data);
  }

  /// Retrieve the list of the transaction splits available on your integration
  Future<Response> all(String name, bool active,
      {String? sortBy,
      int perPage = 50,
      int page = 1,
      String? from,
      String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, "/split", queryParameters), HttpMethod.get);
  }

  /// Retrieve a transaction split by its id
  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, "/split/$id"), HttpMethod.get);
  }

  /// Update a transaction split
  Future<Response> update(String id, String name, bool active,
      {SplitMode? type, String? bearerSubaccount}) async {
    var data = {
      'name': name,
      'active': active,
      'bearer_type': type?.name,
      'bearer_subaccount': bearerSubaccount
    };
    return await call(Uri.https(baseUrl, "/split/$id"), HttpMethod.put,
        data: data);
  }

  /// Add a Subaccount to a Transaction Split, or update the share of an
  /// existing Subaccount in a Transaction Split
  Future<Response> add(String id, String subaccount, double share) async {
    var data = {'subaccount': subaccount, 'share': share};
    return await call(
        Uri.https(baseUrl, "/split/$id/subaccount/add"), HttpMethod.post,
        data: data);
  }

  /// Remove a subaccount from a transaction split
  Future<Response> remove(String id, String subaccount) async {
    var data = {'subaccount': subaccount};
    return await call(
        Uri.https(baseUrl, "/split/$id/subaccount/remove"), HttpMethod.post,
        data: data);
  }
}
