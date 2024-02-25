import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirror endpoints provided by
/// Paystack's API which allows you manage settings of your transfers.
class TransferControlClient extends BaseClient {
  /// Create an instance of [TransferControlClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [BulkChargeClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [BulkChargeClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `transferControl` binding
  /// ## Example
  /// ```dart
  /// var client = BulkChargeClient(secretKey: "<your paystack secret key>");
  /// var response = await client.enableOtp();
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.transferControl.enableOtp();
  /// ```
  TransferControlClient({super.secretKey});

  /// Retrieve the available balance on your integration
  Future<Response> balance() async {
    return await call(Uri.https(baseUrl, '/balance'), HttpMethod.get);
  }

  /// Retrieves all pay-ins and pay-outs that occurred on your integration
  Future<Response> balanceLedger() async {
    return await call(Uri.https(baseUrl, '/balance/ledger'), HttpMethod.get);
  }

  /// Generate a new OTP and sends to customer in the event
  /// they are having trouble receiving one.
  Future<Response> resendOtp(String transferCode, String reason) async {
    return await call(
        Uri.https(baseUrl, '/transfer/resend_otp'), HttpMethod.post,
        data: {'transfer_code': transferCode, 'reason': reason});
  }

  /// Use this method in the event that you want to be able to complete
  /// transfers programmatically without use of OTPs.
  /// You will get an OTP to complete the request.
  Future<Response> disableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/disable_otp'), HttpMethod.post);
  }

  /// Finalize the request to disable OTP on your transfers.
  Future<Response> finalizeDisableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/disable_otp_finalize'), HttpMethod.post);
  }

  /// Use this method in the event that you want to stop being able to
  /// complete transfers programmatically, this method helps turn
  /// OTP requirement back on.
  Future<Response> enableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/enable_otp'), HttpMethod.post);
  }
}
