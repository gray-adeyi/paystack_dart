import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's Verification API which allows you perform KYC processes.
class VerificationClient extends BaseClient {
  /// Create an instance of [VerificationClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [VerificationClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [VerificationClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `verification` binding
  /// ## Example
  /// ```dart
  /// var client = VerificationClient(secretKey: "<your paystack secret key>");
  /// var response = await client.resolveAccount('3423452323', '801');
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.verification.resolveAccount(
  /// '3423452323', '801');
  /// ```
  VerificationClient({super.secretKey});

  /// Confirm an account belongs to the right customer
  Future<Response> resolveAccount(
    String accountNumber,
    String bankCode,
  ) async {
    return await call(
        Uri.https(baseUrl, '/bank/resolve',
            {'account_number': accountNumber, 'bank_code': bankCode}),
        HttpMethod.get);
  }

  /// Confirm the authenticity of a customer's account number
  /// before sending money
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

  /// Retrieve more information about a customer's card
  Future<Response> resolveCardBin(String bin) async {
    return await call(Uri.https(baseUrl, '/decision/bin/$bin'), HttpMethod.get);
  }
}
