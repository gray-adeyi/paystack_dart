import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Transfer Recipients API which allows you create
/// and manage beneficiaries that you send money to.
class TransferRecipientClient extends BaseClient {
  /// Create an instance of [TransferRecipientClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [TransferRecipientClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [TransferRecipientClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `transferRecipient` binding
  /// ## Example
  /// ```dart
  /// var client = TransferRecipientClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.transferRecipient.all();
  /// ```
  TransferRecipientClient({super.secretKey});

  /// Creates a new recipient.
  ///
  /// A duplicate account number will lead to the retrieval
  /// of the existing record.
  Future<Response> create(
    FinancialChannel type,
    String name, {
    String? bankCode,
    String? accountNumber,
    String? description,
    Currency? currency,
    String? authorizationCode,
    Map<String, dynamic>? metadata,
  }) async {
    var transferRecipient = TransferRecipient(type, name,
        bankCode: bankCode,
        accountNumber: accountNumber,
        description: description,
        currency: currency,
        authorizationCode: authorizationCode);
    return await call(Uri.https(baseUrl, '/transferrecipient'), HttpMethod.post,
        data: transferRecipient.toMap());
  }

  /// Create multiple transfer recipients in batches.
  ///
  /// A duplicate account number will lead to the retrieval
  /// of the existing record.
  Future<Response> bulkCreate(List<TransferRecipient> batch) async {
    var data = {'batch': batch.map((tr) => tr.toMap()).toList()};
    return await call(
        Uri.https(baseUrl, '/transferrecipient/bulk'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a list transfer recipients available on your integration
  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'from': from, 'to': to});
    return await call(Uri.https(baseUrl, '/transferrecipient', queryParameters),
        HttpMethod.get);
  }

  /// Retrieve a single transfer recipient by its id or code
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.get);
  }

  /// Update the details of transfer recipient
  Future<Response> update(String idOrCode, String name, {String? email}) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.put,
        data: {'name': name, 'email': email});
  }

  /// Delete a transfer recipient
  Future<Response> delete(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.delete);
  }
}
