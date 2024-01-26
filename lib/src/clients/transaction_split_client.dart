import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

class TransactionSplitClient extends BaseClient {
  TransactionSplitClient({super.secretKey});

  Future<Response> createSplit(
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

  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, "/split/$id"), HttpMethod.get);
  }

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

  Future<Response> add(String id, String subaccount, double share) async {
    var data = {'subaccount': subaccount, 'share': share};
    return await call(
        Uri.https(baseUrl, "/split/$id/subaccount/add"), HttpMethod.post,
        data: data);
  }

  Future<Response> remove(String id, String subaccount) async {
    var data = {'subaccount': subaccount};
    return await call(
        Uri.https(baseUrl, "/split/$id/subaccount/remove"), HttpMethod.post,
        data: data);
  }
}
