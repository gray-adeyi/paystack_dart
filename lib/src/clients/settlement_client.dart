import '../base_client.dart';
import '../enums.dart';

class SettlementClient extends BaseClient {
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

  Future<Response> transactions(String settlementId,
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    return await call(
        Uri.https(baseUrl, '/settlement/$settlementId/transactions'),
        HttpMethod.get);
  }
}
