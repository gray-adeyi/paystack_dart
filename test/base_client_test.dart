import 'package:paystack/src/base_client.dart';
import 'package:paystack/src/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('BaseClient tests', () {
    final client = BaseClient(secretKey: 'secret_key');
    setUp(() {});

    test(
        ('Base client raises MissingSecretKeyException when secret'
            ' key is not provided on instantiation or in env'), () {
      expect(() => BaseClient(), throwsA(isA<MissingSecretKeyException>()));
    });

    test('baseUrl is valid',
        () => {expect(client.baseUrl, equals('api.paystack.co'))});

    test('headers is valid', () => {});

    test('secretKey is provided in headers for authentication', () => {});

    test(
        'BaseClient can load secretKey from environmental variables', () => {});

    // TODO: Mock the http calls
    test('BaseClient.call returns a valid response', () => {});
  });

  test('packageVersion matches value in the pubspec.yml file', () => {});
}
