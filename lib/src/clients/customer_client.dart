import '../base_client.dart';
import '../enums.dart';

class CustomerClient extends BaseClient {
  CustomerClient({super.secretKey});

  Future<Response> create(String email, String firstName, String lastName,
      {String? phone, Map<String, dynamic>? metadata}) async {
    var data = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'metadata': metadata,
    };
    return await call(Uri.https(baseUrl, '/customer'), HttpMethod.post,
        data: data);
  }

  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, '/customer', queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String emailOrCode) async {
    return await call(
        Uri.https(baseUrl, '/customer/$emailOrCode'), HttpMethod.get);
  }

  Future<Response> update(String code, String firstName, String lastName,
      {String? phone, Map<String, dynamic>? metadata}) async {
    var data = {
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'metadata': metadata,
    };
    return await call(Uri.https(baseUrl, '/customer/$code'), HttpMethod.put,
        data: data);
  }

  Future<Response> validate(
      String code,
      String firstName,
      String lastName,
      String value,
      Country country,
      String bvn,
      String bankCode,
      String accountNumber,
      {String type = 'bank_account',
      String? middleName}) async {
    var data = {
      'first_name': firstName,
      'last_name': lastName,
      'value': value,
      'country': country.code,
      'bvn': bvn,
      'bank_code': bankCode,
      'account_number': accountNumber,
      'middle_name': middleName
    };
    return await call(
        Uri.https(baseUrl, '/customer/$code/identification'), HttpMethod.post,
        data: data);
  }

  Future<Response> flag(String customer, RiskAction riskAction) async {
    var data = {
      'customer': customer,
      'risk_action': riskAction.paystackValue,
    };
    return await call(
        Uri.https(baseUrl, '/customer/set_risk_action'), HttpMethod.post,
        data: data);
  }

  Future<Response> deactivate(String authorizationCode) async {
    return await call(Uri.https(baseUrl, '/customer/deactivate_authorization'),
        HttpMethod.post,
        data: {'authorization_code': authorizationCode});
  }
}
