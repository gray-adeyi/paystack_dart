import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Customers API which allows you create and manage
/// customers on your integration.
class CustomerClient extends BaseClient {
  /// Create an instance of [CustomerClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [CustomerClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [CustomerClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `customers` binding
  /// ## Example
  /// ```dart
  /// var client = CustomerClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.customers.all();
  /// ```
  CustomerClient({super.secretKey});

  /// Create a customer on your integration.
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

  /// Retrieve all the customers on your integration.
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

  /// Retrieve a single customer on your integration by their email or code.
  Future<Response> fetchOne(String emailOrCode) async {
    return await call(
        Uri.https(baseUrl, '/customer/$emailOrCode'), HttpMethod.get);
  }

  /// Update a customers information on your integration.
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

  /// Validate a customer's identity.
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

  /// Whitelist or Blacklist a customer on your integration.
  Future<Response> flag(String customer, RiskAction riskAction) async {
    var data = {
      'customer': customer,
      'risk_action': riskAction.paystackValue,
    };
    return await call(
        Uri.https(baseUrl, '/customer/set_risk_action'), HttpMethod.post,
        data: data);
  }

  /// Deactivate an authorization when the card needs to be forgotten.
  Future<Response> deactivate(String authorizationCode) async {
    return await call(Uri.https(baseUrl, '/customer/deactivate_authorization'),
        HttpMethod.post,
        data: {'authorization_code': authorizationCode});
  }
}
