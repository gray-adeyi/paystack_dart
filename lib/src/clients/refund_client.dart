import '../base_client.dart';
import '../enums.dart';

class RefundClient extends BaseClient {
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

  Future<Response> all(String reference, Currency currency,
      {String? from, String? to, int perPage = 50, int page = 1}) async {
    return await call(Uri.https(baseUrl, '/refund'), HttpMethod.get);
  }

  Future<Response> fetchOne(String reference) async {
    return await call(Uri.https(baseUrl, '/refund/$reference'), HttpMethod.get);
  }
}
