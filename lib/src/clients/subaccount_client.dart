import 'package:paystack/src/enums.dart';

import '../base_client.dart';

class SubaccountClient extends BaseClient {
  SubaccountClient({super.secretKey});

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

  Future<Response> fetchOne(String idOrCode) async {
    return await call(
        Uri.https(baseUrl, '/subaccount/$idOrCode'), HttpMethod.get);
  }

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
