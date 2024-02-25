import './enums.dart';

/// A model class to for terminal data
class TerminalData {
  final String id;
  final String reference;

  TerminalData(this.id, this.reference);

  Map<String, String> toMap() {
    return {
      "id": id,
      "reference": reference,
    };
  }
}

/// A model class for subaccounts
class Subaccount {
  final String id;
  final double share;

  Subaccount(this.id, this.share);

  Map<String, String> toMap() {
    return {
      "subaccount": id,
      "share": share.toString(),
    };
  }

// TODO: implement a factory that generates a List<Subaccount> from
// a list of Map<String, String>
}

/// A model class for list item
class LineItem {
  final String name;
  final int amount;
  final int quantity;

  LineItem(this.name, this.amount, this.quantity);

  Map<String, dynamic> toMap() {
    return {'name': name, "amount": amount, 'quantity': quantity};
  }
}

/// A model class for tax
class Tax {
  final String name;
  final int amount;

  Tax(this.name, this.amount);

  Map<String, dynamic> toMap() {
    return {'name': name, 'amount': amount};
  }
}

/// A model class for transfer recipient
class TransferRecipient {
  final FinancialChannel type;
  final String name;
  String? accountNumber;
  String? bankCode;
  String? description;
  Currency? currency;
  String? authorizationCode;
  Map<String, dynamic>? metadata;

  TransferRecipient(this.type, this.name,
      {this.accountNumber,
      this.bankCode,
      this.description,
      this.currency,
      this.authorizationCode,
      this.metadata}) {
    if (accountNumber == null && authorizationCode == null) {
      throw ArgumentError("accountNumber and authorizationCode can't both "
          "be missing, please provide only one of this two missing parameters");
    }
    if (accountNumber != null && authorizationCode != null) {
      throw ArgumentError(
          "you can't provide both the accountNumber and authorizationCode. "
          "please provide either of the two parameters");
    }
    if (accountNumber != null && bankCode == null) {
      throw ArgumentError(
          'bankCode is required when accountNumber is provided');
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.paystackValue,
      'name': name,
      'account_number': accountNumber,
      'bank_code': bankCode,
      'description': description,
      'currency': currency?.paystackValue,
      'authorization_code': authorizationCode,
      'metadata': metadata
    };
  }
}

/// A model class for transfer
class Transfer {
  final int amount;
  final String recipient;
  String? reference;
  String? reason;

  Transfer(this.amount, this.recipient, this.reference, this.reason);

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'recipient': recipient,
      'reference': reference,
      'reason': reason
    };
  }
}

/// A model class for charge
class Charge {
  final String authorization;
  final int amount;
  final String reference;

  Charge(this.authorization, this.amount, this.reference);

  Map<String, dynamic> toMap() {
    return {
      "authorization": authorization,
      "amount": amount,
      "reference": reference,
    };
  }
}
