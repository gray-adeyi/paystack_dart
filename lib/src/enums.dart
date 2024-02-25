/// An enum of intervals supported by Paystack
enum Interval {
  hourly,
  daily,
  weekly,
  monthly,
  quarterly,
  biannually,
  annually
}

/// An enum of settlement schedules supported by Paystack
enum SettlementSchedule { auto, weekly, monthly, manual }

/// An enum of financial channels supported by Paystack
enum FinancialChannel {
  nuban,
  ghipss,
  mobileMoney,
  basa;

  /// Convert the [FinancialChannel] to a value recognized by Paystack
  String get paystackValue {
    switch (this) {
      case FinancialChannel.nuban:
        return 'nuban';
      case FinancialChannel.ghipss:
        return 'ghipss';
      case FinancialChannel.mobileMoney:
        return 'mobile_money';
      case FinancialChannel.basa:
        return 'base';
    }
  }
}

/// An enum of risk actions supported by Paystack
enum RiskAction {
  default_,
  allow,
  deny;

  /// Convert the [RiskAction] to a value recognized by Paystack
  String get paystackValue {
    switch (this) {
      case RiskAction.default_:
        return 'default';
      default:
        return name;
    }
  }
}

/// An enum of countries currently supported by Paystack
enum Country {
  nigeria,
  ghana,
  southAfrica,
  kenya,
  coteDIvoire,
  egypt;

  /// Get the country ISO code
  String get code {
    switch (this) {
      case Country.nigeria:
        return "NG";
      case Country.ghana:
        return 'GH';
      case Country.southAfrica:
        return 'ZA';
      case Country.kenya:
        return 'KE';
      case Country.coteDIvoire:
        return 'CI';
      case Country.egypt:
        return 'EG';
    }
  }

  String get fullName {
    switch (this) {
      case Country.nigeria:
        return "nigeria";
      case Country.ghana:
        return 'ghana';
      case Country.southAfrica:
        return 'south africa';
      case Country.kenya:
        return 'kenya';
      case Country.coteDIvoire:
        return "côte d'ivoire";
      case Country.egypt:
        return 'egypt';
    }
  }
}

/// An enum of split modes supported by Paystack
enum SplitMode { percentage, flat }

/// An enum of terminal events supported by Paystack
enum TerminalEvent { invoice, transaction }

/// An enum of terminal actions supported by Paystack
enum TerminalAction { process, view, print }

/// An enum of currencies supported by paystack
enum Currency {
  ngn,
  ghs,
  zar,
  usd,
  kes,
  xof,
  egp;

  /// Serialize [Currency] to a value understandable by Paystack's API
  String get paystackValue => name.toUpperCase();
}

/// An enum of payment channels supported by Paystack
enum PaymentChannel { card, bank, ussd, qr, mobileMoney, bankTransfer, eft }

/// An enum of charge bearers supported by Paystack
enum ChargeBearer { account, subaccount }

// TODO: see if the bearers can be merged together.
/// An enum of subaccount charge bearers supported by Paystack
enum SubaccountChargeBearer { account, allProportional, all }

/// An enum of bulk charge status supported by Paystack
enum BulkChargeStatus { pending, success, failed }

/// An enum of transaction status supported by Paystack
enum TransactionStatus { failed, success, abandoned }

/// An enum of settlement status supported by Paystack
enum SettlementStatus { success, processing, pending, failed }

/// An enum of settlement status supported by Paystack
enum DisputeStatus {
  awaitingMerchantFeedback,
  awaitingBankFeedback,
  pending,
  resolved;

  /// Serialize the [DisputeStatus] to a value processable by Paystack
  String get paystackValue {
    switch (this) {
      case DisputeStatus.awaitingMerchantFeedback:
        return 'awaiting-merchant-feedback';
      case DisputeStatus.awaitingBankFeedback:
        return 'awaiting-bank-feedback';
      case DisputeStatus.pending:
        return 'pending';
      case DisputeStatus.resolved:
        return 'resolved';
    }
  }
}

/// An enum of dispute resolutions supported by paystack
enum DisputeResolution {
  merchantAccepted,
  declined;

  /// Serialize the [DisputeResolution] to a value processable by Paystack
  String get paystackValue {
    switch (this) {
      case DisputeResolution.merchantAccepted:
        return 'merchant-accepted';
      case DisputeResolution.declined:
        return 'declined';
    }
  }
}

/// An enum of account types supported by Paystack
enum AccountType { personal, business }

/// An enum of document types supported by Paystack
enum DocumentType { identityNumber, passportNumber, businessRegistrationNumber }

/// An enum of gateways supported by Paystack
enum Gateway { emandate, digitalbankmandate }

/// An enum of http methods
enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
  head,
}

