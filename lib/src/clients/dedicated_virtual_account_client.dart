import '../base_client.dart';
import '../enums.dart';

class DedicatedVirtualAccountClient extends BaseClient {
  DedicatedVirtualAccountClient({super.secretKey});

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

  Future<Response> fetchOne(String dedicatedAccountId) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/$dedicatedAccountId'),
        HttpMethod.get);
  }

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

  Future<Response> deactivate(String dedicatedAccountId) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/$dedicatedAccountId'),
        HttpMethod.delete);
  }

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

  Future<Response> removeSplit(String accountNumber) async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/split'), HttpMethod.delete,
        data: {'account_number': accountNumber});
  }

  Future<Response> bankProviders() async {
    return await call(
        Uri.https(baseUrl, '/dedicated_account/available_providers'),
        HttpMethod.get);
  }
}
