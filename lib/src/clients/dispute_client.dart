import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Disputes API which allows you manage transaction
/// disputes on your integration.
class DisputeClient extends BaseClient {
  /// Create an instance of [DisputeClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [DisputeClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [CustomerClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `disputes` binding
  /// ## Example
  /// ```dart
  /// var client = DisputeClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.disputes.all();
  /// ```
  DisputeClient({super.secretKey});

  /// Retrieve all the disputes filed against your integration.
  Future<Response> all(
    String from,
    String to, {
    int perPage = 50,
    int page = 1,
    String? transaction,
    DisputeStatus? status,
  }) async {
    var queryParameters = normalizeQueryParameters({
      'from': from,
      'to': to,
      'perPage': perPage,
      'page': page,
      'transaction': transaction,
      'status': status?.paystackValue
    });
    return await call(
        Uri.https(baseUrl, '/dispute', queryParameters), HttpMethod.get);
  }

  /// Retrieve a single dispute by it's id
  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, '/dispute/$id'), HttpMethod.get);
  }

  /// Retrieve the dispute for a transaction.
  ///
  /// - [id] is id of transaction whose dispute you want to retrieve.
  Future<Response> transactionDisputes(String id) async {
    return await call(
        Uri.https(baseUrl, '/dispute/transaction/$id'), HttpMethod.get);
  }

  /// Update the details of a dispute.
  Future<Response> update(String id, int refundAmount,
      {String? uploadedFilename}) async {
    return await call(Uri.https(baseUrl, '/dispute/$id'), HttpMethod.put,
        data: {
          'refund_amount': refundAmount,
          'uploaded_filename': uploadedFilename
        });
  }

  /// Provide evidence for a dispute.
  Future<Response> addEvidence(String id, String customerEmail,
      String customerName, String customerPhone, String serviceDetails,
      {String? deliveryAddress, String? deliveryDate}) async {
    var data = {
      'customer_email': customerEmail,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'service_details': serviceDetails,
      'delivery_address': deliveryAddress,
      'delivery_date': deliveryDate
    };
    return await call(
        Uri.https(baseUrl, '/dispute/$id/evidence'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a url to upload additional evidence.
  Future<Response> uploadUrl(String id, String uploadFilename) async {
    return await call(
        Uri.https(baseUrl, '/dispute/$id/upload_url',
            {'upload_filename': uploadFilename}),
        HttpMethod.get);
  }

  /// Resolve a dispute on your integration.
  Future<Response> resolve(String id, DisputeResolution resolution,
      String message, int refundAmount, String uploadedFilename,
      {String? evidence}) async {
    var data = {
      'resolution': resolution.paystackValue,
      'message': message,
      'refund_amount': refundAmount,
      'uploaded_filename': uploadedFilename,
      'evidence': evidence
    };
    return await call(
        Uri.https(baseUrl, '/dispute/$id/resolve'), HttpMethod.put,
        data: data);
  }

  /// Export disputes available on your integration.
  Future<Response> export(String from, String to,
      {int perPage = 50,
      int page = 1,
      String? transaction,
      DisputeStatus? status}) async {
    var queryParameters = normalizeQueryParameters({
      'from': from,
      'to': to,
      'perPage': perPage,
      'page': page,
      'transaction': transaction,
      'status': status?.paystackValue
    });
    return await call(
        Uri.https(baseUrl, '/dispute/export', queryParameters), HttpMethod.get);
  }
}
