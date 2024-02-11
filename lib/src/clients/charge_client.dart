import '../base_client.dart';
import '../enums.dart';

class ChargeClient extends BaseClient {
  ChargeClient({super.secretKey});

  Future<Response> create(
    String email,
    int amount, {
    Map<String, dynamic>? bank,
    Map<String, dynamic>? bankTransfer,
    String? authorizationCode,
    String? pin,
    Map<String, dynamic>? metadata,
    String? reference,
    Map<String, dynamic>? ussd,
    Map<String, dynamic>? mobileMoney,
    String? deviceId,
  }) async {
    var standAloneParameters = {
      'bank': bank,
      'authorizationCode': authorizationCode,
      'ussd': ussd,
      'mobileMoney': mobileMoney,
    };
    List<String> providedStandAloneParameters = [];

    for (var parameter in standAloneParameters.entries) {
      if (parameter.value != null) {
        providedStandAloneParameters.add(parameter.key);
      }
    }
    if (providedStandAloneParameters.length > 1) {
      throw ArgumentError("only one of these parameters "
          "$providedStandAloneParameters should be provided for single call");
    }

    var data = {
      'email': email,
      'amount': amount,
      'bank': bank,
      'bank_transfer': bankTransfer,
      'authorization_code': authorizationCode,
      'pin': pin,
      'metadata': metadata,
      'reference': reference,
      'ussd': ussd,
      'mobile_money': mobileMoney,
      'device_id': deviceId
    };
    return await call(Uri.https(baseUrl, '/charge'), HttpMethod.post,
        data: data);
  }

  Future<Response> submitPin(String pin, String reference) async {
    return await call(Uri.https(baseUrl, '/charge/submit_pin'), HttpMethod.post,
        data: {'pin': pin, 'reference': reference});
  }

  Future<Response> submitOtp(String otp, String reference) async {
    return await call(Uri.https(baseUrl, '/charge/submit_otp'), HttpMethod.post,
        data: {'otp': otp, 'reference': reference});
  }

  Future<Response> submitPhone(String phone, String reference) async {
    return await call(
        Uri.https(baseUrl, '/charge/submit_phone'), HttpMethod.post,
        data: {'phone': phone, 'reference': reference});
  }

  Future<Response> submitBirthday(String birthday, String reference) async {
    return await call(
        Uri.https(baseUrl, '/charge/submit_birthday'), HttpMethod.post,
        data: {'birthday': birthday, 'reference': reference});
  }

  Future<Response> submitAddress(String address, String reference, String city,
      String state, String zipcode) async {
    var data = {
      'address': address,
      'reference': reference,
      'city': city,
      'state': state,
      'zipcode': zipcode,
    };
    return await call(
        Uri.https(baseUrl, '/charge/submit_address'), HttpMethod.post,
        data: data);
  }

  Future<Response> pendingCharge(String reference) async {
    return await call(Uri.https(baseUrl, '/charge/$reference'), HttpMethod.get);
  }
}
