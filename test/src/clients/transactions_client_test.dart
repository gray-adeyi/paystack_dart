import 'package:paystack/src/clients/transaction_client.dart';
import 'package:paystack/src/enums.dart';
import 'package:test/test.dart';

typedef NativeJsonData = Map<String, dynamic>;

void main() {
  final client = TransactionClient();
  group("TransactionClient tests", () {
    test('client can initialize a transaction', () async {
      var response = await client.initialize(1000, 'adeyigbenga027@gmail.com');
      expect(response.statusCode, equals(HttpStatus.ok.code),
          reason: "${response.data}");
      expect(response.data['status'], isTrue);
    });

    test('client can verify a transaction', () async {
      var response = await client.verify('olkym9on2x');
      expect(response.statusCode, equals(HttpStatus.ok.code),
          reason: "${response.data}");
      expect(response.data['status'], isTrue);
      expect(response.data['message'], equals('Verification successful'));
    });

    test('client can fetch all transactions', () async {
      var response = await client.all();
      expect(response.statusCode, equals(HttpStatus.ok.code),
          reason: "${response.data}");
      expect(response.data['status'], isTrue);
      expect(response.data['message'], equals('Transactions retrieved'));
      expect(response.data, equals('Transactions retrieved'));
    });

    test('client can fetch one transaction', () async {
      var response = await client.fetchOne('3463636376');
      expect(response.statusCode, equals(HttpStatus.ok.code),
          reason: "${response.data}");
      expect(response.data['status'], isTrue);
      expect(response.data['message'], equals('Transaction retrieved'));
    });

    test('client can charge', () async {
      await client.charge(1000, 'adeyigbenga005@gmail.com', 'AUTH_w1renosr9o');
    });
  });
}
