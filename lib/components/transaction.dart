import 'package:equatable/equatable.dart';

class WalletTransaction extends Equatable {
  final String id;
  final double amount;
  final double balanceAfter;
  final double balanceBefore;
  final DateTime createdAt;
  final String narration;
  final String purpose;
  final String reference;

  const WalletTransaction({
    required this.createdAt,
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
  final DateTime formerExpiry;
  final DateTime newExpiry;
  final DateTime createdAt;
  final String reference;
  final String plan;

  const SubscriptionTransaction({
    required this.formerExpiry,
    required this.newExpiry,
    required this.createdAt,
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
  final DateTime createdAt;
  final String reference;
  final String payment;

  const PaymentTransaction({
    required this.createdAt,
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
