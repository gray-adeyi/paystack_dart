import 'package:paystack/src/enums.dart';

import '../base_client.dart';

class IntegrationClient extends BaseClient {
  Future<Response> timeout() async {
    return await call(
        Uri.https(baseUrl, '/integration/payment_session_timeout'),
        HttpMethod.get);
  }

  Future<Response> updateTimeout(int timeout) async {
    return await call(
        Uri.https(baseUrl, '/integration/payment_session_timeout'),
        HttpMethod.put,
        data: {'timeout': timeout});
  }
}
