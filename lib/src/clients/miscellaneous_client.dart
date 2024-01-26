import '../base_client.dart';
import '../enums.dart';

class MiscellaneousClient extends BaseClient {
  Future<Response> banks(Country country, bool useCursor,
      {int perPage = 50,
      bool? payWithBankTransfer,
      bool? payWithBank,
      String? next,
      String? previous,
      Gateway? gateway,
      FinancialChannel? type,
      Currency? currency}) async {
    var queryParameters = normalizeQueryParameters({
      'country': country.fullName,
      'use_cursor': useCursor,
      'perPage': perPage,
      'pay_with_bank_transfer': payWithBankTransfer,
      'pay_with_bank': payWithBank,
      'next': next,
      'previous': previous,
      'gateway': gateway?.name,
      'type': type?.paystackValue,
      'currency': currency?.paystackValue,
    });
    return await call(
        Uri.https(baseUrl, '/bank', queryParameters), HttpMethod.get);
  }

  Future<Response> countries() async {
    return await call(Uri.https(baseUrl, '/country'), HttpMethod.get);
  }

  Future<Response> states(Country country) async {
    return await call(
        Uri.https(
            baseUrl, '/address_verification/states', {'country': country.code}),
        HttpMethod.get);
  }
}
