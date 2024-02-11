import '../base_client.dart';
import '../enums.dart';

class VerificationClient extends BaseClient {
  VerificationClient({super.secretKey});

  Future<Response> resolveAccount(
    String accountNumber,
    String bankCode,
  ) async {
    return await call(
        Uri.https(baseUrl, '/bank/resolve',
            {'account_number': accountNumber, 'bank_code': bankCode}),
        HttpMethod.get);
  }

  Future<Response> validateAccount(
      String accountName,
      String accountNumber,
      AccountType accountType,
      String bankCode,
      Country country,
      DocumentType documentType,
      {String? documentNumber}) async {
    var data = {
      'account_name': accountName,
      'account_number': accountNumber,
      'account_type': accountType.name,
      'bank_code': bankCode,
      'country_code': country.code,
      'document_type': documentType.name,
      'document_number': documentNumber
    };
    return await call(Uri.https(baseUrl, '/bank/validate'), HttpMethod.post,
        data: data);
  }

  Future<Response> resolveCardBin(String bin) async {
    return await call(Uri.https(baseUrl, '/decision/bin/$bin'), HttpMethod.get);
  }
}
