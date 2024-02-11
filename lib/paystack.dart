/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'src/base_client.dart';
import 'src/clients/apple_pay_client.dart';
import 'src/clients/bulk_charge_client.dart';
import 'src/clients/charge_client.dart';
import 'src/clients/customer_client.dart';
import 'src/clients/dedicated_virtual_account_client.dart';
import 'src/clients/dispute_client.dart';
import 'src/clients/integration_client.dart';
import 'src/clients/miscellaneous_client.dart';
import 'src/clients/payment_page_client.dart';
import 'src/clients/payment_request_client.dart';
import 'src/clients/plan_client.dart';
import 'src/clients/product_client.dart';
import 'src/clients/refund_client.dart';
import 'src/clients/settlement_client.dart';
import 'src/clients/subaccount_client.dart';
import 'src/clients/subscription_client.dart';
import 'src/clients/terminal_client.dart';
import 'src/clients/transaction_client.dart';
import 'src/clients/transaction_split_client.dart';
import 'src/clients/transfer_client.dart';
import 'src/clients/transfer_control_client.dart';
import 'src/clients/transfer_recipient_client.dart';
import 'src/clients/verification_client.dart';

export 'src/base_client.dart';
export 'src/enums.dart';
export 'src/models.dart';

class PaystackClient extends BaseClient {
  late final ApplePayClient applePay;
  late final BulkChargeClient bulkCharges;
  late final ChargeClient charges;
  late final CustomerClient customers;
  late final DedicatedVirtualAccountClient dedicatedVirtualAccounts;
  late final DisputeClient disputes;
  late final IntegrationClient integration;
  late final MiscellaneousClient miscellaneous;
  late final PaymentPageClient paymentPages;
  late final PaymentRequestClient paymentRequests;
  late final PlanClient plans;
  late final ProductClient products;
  late final RefundClient refunds;
  late final SettlementClient settlements;
  late final SubaccountClient subaccounts;
  late final SubscriptionClient subscriptions;
  late final TerminalClient terminals;
  late final TransactionClient transactions;
  late final TransactionSplitClient transactionSplits;
  late final TransferClient transfers;
  late final TransferControlClient transferControl;
  late final TransferRecipientClient transferRecipient;
  late final VerificationClient verification;

  PaystackClient({String? secretKey}) : super(secretKey: secretKey) {
    applePay = ApplePayClient(secretKey: secretKey);
    bulkCharges = BulkChargeClient(secretKey: secretKey);
    charges = ChargeClient(secretKey: secretKey);
    customers = CustomerClient(secretKey: secretKey);
    dedicatedVirtualAccounts =
        DedicatedVirtualAccountClient(secretKey: secretKey);
    disputes = DisputeClient(secretKey: secretKey);
    integration = IntegrationClient(secretKey: secretKey);
    miscellaneous = MiscellaneousClient(secretKey: secretKey);
    paymentPages = PaymentPageClient(secretKey: secretKey);
    paymentRequests = PaymentRequestClient(secretKey: secretKey);
    plans = PlanClient(secretKey: secretKey);
    products = ProductClient(secretKey: secretKey);
    refunds = RefundClient(secretKey: secretKey);
    settlements = SettlementClient(secretKey: secretKey);
    subaccounts = SubaccountClient(secretKey: secretKey);
    subscriptions = SubscriptionClient(secretKey: secretKey);
    terminals = TerminalClient(secretKey: secretKey);
    transactions = TransactionClient(secretKey: secretKey);
    transactionSplits = TransactionSplitClient(secretKey: secretKey);
    transfers = TransferClient(secretKey: secretKey);
    transferControl = TransferControlClient(secretKey: secretKey);
    transferRecipient = TransferRecipientClient(secretKey: secretKey);
    verification = VerificationClient(secretKey: secretKey);
  }
}
