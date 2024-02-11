import 'package:paystack/paystack.dart';

void main() async {
  // The secretKey optional name parameter can be omitted if provided in the
  // environmental variables. as 'PAYSTACK_SECRET_KEY'
  var client = PaystackClient(secretKey: "<your paystack secret key>");
  // Retrieve all the customers on your integrations.
  var response = await client.customers.all();
  print("the statusCode of the last call is ${response.statusCode}");
  print(response.data);

  // Initialize a transaction on you integration.
  response = await client.transactions.initialize(10000, "johndoe@example.com");
  print(response.data);
}
