import 'package:paystack/src/enums.dart';

import '../base_client.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Subscriptions API which allows you create and
/// manage recurring payment on your integration.
class SubscriptionClient extends BaseClient {
  /// Create an instance of [SubscriptionClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [SubscriptionClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [SubscriptionClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `subscriptions` binding
  /// ## Example
  /// ```dart
  /// var client = SubscriptionClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.subscriptions.all();
  /// ```
  SubscriptionClient({super.secretKey});

  /// Create a subscription on your integration
  Future<Response> create(String customer, String plan, String authorization,
      {String? startDate}) async {
    var data = {
      'customer': customer,
      'plan': plan,
      'authorization': authorization,
      'start_date': startDate
    };
    return await call(Uri.https(baseUrl, '/subscription'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a list of all subscriptions available on your integration
  Future<Response> all(
      {int perPage = 50, int page = 1, String? customer, String? plan}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'page': page, 'customer': customer, 'plan': plan});
    return await call(
        Uri.https(baseUrl, '/subscription', queryParameters), HttpMethod.get);
  }

  /// Retrieve a single subscription on your integration by its id or code
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/subscription/$idOrCode'), HttpMethod.get);
  }

  /// Enable a subscription on your integration
  Future<Response> enable(String code, String token) async {
    return await call(
        Uri.https(baseUrl, '/subscription/enable'), HttpMethod.post,
        data: {'code': code, 'token': token});
  }

  /// Disable a subscription on your integration
  Future<Response> disable(String code, String token) async {
    return await call(
        Uri.https(baseUrl, '/subscription/disable'), HttpMethod.post,
        data: {'code': code, 'token': token});
  }

  /// Generate a link for updating the card on a subscription
  Future<Response> generateLink(String code) async {
    return await call(
        Uri.https(baseUrl, '/subscription/$code/manage/link/'), HttpMethod.get);
  }

  /// Email a customer a link for updating the card on their subscription
  Future<Response> sendLink(String code) async {
    return await call(Uri.https(baseUrl, '/subscription/$code/manage/email/'),
        HttpMethod.post);
  }
}
