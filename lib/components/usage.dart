import 'package:equatable/equatable.dart';

class Usage extends Equatable {
  final String id;
  final String month;
  final String year;
  final String total;

  const Usage({
    this.id = "",
    this.month = "",
    this.year = "",
    this.total = "",
  });

  @override
  List<Object?> get props => [id];
}
