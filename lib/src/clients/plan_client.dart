import '../base_client.dart';
import '../enums.dart';

class PlanClient extends BaseClient {
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

  Future<Response> fetchOne(String idOrCode) async {
    return await call(Uri.https(baseUrl, '/plan/$idOrCode'), HttpMethod.get);
  }

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
