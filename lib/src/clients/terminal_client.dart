import 'package:paystack/src/enums.dart';

import '../base_client.dart';

class TerminalData {
  final String id;
  final String reference;

  TerminalData(this.id, this.reference);

  Map<String, String> toMap() {
    return {
      "id": id,
      "reference": reference,
    };
  }
}

class TerminalClient extends BaseClient {
  TerminalClient({super.secretKey});

  Response sendEvent(String terminalId, TerminalEvent type,
      TerminalAction action, TerminalData data) {
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
    return call(
        Uri.https(baseUrl, '/terminal/$terminalId/event'), HttpMethod.post,
        data: payloadData);
  }

  Response eventStatus(String terminalId, String eventId) {
    return call(Uri.https(baseUrl, '/terminal/$terminalId/event/$eventId'),
        HttpMethod.get);
  }

  Response terminalStatus(String terminalId) {
    return call(
        Uri.https(baseUrl, '/terminal/$terminalId/presence'), HttpMethod.get);
  }

  Response all({int perPage = 50, int? next, int? previous}) {
    var queryParameters = normalizeQueryParameters(
        {'perPage': perPage, 'next': int, 'previous': previous});
    return call(
        Uri.https(baseUrl, '/terminal', queryParameters), HttpMethod.get);
  }

  Response fetchOne(String terminalId) {
    return call(Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.get);
  }

  Response update(String terminalId, {String? name, String? address}) {
    var data = {'name': name, 'address': address};
    return call(Uri.https(baseUrl, '/terminal/$terminalId'), HttpMethod.put,
        data: data);
  }

  Response commission(String serialNumber) {
    var data = {"serial_number": serialNumber};
    return call(
        Uri.https(baseUrl, '/terminal/commission_device'), HttpMethod.post,
        data: data);
  }

  Response decommission(String serialNumber) {
    var data = {"serial_number": serialNumber};
    return call(
        Uri.https(baseUrl, '/terminal/decommission_device'), HttpMethod.post,
        data: data);
  }
}
