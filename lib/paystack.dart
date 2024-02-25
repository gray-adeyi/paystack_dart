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
export 'src/clients/apple_pay_client.dart';
export 'src/clients/bulk_charge_client.dart';
export 'src/clients/charge_client.dart';
export 'src/clients/customer_client.dart';
export 'src/clients/dedicated_virtual_account_client.dart';
export 'src/clients/dispute_client.dart';
export 'src/clients/integration_client.dart';
export 'src/clients/miscellaneous_client.dart';
export 'src/clients/payment_page_client.dart';
export 'src/clients/payment_request_client.dart';
export 'src/clients/plan_client.dart';
export 'src/clients/product_client.dart';
export 'src/clients/refund_client.dart';
export 'src/clients/settlement_client.dart';
export 'src/clients/subaccount_client.dart';
export 'src/clients/subscription_client.dart';
export 'src/clients/terminal_client.dart';
export 'src/clients/transaction_client.dart';
export 'src/clients/transaction_split_client.dart';
export 'src/clients/transfer_client.dart';
export 'src/clients/transfer_control_client.dart';
export 'src/clients/transfer_recipient_client.dart';
export 'src/clients/verification_client.dart';
export 'src/enums.dart';
export 'src/exceptions.dart';
export 'src/models.dart';

/// It provides class members which are bindings to other clients
/// which mirrors the same API grouping's on paystack's API reference. see
/// https://paystack.com/docs/api/ . These clients provide method's over
/// all the API endpoints provided by paystack and all have the same return
/// type a Future<Response>
class PaystackClient extends BaseClient {
  /// Access an instance of the [ApplePayClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Apple Pay API. See https://paystack.com/docs/api/apple-pay/
  late final ApplePayClient applePay;

  /// Access an instance of the [BulkChargeClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Bulk Charges API.
  /// See https://paystack.com/docs/api/bulk-charge/
  late final BulkChargeClient bulkCharges;

  /// Access an instance of the [ChargeClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Charge API. See https://paystack.com/docs/api/charge/
  late final ChargeClient charges;

  /// Access an instance of the [CustomerClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Customers API. See https://paystack.com/docs/api/customer/
  late final CustomerClient customers;

  /// Access an instance of the [DedicatedVirtualAccountClient] via this
  /// class member to access wrapper methods for API endpoints grouped under
  /// Paystack's Dedicated Virtual Account API.
  /// See https://paystack.com/docs/api/dedicated-virtual-account/
  late final DedicatedVirtualAccountClient dedicatedVirtualAccounts;

  /// Access an instance of the [DisputeClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Disputes API. See https://paystack.com/docs/api/dispute/
  late final DisputeClient disputes;

  /// Access an instance of the [IntegrationClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Integration API. See https://paystack.com/docs/api/integration/
  late final IntegrationClient integration;

  /// Access an instance of the [MiscellaneousClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Miscellaneous API.
  /// See https://paystack.com/docs/api/miscellaneous/
  late final MiscellaneousClient miscellaneous;

  /// Access an instance of the [PaymentPageClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Payment Pages API. See https://paystack.com/docs/api/page/
  late final PaymentPageClient paymentPages;

  /// Access an instance of the [PaymentRequestClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Payment Requests API. See https://paystack.com/docs/api/page/
  late final PaymentRequestClient paymentRequests;

  /// Access an instance of the [PlanClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Plans API. See https://paystack.com/docs/api/plan/
  late final PlanClient plans;

  /// Access an instance the [ProductClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Products API. See https://paystack.com/docs/api/product/
  late final ProductClient products;

  /// Access an instance of the [RefundClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Refund API. See https://paystack.com/docs/api/refund/
  late final RefundClient refunds;

  /// Access an instance of the [SettlementClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Settlements API. See https://paystack.com/docs/api/settlement/
  late final SettlementClient settlements;

  /// Access an instance of the [SubaccountClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Subaccounts API. See https://paystack.com/docs/api/subaccount/
  late final SubaccountClient subaccounts;

  /// Access an instance of the [SubscriptionClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Subscriptions API.
  /// See https://paystack.com/docs/api/subscription/
  late final SubscriptionClient subscriptions;

  /// Access an instance of the [TerminalClient] via the class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Terminal API. See https://paystack.com/docs/api/terminal/
  late final TerminalClient terminals;

  /// Access an instance of the [TransactionClient] via the class member to
  /// access wrapper methods for API endpoints  grouped under
  /// Paystack's Transactions API.
  /// See https://paystack.com/docs/api/transaction/
  late final TransactionClient transactions;

  /// Access an instance of the [TransactionSplitClient] via this class member
  /// to access wrapper methods for API endpoints grouped under
  /// Paystack's Transaction Splits API.
  /// See https://paystack.com/docs/api/split/
  late final TransactionSplitClient transactionSplits;

  /// Access an instance of the [TransferClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Transfers API. See https://paystack.com/docs/api/transfer/
  late final TransferClient transfers;

  /// Access an instance of the [TransferControlClient] via this class member to
  /// access wrapper methods for API endpoints grouped under
  /// Paystack's Transfers Control API.
  /// See https://paystack.com/docs/api/transfer-control/
  late final TransferControlClient transferControl;

  /// Access an instance of the [TransferRecipientClient] via this class member
  /// to access wrapper methods for API endpoints grouped under
  /// Paystack's Transfer Recipients API.
  /// See https://paystack.com/docs/api/transfer-recipient/
  late final TransferRecipientClient transferRecipient;

  /// Access an instance of the [VerificationClient] via this class member
  /// to access wrapper methods for API endpoints grouped under
  /// Paystack's Verification API.
  /// See https://paystack.com/docs/api/verification/
  late final VerificationClient verification;

  /// Create an instance of [PaystackClient].
  ///
  /// [secretKey] is your Paystack integration key. If omitted,
  /// [PaystackClient] tries to load it from your environmental
  /// variables with a key stored in its [secretKeyEnvironmentalVariableName]
  /// which has a default of "PAYSTACK_SECRET_KEY". i.e. If you provide
  /// your Paystack integration secret key in your environmental variables
  /// as `PAYSTACK_SECRET_KEY=<your secret key>`, you don't need to provide
  /// a [secretKey] on instantiation of [PaystackClient]
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
