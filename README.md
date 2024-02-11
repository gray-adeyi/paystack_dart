<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Paystack

A backend client library for [Paystack](https://paystack.com/) in dart inspired
by [Pypaystack2](https://pypi.org/project/pypaystack2/)
from python's
ecosystem.

## Features

This library implements a wrapper on all endpoints provided by `Paystack`. The `PaystackClient`
class has bindings on it that can be used to access the different wrapper methods. The wrapper
methods are grouped to match [Paystack's API Reference](https://paystack.com/docs/api/). e.g.
`PaystackClient.transactions` binding provides wrapper methods for all the endpoint for
Paystack's Transactions API. i.e. `PaystackClient.transactions.initialize` is a wrapper method
for [Paystack's initialize transaction endpoint](https://paystack.com/docs/api/transaction/#initialize).

### Bindings on the `PaystackClient` class

| Bindings                                  |
|-------------------------------------------|
| `PaystackClient.applePay`                 |
| `PaystackClient.bulkCharges`              |
| `PaystackClient.charges`                  |
| `PaystackClient.customers`                |
| `PaystackClient.dedicatedVirtualAccounts` |
| `PaystackClient.disputes`                 |
| `PaystackClient.integration`              |
| `PaystackClient.miscellaneous`            |
| `PaystackClient.paymentPages`             |
| `PaystackClient.paymentRequests`          |
| `PaystackClient.plans`                    |
| `PaystackClient.products`                 |
| `PaystackClient.refunds`                  |
| `PaystackClient.settlements`              |
| `PaystackClient.subaccounts`              |
| `PaystackClient.subscriptions`            |
| `PaystackClient.terminals`                |
| `PaystackClient.transactions`             |
| `PaystackClient.transactionSplits`        |
| `PaystackClient.transfers`                |
| `PaystackClient.transferControl`          |
| `PaystackClient.transferRecipient`        |
| `PaystackClient.verification`             |

## Getting started

Add the library to your client package.

```bash
dart pub add paystack
```

## Usage

See `/example` folder for more examples.

```dart
import 'package:paystack/paystack.dart';

void main() async {
  const client = PaystackClient(secretKey: "<your paystack secret key>");
  const response = await
  client.applePay.all(false);
  print(response.statusCode);
  print(response.data
  );
}
```

## Additional information

Subsequent releases will provide more test coverage and documentation. This project is still
actively
in development. If you have any questions, found a bug or have feature suggestions, please create
an issue in the project's repository. Enjoy you coding! 😎
