import 'package:equatable/equatable.dart';

class WalletTransaction extends Equatable {
  final String id;
  final double amount;
  final double balanceAfter;
  final double balanceBefore;
  final String createdAt;
  final String narration;
  final String purpose;
  final String reference;

  const WalletTransaction({
    this.createdAt = "",
    this.id = "",
    this.amount = 0.0,
    this.balanceAfter = 0.0,
    this.balanceBefore = 0.0,
    this.narration = "",
    this.purpose = "",
    this.reference = "",
  });

  @override
  List<Object?> get props => [id];
}

class SubscriptionTransaction extends Equatable {
  final String id;
  final double amount;
  final String method;
  final String status;
  final String formerExpiry;
  final String newExpiry;
  final String createdAt;
  final String reference;
  final String plan;

  const SubscriptionTransaction({
    this.formerExpiry = "",
    this.newExpiry = "",
    this.createdAt = "",
    this.id = "",
    this.amount = 0.0,
    this.method = "",
    this.status = "",
    this.plan = "",
    this.reference = "",
  });

  @override
  List<Object?> get props => [id];
}

class PaymentTransaction extends Equatable {
  final String id;
  final double amount;
  final String method;
  final String status;
  final String createdAt;
  final String reference;
  final String payment;

  const PaymentTransaction({
    this.createdAt = "",
    this.id = "",
    this.amount = 0.0,
    this.method = "",
    this.status = "",
    this.payment = "",
    this.reference = "",
  });

  @override
  List<Object?> get props => [id];
}
