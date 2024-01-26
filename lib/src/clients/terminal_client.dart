import 'package:paystack/src/enums.dart';

import '../base_client.dart';
import '../models.dart';

class TerminalClient extends BaseClient {
  TerminalClient({super.secretKey});

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
        !supportedInvoiceEventActions.contains(action))
      throw "$type terminal event only supports $supportedInvoiceEventActions actions";
    if (type == TerminalEvent.transaction &&
        !supportedTransactionEventActions.contains(action))
      throw "$type terminal event only supports $supportedTransactionEventActions actions";
    Map<String, dynamic> payloadData = {
      "type": type.name,
      "action": action.name,
      "data": data.toMap()
    };
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/event'), HttpMethod.post,
        data: payloadData);
  }

  Future<Response> eventStatus(String terminalId, String eventId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/event/$eventId'),
        HttpMethod.get);
  }

  Future<Response> terminalStatus(String terminalId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId/presence'), HttpMethod.get);
  }

  Future<Response> all({int perPage = 50, int? next, int? previous}) async {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'next': int, 'previous': previous});
    return await call(
        Uri.https(baseUrl, '/terminal', queryParameters), HttpMethod.get);
  }

  Future<Response> fetchOne(String terminalId) async {
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.get);
  }

  Future<Response> update(String terminalId,
      {String? name, String? address}) async {
    var data = {'name': name, 'address': address};
    return await call(
        Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.put,
        data: data);
  }

  Future<Response> commission(String serialNumber) async {
    var data = {"serial_number": serialNumber};
    return await call(
        Uri.https(baseUrl, '/terminal/commission_device'), HttpMethod.post,
        data: data);
  }

  Future<Response> decommission(String serialNumber) async {
    var data = {"serial_number": serialNumber};
    return await call(
        Uri.https(baseUrl, '/terminal/decommission_device'), HttpMethod.post,
        data: data);
  }
}
