import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

class BulkChargeClient extends BaseClient {
  Future<Response> initiate(List<Charge> bulkCharge) async {
    var data = {dataAsListKey: bulkCharge.map((bc) => bc.toMap()).toList()};
    return await call(Uri.https(baseUrl, '/bulkcharge'), HttpMethod.post,
        data: data, dataAsList: true);
  }

  Future<Response> all({
    int perPage = 50,
    int page = 1,
    String? from,
    String? to,
  }) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'from': from, 'to': to});
    return await call(
        Uri.https(baseUrl, '/bulkcharge', queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/$idOrCode'), HttpMethod.get);
  }

  Future<Response> charges(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/$idOrCode/charges'), HttpMethod.get);
  }

  Future<Response> pause(String batchCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/pause/$batchCode'), HttpMethod.get);
  }

  Future<Response> resume(String batchCode) async {
    return await call(
        Uri.https(baseUrl, '/bulkcharge/resume/$batchCode'), HttpMethod.get);
  }
}
