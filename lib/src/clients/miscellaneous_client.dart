import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Miscellaneous API which are supporting APIs that can be
/// used to provide more details to other APIs.
class MiscellaneousClient extends BaseClient {
  /// Create an instance of [MiscellaneousClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [MiscellaneousClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [MiscellaneousClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `bulkCharges` binding
  /// ## Example
  /// ```dart
  /// var client = MiscellaneousClient(secretKey: "<your paystack secret key>");
  /// var response = await client.banks(Country.nigeria,false);
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.miscellaneous.banks(Country.nigeria,false);
  /// ```
  MiscellaneousClient({super.secretKey});

  /// Retrieve a a list of all supported banks and their properties
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

  /// Retrieve a list of countries that Paystack currently supports
  Future<Response> countries() async {
    return await call(Uri.https(baseUrl, '/country'), HttpMethod.get);
  }

  /// Retrieve a list of states for a country for address verification
  Future<Response> states(Country country) async {
    return await call(
        Uri.https(
            baseUrl, '/address_verification/states', {'country': country.code}),
        HttpMethod.get);
  }
}
