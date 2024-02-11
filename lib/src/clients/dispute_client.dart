import '../base_client.dart';
import '../enums.dart';

class DisputeClient extends BaseClient {
  DisputeClient({super.secretKey});

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

  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, '/dispute/$id'), HttpMethod.get);
  }

  Future<Response> transactionDisputes(String id) async {
    return await call(
        Uri.https(baseUrl, '/dispute/transaction/$id'), HttpMethod.get);
  }

  Future<Response> update(String id, int refundAmount,
      {String? uploadedFilename}) async {
    return await call(Uri.https(baseUrl, '/dispute/$id'), HttpMethod.put,
        data: {
          'refund_amount': refundAmount,
          'uploaded_filename': uploadedFilename
        });
  }

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

  Future<Response> uploadUrl(String id, String uploadFilename) async {
    return await call(
        Uri.https(baseUrl, '/dispute/$id/upload_url',
            {'upload_filename': uploadFilename}),
        HttpMethod.get);
  }

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
