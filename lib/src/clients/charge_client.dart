import '../base_client.dart';
import '../enums.dart';

/// It provides methods that mirrors endpoints provided by
/// Paystack's Charge API which allows you to configure payment channel
/// of your choice when initiating a payment.
class ChargeClient extends BaseClient {
  /// Create an instance of [ChargeClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [ChargeClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [ChargeClient].
  /// There is no need to instantiate this class directly unless you only
  /// need to use features specific to this client as it is available in
  /// the all encompassing [PaystackClient] via `charges` binding
  /// ## Example
  /// ```dart
  /// var client = ChargeClient(secretKey: "<your paystack secret key>");
  /// var response = await client.submitOtp("234567");
  /// // The Following code is an equivalent of the code above.
  /// var client = PaystackClient(secretKey: "<your paystack secret key>");
  /// var response = await client.charges.submitOtp("234567");
  /// ```
  ChargeClient({super.secretKey});

  /// Initiate a payment by integrating the payment channel of your choice.
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

  /// Submit pin to continue charge.
  Future<Response> submitPin(String pin, String reference) async {
    return await call(Uri.https(baseUrl, '/charge/submit_pin'), HttpMethod.post,
        data: {'pin': pin, 'reference': reference});
  }

  /// Submit otp to complete charge.
  Future<Response> submitOtp(String otp, String reference) async {
    return await call(Uri.https(baseUrl, '/charge/submit_otp'), HttpMethod.post,
        data: {'otp': otp, 'reference': reference});
  }

  /// Submit phone number when requested.
  Future<Response> submitPhone(String phone, String reference) async {
    return await call(
        Uri.https(baseUrl, '/charge/submit_phone'), HttpMethod.post,
        data: {'phone': phone, 'reference': reference});
  }

  /// Submit birthday when requested.
  Future<Response> submitBirthday(String birthday, String reference) async {
    return await call(
        Uri.https(baseUrl, '/charge/submit_birthday'), HttpMethod.post,
        data: {'birthday': birthday, 'reference': reference});
  }

  /// Submit address to continue charge.
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

  /// Check the status of a pending charge.
  ///
  /// When you get pending as a charge status or if there was
  /// an exception when calling any of the following methods [create],
  /// [submitPin],[submitOtp],[submitPhone],[submitBirthday],[submitAddress],
  /// wait 10 seconds or more, then make a check to see if
  /// its status has changed.
  /// Don't call too early as you may get a lot more pending than you should.
  Future<Response> pendingCharge(String reference) async {
    return await call(Uri.https(baseUrl, '/charge/$reference'), HttpMethod.get);
  }
}
