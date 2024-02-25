import '../base_client.dart';
import '../enums.dart';
import '../exceptions.dart';
import '../models.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Terminal API which allows you to build delightful
/// in-person payment experiences.
class TerminalClient extends BaseClient {
  /// Create an instance of [TerminalClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [BulkChargeClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [TerminalClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `terminals` binding
  /// ## Example
  /// ```dart
  /// var client = TerminalClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.terminals.all();
  /// ```
  TerminalClient({super.secretKey});

  /// Send an event from your application to the Paystack Terminal
  Future<Response> sendEvent(String terminalId, TerminalEvent type,
      TerminalAction action, TerminalData data) async {
    var supportedInvoiceEventActions = [
      TerminalAction.process,
      TerminalAction.view
    ];
    var supportedTransactionEventActions = [
      TerminalAction.process,
      TerminalAction.print
    ];
    if (type == TerminalEvent.invoice &&
        !supportedInvoiceEventActions.contains(action)) {
      throw ApiException(
          "$type terminal event only supports $supportedInvoiceEventActions actions");
    }
    if (type == TerminalEvent.transaction &&
        !supportedTransactionEventActions.contains(action)) {
      throw ApiException(
          "$type terminal event only supports $supportedTransactionEventActions actions");
    }
    Map<String, dynamic> payloadData = {
      "type": type.name,
      "action": action.name,
      "data": data.toMap()
    };
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/event'), HttpMethod.post,
        data: payloadData);
  }

  /// Check the status of an event sent to the Terminal
  Future<Response> eventStatus(String terminalId, String eventId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/event/$eventId'),
        HttpMethod.get);
  }

  /// Check the availability of a Terminal before sending an event to it
  Future<Response> terminalStatus(String terminalId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/presence'), HttpMethod.get);
  }

  /// Retrieve the list of terminals available on your integration
  Future<Response> all({int perPage = 50, int? next, int? previous}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'next': int, 'previous': previous});
    return await call(
        Uri.https(baseUrl, '/terminal', queryParameters), HttpMethod.get);
  }

  /// Retrieve a single terminal on your integration by its id
  Future<Response> fetchOne(String terminalId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.get);
  }

  /// Update the detail on a terminal
  Future<Response> update(String terminalId,
      {String? name, String? address}) async {
    var data = {'name': name, 'address': address};
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.put,
        data: data);
  }

  /// Activate your debug device by linking it to your integration
  Future<Response> commission(String serialNumber) async {
    var data = {"serial_number": serialNumber};
    return await call(
        Uri.https(baseUrl, '/terminal/commission_device'), HttpMethod.post,
        data: data);
  }

  /// Unlink your debug device from your integration
  Future<Response> decommission(String serialNumber) async {
    var data = {"serial_number": serialNumber};
    return await call(
        Uri.https(baseUrl, '/terminal/decommission_device'), HttpMethod.post,
        data: data);
  }
}
