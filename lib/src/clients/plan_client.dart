import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Plans API which allows you create and manage
/// installment payment options on your integration.
class PlanClient extends BaseClient {
  /// Create an instance of [PlanClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [PlanClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [PlanClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `plans` binding
  /// ## Example
  /// ```dart
  /// var client = PlanClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.plans.all();
  /// ```
  PlanClient({super.secretKey});

  /// Create a plan on your integration
  Future<Response> create(String name, int amount, Interval interval,
      {String? description,
      bool? sendInvoices,
      bool? sendSms,
      Currency? currency,
      int? invoiceLimit}) async {
    var data = {
      'name': name,
      'amount': amount,
      'interval': interval.name,
      'description': description,
      'send_invoices': sendInvoices,
      'send_sms': sendSms,
      'currency': currency?.paystackValue,
      'invoice_limit': invoiceLimit,
    };
    return await call(Uri.https(baseUrl, '/plan'), HttpMethod.post, data: data);
  }

  /// Retrieve a list of plans available on your integration
  Future<Response> all({
    int perPage = 50,
    int page = 1,
    String? status,
    Interval? interval,
    int? amount,
  }) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'status': status,
      'interval': interval?.name,
      'amount': amount
    });
    return await call(
        Uri.https(baseUrl, '/plan', queryParameters), HttpMethod.get);
  }

  /// Retrieve a plan on your integration by it's id or code
  Future<Response> fetchOne(String idOrCode) async {
    return await call(Uri.https(baseUrl, '/plan/$idOrCode'), HttpMethod.get);
  }

  /// Update a plan on your integration
  Future<Response> update(
      String idOrCode,
      String name,
      int amount,
      Interval interval,
      String? description,
      bool? sendInvoices,
      bool? sendSms,
      Currency? currency,
      int? invoiceLimit) async {
    var data = {
      'name': name,
      'amount': amount,
      'interval': interval.name,
      'description': description,
      'send_invoices': sendInvoices,
      'send_sms': sendSms,
      'currency': currency?.paystackValue,
      'invoice_limit': invoiceLimit
    };
    return await call(Uri.https(baseUrl, '/plan/$idOrCode'), HttpMethod.put,
        data: data);
  }
}
