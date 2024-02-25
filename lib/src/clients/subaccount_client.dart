import 'package:paystack/src/enums.dart';

import '../base_client.dart';

/// It provides methods that mirror endpoints by
/// Paystack's Subaccounts API which allows you create and manage
/// subaccounts on your integration. Subaccounts can be used to
/// split payment between two accounts (your main account and a sub account).
class SubaccountClient extends BaseClient {
  /// Create an instance of [SubaccountClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [SubaccountClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [SubaccountClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `subaccounts` binding
  /// ## Example
  /// ```dart
  /// var client = SubaccountClient(secretKey: "<your paystack secret key>");
  /// var response = await client.all();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.subaccounts.all();
  /// ```
  SubaccountClient({super.secretKey});

  /// Create a subacount on your integration
  Future<Response> create(String businessName, String settlementBank,
      String accountNumber, double percentageCharge, String description,
      {String? primaryContactEmail,
      String? primaryContactName,
      String? primaryContactPhone,
      Map<String, dynamic>? metadata}) async {
    var data = {
      'business_name': businessName,
      'settlement_bank': settlementBank,
      'account_number': accountNumber,
      'percentage_charge': percentageCharge,
      'description': description,
      'primary_contact_email': primaryContactEmail,
      'primary_contact_name': primaryContactName,
      'primary_contact_phone': primaryContactPhone,
      'metadata': metadata,
    };
    return await call(Uri.https(baseUrl, '/subaccount'), HttpMethod.post,
        data: data);
  }

  /// Retrieve a list of subaccounts available on your integration
  Future<Response> all(
      {int perPage = 50, int page = 1, String? from, String? to}) async {
    var queryParameters = normalizeQueryParameters({
      'perPage': perPage,
      'page': page,
      'from': from,
      'to': to,
    });
    return await call(
        Uri.https(baseUrl, '/subaccount', queryParameters), HttpMethod.get);
  }

  /// Retrieve a subaccount on your integration by its id or code
  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/subaccount/$idOrCode'), HttpMethod.get);
  }

  /// Update the details of a subaccount
  Future<Response> update(
      String idOrCode, String businessName, String settlementBank,
      {String? accountNumber,
      bool? active,
      double? percentageCharge,
      String? description,
      String? primaryContactEmail,
      String? primaryContactName,
      String? primaryContactPhone,
      SettlementSchedule settlementSchedule = SettlementSchedule.auto,
      Map<String, dynamic>? metadata}) async {
    var data = {
      'business_name': businessName,
      'settlement_bank': settlementBank,
      'account_number': accountNumber,
      'active': active,
      'percentage_charge': percentageCharge,
      'description': description,
      'primary_contact_email': primaryContactEmail,
      'primary_contact_name': primaryContactName,
      'primary_contact_phone': primaryContactPhone,
      'settlement_schedule': settlementSchedule,
      'metadata': metadata
    };
    return await call(
        Uri.https(baseUrl, '/subaccount/$idOrCode'), HttpMethod.put,
        data: data);
  }
}
