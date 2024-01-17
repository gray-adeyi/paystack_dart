import '../base_client.dart';
import '../enums.dart';

class Subaccount {
  final String id;
  final double share;

  Subaccount(this.id, this.share);

  Map<String, String> toMap() {
    return {
      "subaccount": id,
      "share": share.toString(),
    };
  }

// TODO: implement a factory that generates a List<Subaccount> from
// a list of Map<String, String>
}

class TransactionSplitsClient extends BaseClient {
  TransactionSplitsClient({super.secretKey});

  Response createSplit(
      String name,
      SplitMode type,
      Currency currency,
      List<Subaccount> subaccounts,
      SubaccountChargeBearer bearerType,
      String bearerSubaccount) {
    Map<String, dynamic> data = {
      "name": name,
      "type": type.name,
      "currency": currency.paystackValue,
      "subaccounts": subaccounts.map((s) => s.toMap()).toList(),
      "bearer_type": bearerType,
      "bearer_subaccount": bearerSubaccount
    };
    return call(Uri.https(baseUrl, "/split"), HttpMethod.post, data: data);
  }

  Response all(String name, bool active,
      {String? sortBy,
      int perPage = 50,
      int page = 1,
      String? from,
      String? to}) {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
    });
    return call(Uri.https(baseUrl, "/split", queryParameters), HttpMethod.get);
  }

  Response fetchOne(String id) {
    return call(Uri.https(baseUrl, "/split/$id"), HttpMethod.get);
  }

  Response update(String id, String name, bool active,
      {SplitMode? type, String? bearerSubaccount}) {
    var data = {
      'name': name,
      'active': active,
      'bearer_type': type?.name,
      'bearer_subaccount': bearerSubaccount
    };
    return call(Uri.https(baseUrl, "/split/$id"), HttpMethod.put, data: data);
  }

  Response add(String id, String subaccount, double share) {
    var data = {'subaccount': subaccount, 'share': share};
    return call(
        Uri.https(baseUrl, "/split/$id/subaccount/add"), HttpMethod.post,
        data: data);
  }

  Response remove(String id, String subaccount) {
    var data = {'subaccount': subaccount};
    return call(
        Uri.https(baseUrl, "/split/$id/subaccount/remove"), HttpMethod.post,
        data: data);
  }
}
