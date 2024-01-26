import '../base_client.dart';
import '../enums.dart';
import '../models.dart';

class PaymentRequest extends BaseClient {
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

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/$idOrCode'), HttpMethod.get);
  }

  Future<Response> verify(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/verify/$code'), HttpMethod.get);
  }

  Future<Response> sendNotification(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/notify/$code'), HttpMethod.post);
  }

  Future<Response> total() async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/totals'), HttpMethod.get);
  }

  Future<Response> finalize(String code, bool sendNotification) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/finalize/$code'), HttpMethod.post,
        data: {'send_notification': sendNotification});
  }

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
        Uri.https(baseUrl, '/paymentrequest/$idOrCode'), HttpMethod.put);
  }

  Future<Response> archive(String code) async {
    return await call(
        Uri.https(baseUrl, '/paymentrequest/archive/$code'), HttpMethod.post);
  }
}
