import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  final double amount;
  final String name;
  final int mbLimit;

  const Plan({
    this.amount = 0.0,
    this.mbLimit = 0,
    this.name = "",
  });

  bool get isEmpty => amount == 0.0 && mbLimit == 0 && name == "";

  @override
  List<Object?> get props => [name];
}
