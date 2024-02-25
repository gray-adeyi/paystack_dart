import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Payment Requests API which allows you manage requests
/// for payment of goods and services.
class PaymentRequestClient extends BaseClient {
  /// Create an instance of [PaymentRequestClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [PaymentRequestClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [PaymentRequestClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `paymentRequests` binding
  /// ## Example
  /// ```dart
  /// var client = PaymentRequestClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.paymentRequests.all();
  /// ```
  PaymentRequestClient({super.secretKey});

  /// Create a payment request for a transaction on your integration
  Future<Response> create(String customer, int amount,
      {String? dueDate,
      String? description,
      List<LineItem>? lineItems,
      List<Tax>? tax,
      Currency? currency,
      bool? sendNotification,
      bool? draft,
      bool? hasInvoice,
      int? invoiceNumber,
      String? splitCode}) async {
    var data = {
      'customer': customer,
      'amount': amount,
      'due_date': dueDate,
      'description': description,
      'line_items': lineItems?.map((l) => l.toMap()).toList(),
      'tax': tax?.map((t) => t.toMap()).toList(),
      'currency': currency?.paystackValue,
      'send_notification': sendNotification,
      'draft': draft,
      'has_invoice': hasInvoice,
      'invoice_number': invoiceNumber,
      'split_code': splitCode,
    };
    return await call(Uri.https(baseUrl, '/paymentrequest'), HttpMethod.post,
        data: data);
  }

  /// Retrieve the payment requests available on your integration
  Future<Response> all(
      {int perPage = 50,
      int page = 1,
      String? customer,
      String? status,
      Currency? currency,
      bool? includeArchive,
      String? from,
      String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'customer': customer,
      'status': status,
      'currency': currency,
      'include_archive': includeArchive,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, '/paymentrequest', queryParameters), HttpMethod.get);
  }

  /// Retrieve the details of a payment request on your integration
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/$idOrCode'), HttpMethod.get);
  }

  /// Verify details of a payment request on your integration
  Future<Response> verify(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/verify/$code'), HttpMethod.get);
  }

  /// Send notification of a payment request to your customers
  Future<Response> sendNotification(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/notify/$code'), HttpMethod.post);
  }

  /// Retrieve payment requests metric
  Future<Response> total() async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/totals'), HttpMethod.get);
  }

  /// Finalize a draft payment request
  Future<Response> finalize(String code, bool sendNotification) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/finalize/$code'), HttpMethod.post,
        data: {'send_notification': sendNotification});
  }

  /// Update the details of a payment request on your integration
  Future<Response> update(
    String idOrCode,
    String customer,
    int amount, {
    String? dueDate,
    String? description,
    List<LineItem>? lineItems,
    List<Tax>? tax,
    Currency? currency,
    bool? sendNotification,
    bool? draft,
    int? invoiceNumber,
    String? splitCode,
  }) async {
    var data = {
      'customer': customer,
      'amount': amount,
      'due_date': dueDate,
      'description': description,
      'line_items': lineItems?.map((l) => l.toMap()).toList(),
      'tax': tax?.map((t) => t.toMap()).toList(),
      'currency': currency?.paystackValue,
      'send_notification': sendNotification,
      'draft': draft,
      'invoice_number': invoiceNumber,
      'split_code': splitCode
    };
    return await call(
        Uri.https(baseUrl, '/paymentrequest/$idOrCode'), HttpMethod.put,
        data: data);
  }

  /// Archive a payment request
  ///
  /// An archived payment request will no longer be retrieved on
  /// call to [all] or [verify]
  Future<Response> archive(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/archive/$code'), HttpMethod.post);
  }
}
