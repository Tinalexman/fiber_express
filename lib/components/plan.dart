import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final String id;
  final double amount;
  final String name;
  final int downloadRate;
  final int uploadRate;
  final bool enabled;

  const Plan({
    this.id = "",
    this.enabled = false,
    this.amount = 0.0,
    this.downloadRate = 0,
    this.uploadRate = 0,
    this.name = "",
  });

  bool get isEmpty => id.isEmpty;

  @override
  List<Object?> get props => [id];
}
