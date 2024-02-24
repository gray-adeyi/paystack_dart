import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Dedicated Virtual Account API which enables Nigerian
/// merchants to manage unique payment accounts of their customers.
class DedicatedVirtualAccountClient extends BaseClient {
  DedicatedVirtualAccountClient({super.secretKey});

  /// Create a dedicated virtual account for an existing customer.
  ///
  /// Note only Wema Bank and Titan Paystack is currently supported.
  Future<Response> create(
    String customer, {
    String? preferredBank,
    String? subaccount,
    String? splitCode,
    String? firstName,
    String? lastName,
    String? phone,
  }) async {
    var data = {
      'customer': customer,
      'preferred_bank': preferredBank,
      'subaccount': subaccount,
      'split_code': splitCode,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
    };
    return await call(Uri.https(baseUrl, '/dedicated_account'), HttpMethod.post,
        data: data);
  }

  /// Create a customer, validate the customer, and assign
  /// a DVA to the customer.
  Future<Response> assign(
    String email,
    String firstName,
    String lastName,
    String phone,
    String preferredBank, {
    Country country = Country.nigeria,
    String? accountNumber,
    String? bvn,
    String? bankCode,
    String? subaccount,
    List<String>? splitCode,
  }) async {
    var data = {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'preferred_bank': preferredBank,
      'country': country.code,
      'account_number': accountNumber,
      'bvn': bvn,
      'bank_code': bankCode,
      'subaccount': subaccount,
      'split_code': splitCode
    };
    return await call(
        Uri.https(baseUrl, '/dedicated_account/assign'), HttpMethod.post,
        data: data);
  }

  /// Retrieve all the dedicated virtual accounts available on your integration.
  Future<Response> all(bool active,
      {Currency currency = Currency.ngn,
      String? providerSlug,
      String? bankId,
      String? customer}) async {
    var queryParameters = normalizeQueryParameters({
      'active': active,
      'currency': currency.paystackValue,
      'provider_slug': providerSlug,
      'bank_id': bankId,
      'customer': customer,
    });
    return await call(Uri.https(baseUrl, '/dedicated_account', queryParameters),
        HttpMethod.get);
  }

  /// Retrieve a single dedicated virtual account available on your
  /// integration by it's id.
  Future<Response> fetchOne(String dedicatedAccountId) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/$dedicatedAccountId'),
        HttpMethod.get);
  }

  /// Requery a dedicated virtual account for new transactions.
  Future<Response> requery(String accountNumber, String providerSlug,
      {String? date}) async {
    var queryParameters = normalizeQueryParameters({
      'account_number': accountNumber,
      'provider_slug': providerSlug,
      'date': date,
    });
    return await call(Uri.https(baseUrl, '/dedicated_account', queryParameters),
        HttpMethod.get);
  }

  /// Deactivate a dedicated virtual account on your integration.
  Future<Response> deactivate(String dedicatedAccountId) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/$dedicatedAccountId'),
        HttpMethod.delete);
  }

  /// Split a dedicated virtual account transaction with one or more accounts
  Future<Response> splitTransaction(
    String customer, {
    String? subaccount,
    String? splitCode,
    String? preferredBank,
  }) async {
    var data = {
      'customer': customer,
      'subaccount': subaccount,
      'split_code': splitCode,
      'preferred_bank': preferredBank
    };
    return await call(
        Uri.https(baseUrl, '/dedicated_account/split'), HttpMethod.post,
        data: data);
  }

  /// If you've previously set up split payment for transactions on
  /// a dedicated virtual account, you can remove it with this method.
  Future<Response> removeSplit(String accountNumber) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/split'), HttpMethod.delete,
        data: {'account_number': accountNumber});
  }

  /// Retrieve bank providers for a dedicated virtual account.
  Future<Response> bankProviders() async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/available_providers'),
        HttpMethod.get);
  }
}
