import '../base_client.dart';
import '../enums.dart';

class TransferControlClient extends BaseClient {
  Future<Response> balance() async {
    return await call(Uri.https(baseUrl, '/balance'), HttpMethod.get);
  }

  Future<Response> balanceLedger() async {
    return await call(Uri.https(baseUrl, '/balance/ledger'), HttpMethod.get);
  }

  Future<Response> resendOtp(String transferCode, String reason) async {
    return await call(
        Uri.https(baseUrl, '/transfer/resend_otp'), HttpMethod.post,
        data: {'transfer_code': transferCode, 'reason': reason});
  }

  Future<Response> disableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/disable_otp'), HttpMethod.post);
  }

  Future<Response> finalizeDisableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/disable_otp_finalize'), HttpMethod.post);
  }

  Future<Response> enableOtp() async {
    return await call(
        Uri.https(baseUrl, '/transfer/enable_otp'), HttpMethod.post);
  }
}
