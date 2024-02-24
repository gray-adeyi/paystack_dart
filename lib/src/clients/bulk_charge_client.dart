import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Bulk Charges API which allows you create and manage multiple
/// recurring payments for your customers.
class BulkChargeClient extends BaseClient {
  /// Create an instance of [BulkChargeClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [BulkChargeClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [BulkChargeClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `bulkCharges` binding
  /// ## Example
  /// ```dart
  /// var client = BulkChargeClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.bulkCharges.all();
  /// ```
  BulkChargeClient({super.secretKey});

  /// Process transactions as a batch.
  ///
  /// - [bulkCharge] is a `List` of the [Charge] model.
  Future<Response> initiate(List<Charge> bulkCharge) async {
    var data = {dataAsListKey: bulkCharge.map((bc) => bc.toMap()).toList()};
    return await call(Uri.https(baseUrl, '/bulkcharge'), HttpMethod.post,
        data: data, dataAsList: true);
  }

  /// Lists all bulk charge batches created by the integration.
  Future<Response> all({
    int perPage = 50,
    int page = 1,
    String? from,
    String? to,
    BulkChargeStatus? status,
  }) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
      'status': status?.name
    });
    return await call(
        Uri.https(baseUrl, '/bulkcharge', queryParameters), HttpMethod.get);
  }

  /// Retrieves a specific batch by its code or id.
  ///
  /// It also returns useful information on its progress by way of the
  /// `total_charges` and `pending_charges` attributes.
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/$idOrCode'), HttpMethod.get);
  }

  /// Retrieves the charges associated with a specified batch code.
  ///
  /// [idOrCode] is the id or code of the batch whose charges you want to
  /// retrieve.
  Future<Response> charges(
    String idOrCode, {
    int perPage = 50,
    int page = 1,
    String? from,
    String? to,
    BulkChargeStatus? status,
  }) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
      'status': status?.name
    });
    return await call(
        Uri.https(baseUrl, '/bulkcharge/$idOrCode/charges', queryParameters),
        HttpMethod.get);
  }

  /// Pause a processing batch
  Future<Response> pause(String batchCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/pause/$batchCode'), HttpMethod.get);
  }

  /// Resume a processing batch
  Future<Response> resume(String batchCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/resume/$batchCode'), HttpMethod.get);
  }
}
