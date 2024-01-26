import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

class TransferRecipientClient extends BaseClient {
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

  Future<Response> bulkCreate(List<TransferRecipient> batch) async {
    var data = {'batch': batch.map((tr) => tr.toMap()).toList()};
    return await call(
        Uri.https(baseUrl, '/transferrecipient/bulk'), HttpMethod.post,
        data: data);
  }

  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'from': from, 'to': to});
    return await call(Uri.https(baseUrl, '/transferrecipient', queryParameters),
        HttpMethod.get);
  }

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.get);
  }

  Future<Response> update(String idOrCode, String name, {String? email}) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.put,
        data: {'name': name, 'email': email});
  }

  Future<Response> delete(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/transferrecipient/$idOrCode'), HttpMethod.delete);
  }
}