/// An enum of https statuses
enum HttpStatus {
  // 100-199 codes
  continue_,
  switchingProtocols,
  processing,
  earlyHints,
  // 200-299 codes
  ok,
  created,
  accepted,
  nonAuthoritativeInformation,
  noContent,
  resetContent,
  partialContent,
  multiStatus,
  alreadyReported,
  imUsed,
  // 300-399 codes
  multipleChoices,
  movedPermanently,
  found,
  seeOther,
  notModified,
  useProxy,
  unused,
  temporaryRedirect,
  permanentRedirect,
  // 400-499 codes
  badRequest,
  unauthorized,
  paymentRequired,
  forbidden,
  notFound,
  methodNotAllowed,
  notAcceptable,
  proxyAuthenticationRequired,
  requestTimeout,
  conflict,
  gone,
  lengthRequired,
  preconditionFailed,
  payloadTooLarge,
  uriTooLong,
  unsupportedMediaType,
  rangeNotSatisfiable,
  expectationFailed,
  iAmATeapot,
  misdirectedRequest,
  unprocessableContent,
  locked,
  failedDependency,
  tooEarly,
  upgradeRequired,
  preconditionRequired,
  tooManyRequests,
  requestHeaderFieldsTooLarge,
  unavailableForLegalReasons,
  // 500-599 codes
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
  gatewayTimeout,
  httpVersionNotSupported,
  variantAlsoNegotiates,
  insufficientStorage,
  loopDetected,
  notExtended,
  networkAuthenticationRequired;

  bool get isSuccess => (199 < code) && (code <= 299);

  bool get isClientError => (399 < code) && (code <= 499);

  bool get isServerError => (499 < code) && (code <= 599);

  /// Retrieve the http status code.
  int get code {
    switch (this) {
      case HttpStatus.continue_:
        return 100;
      case HttpStatus.switchingProtocols:
        return 101;
      case HttpStatus.processing:
        return 102;
      case HttpStatus.earlyHints:
        return 103;
      // 200-299 codes
      case HttpStatus.ok:
        return 200;
      case HttpStatus.created:
        return 201;
      case HttpStatus.accepted:
        return 202;
      case HttpStatus.nonAuthoritativeInformation:
        return 203;
      case HttpStatus.noContent:
        return 204;
      case HttpStatus.resetContent:
        return 205;
      case HttpStatus.partialContent:
        return 206;
      case HttpStatus.multiStatus:
        return 207;
      case HttpStatus.alreadyReported:
        return 208;
      case HttpStatus.imUsed:
        return 226;
      // 300-399 codes
      case HttpStatus.multipleChoices:
        return 300;
      case HttpStatus.movedPermanently:
        return 301;
      case HttpStatus.found:
        return 302;
      case HttpStatus.seeOther:
        return 303;
      case HttpStatus.notModified:
        return 304;
      case HttpStatus.useProxy:
        return 305;
      case HttpStatus.unused:
        return 306;
      case HttpStatus.temporaryRedirect:
        return 307;
      case HttpStatus.permanentRedirect:
        return 308;
      // 400-499 codes
      case HttpStatus.badRequest:
        return 400;
      case HttpStatus.unauthorized:
        return 401;
      case HttpStatus.paymentRequired:
        return 402;
      case HttpStatus.forbidden:
        return 403;
      case HttpStatus.notFound:
        return 404;
      case HttpStatus.methodNotAllowed:
        return 405;
      case HttpStatus.notAcceptable:
        return 406;
      case HttpStatus.proxyAuthenticationRequired:
        return 407;
      case HttpStatus.requestTimeout:
        return 408;
      case HttpStatus.conflict:
        return 409;
      case HttpStatus.gone:
        return 410;
      case HttpStatus.lengthRequired:
        return 411;
      case HttpStatus.preconditionFailed:
        return 412;
      case HttpStatus.payloadTooLarge:
        return 413;
      case HttpStatus.uriTooLong:
        return 414;
      case HttpStatus.unsupportedMediaType:
        return 415;
      case HttpStatus.rangeNotSatisfiable:
        return 416;
      case HttpStatus.expectationFailed:
        return 417;
      case HttpStatus.iAmATeapot:
        return 418;
      case HttpStatus.misdirectedRequest:
        return 421;
      case HttpStatus.unprocessableContent:
        return 422;
      case HttpStatus.locked:
        return 423;
      case HttpStatus.failedDependency:
        return 424;
      case HttpStatus.tooEarly:
        return 425;
      case HttpStatus.upgradeRequired:
        return 426;
      case HttpStatus.preconditionRequired:
        return 428;
      case HttpStatus.tooManyRequests:
        return 429;
      case HttpStatus.requestHeaderFieldsTooLarge:
        return 431;
      case HttpStatus.unavailableForLegalReasons:
        return 451;
      // 500-599 codes
      case HttpStatus.internalServerError:
        return 500;
      case HttpStatus.notImplemented:
        return 501;
      case HttpStatus.badGateway:
        return 502;
      case HttpStatus.serviceUnavailable:
        return 503;
      case HttpStatus.gatewayTimeout:
        return 504;
      case HttpStatus.httpVersionNotSupported:
        return 505;
      case HttpStatus.variantAlsoNegotiates:
        return 506;
      case HttpStatus.insufficientStorage:
        return 507;
      case HttpStatus.loopDetected:
        return 508;
      case HttpStatus.notExtended:
        return 510;
      case HttpStatus.networkAuthenticationRequired:
        return 511;
    }
  }
}
