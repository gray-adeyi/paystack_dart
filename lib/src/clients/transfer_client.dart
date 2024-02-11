import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

class TransferClient extends BaseClient {
  TransferClient({super.secretKey});

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

  Future<Response> finalize(String transferCode, String otp) async {
    return await call(
        Uri.https(baseUrl, '/transfer/finalize_transfer'), HttpMethod.post,
        data: {'transfer_code': transferCode, 'otp': otp});
  }

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

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transfer/$idOrCode'), HttpMethod.get);
  }

  Future<Response> verify(String reference) async {
    return await call(
        Uri.https(baseUrl, '/transfer/verify/$reference'), HttpMethod.get);
  }
}
