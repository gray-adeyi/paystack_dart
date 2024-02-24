import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Transactions API which allows you create and manage payments
/// on your integration.
class TransactionClient extends BaseClient {
  TransactionClient({super.secretKey});

  /// Initialize a transaction from your backend.
  ///
  /// - [amount] should be in the subunit of the supported currency.
  /// - [email] is the customer's email address.
  /// - The transaction [currency] defaults to your integration currency.
  /// - Unique transaction [reference] is required. Only -, ., = and
  ///   alphanumeric characters allowed.
  /// - Fully qualified url, e.g. https://example.com/ . Use [callbackUrl] to
  ///   override the callback url provided on the dashboard for
  ///   this transaction.
  /// - If transaction is to create a subscription to a predefined plan,
  ///   provide [plan] code. This would invalidate the value
  ///   provided in [amount].
  /// - [invoiceLimit] is the number of times to charge a customer during
  ///   subscription to a plan.
  ///  - [metadata] is for custom data. Kindly check the
  ///  [Metadata](https://paystack.com/docs/payments/metadata/) page for
  ///   more information.
  ///   - [channels] is a list of payment channels to control what channels
  ///   you want to make available to the user to make a payment with.
  ///   - [splitCode] is the split code of the transaction split.
  ///   e.g. `SPL_98WF13Eb3w`.
  ///   - [subaccount] is the code for the subaccount that owns the payment.
  ///   e.g. `ACCT_8f4s1eq7ml6rlzj`.
  ///   - [transactionCharge] is an amount used to override the split
  ///   configuration for a single split payment. If set, the amount
  ///   specified goes to the main account regardless of the
  ///   split configuration.
  ///   [bearer] specifies who bears Paystack charges.
  Future<Response> initialize(int amount, String email,
      {Currency currency = Currency.ngn,
      String? reference,
      String? callbackUrl,
      String? plan,
      int? invoiceLimit,
      Map<String, dynamic>? metadata,
      List<PaymentChannel>? channels,
      String? splitCode,
      String? subaccount,
      int? transactionCharge,
      ChargeBearer? bearer}) async {
    Map<String, dynamic> data = {
      "amount": amount,
      "email": email,
      "currency": currency.paystackValue,
      "reference": reference,
      "callback_url": callbackUrl,
      "plan": plan,
      "invoice_limit": invoiceLimit,
      "metadata": metadata,
      "channels": channels?.map((e) => e.name).toList(),
      "split_code": splitCode,
      "subaccount": subaccount,
      "transaction_charge": transactionCharge,
      "bearer": bearer
    };
    return await call(
        Uri.https(baseUrl, "/transaction/initialize"), HttpMethod.post,
        data: data);
  }

  /// Confirm the status of a transaction
  ///
  /// - [reference] is the transaction reference used to initiate the transaction
  ///
  /// ### Transaction ID data type
  /// If you plan to store or make use of the the transaction ID, you should
  /// represent it as a unsigned 64-bit integer. To learn more,
  /// [check out paystack's changelog](https://paystack.com/docs/changelog/api/#june-2022).
  Future<Response> verify(String reference) async {
    return await call(
        Uri.https(baseUrl, "/transaction/verify/$reference"), HttpMethod.get);
  }

  /// Retrieve transactions carried out on your integration.
  ///
  /// - [perPage] specifies how many records you want to retrieve per page.
  /// If not specified, it defaults to 50.
  /// - [page] specifies exactly what page you want to retrieve. If not
  /// specified, it defaults to 1.
  /// - [customer] specifies an ID for the customer whose transactions
  /// you want to retrieve.
  /// - [terminalId] specifies the Terminal ID for the transactions
  /// you want to retrieve.
  /// - [status] lets you filter transactions by status.
  /// - [from] is a timestamp from which to start listing transaction
  /// e.g. `2016-09-24T00:00:05.000Z`, `2016-09-21`.
  /// - [to] is a timestamp at which to stop listing transaction
  /// e.g. `2016-09-24T00:00:05.000Z`, `2016-09-21`.
  /// - [amount] lets you filter transactions by amount using the
  /// supported currency code
  ///
  /// ### Transaction ID data type
  /// If you plan to store or make use of the the transaction ID, you should
  /// represent it as a unsigned 64-bit integer. To learn more,
  /// [check out paystack's changelog](https://paystack.com/docs/changelog/api/#june-2022).
  Future<Response> all({
    int perPage = 50,
    int page = 1,
    String? customer,
    String? terminalId,
    TransactionStatus? status,
    String? from,
    String? to,
    int? amount,
  }) async {
    Map<String, dynamic> queryParameters = normalizeQueryParameters({
      "perPage": perPage.toString(),
      "page": page.toString(),
      "customer": customer,
      "terminalid": terminalId,
      "status": status?.name,
      "from": from,
      "to": to,
      "amount": amount,
    });
    return await call(
        Uri.https(baseUrl, "/transaction", queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String id) async {
    return await call(Uri.https(baseUrl, '/transaction/$id'), HttpMethod.get);
  }

  Future<Response> charge(int amount, String email, String authorizationCode,
      {String? reference,
      Currency? currency,
      Map<String, dynamic>? metadata,
      List<PaymentChannel>? channels,
      String? subaccount,
      String? transactionCharge,
      ChargeBearer? bearer,
      bool? queue}) async {
    return await call(Uri.https(baseUrl, "/transaction/charge_authorization"),
        HttpMethod.post);
  }

  Future<Response> timeline(String idOrReference) async {
    return await call(
        Uri.https(baseUrl, "/transaction/timeline/$idOrReference"),
        HttpMethod.get);
  }

  Future<Response> totals({
    int perPage = 50,
    int page = 1,
    String? from,
    String? to,
  }) async {
    return await call(
        Uri.https(baseUrl, "/transaction/totals"), HttpMethod.get);
  }

  Future<Response> export(
      {int perPage = 50,
      int page = 1,
      String? from,
      String? to,
      String? customer,
      TransactionStatus? status,
      Currency? currency,
      int? amount,
      bool? settled,
      String? settlement,
      String? paymentPage}) async {
    return await call(
        Uri.https(baseUrl, "/transaction/export"), HttpMethod.get);
  }

  Future<Response> partialDebit(
      String authorizationCode, Currency currency, int amount, String email,
      {String? reference, int? atLeast}) async {
    return await call(Uri.https(baseUrl), HttpMethod.post);
  }
}
