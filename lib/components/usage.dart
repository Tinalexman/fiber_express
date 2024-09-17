import 'package:equatable/equatable.dart';

class Usage extends Equatable {
  final String id;
  final String month;
  final String year;
  final String total;
  final String uploaded;
  final String downloaded;

  const Usage({
    this.id = "",
    this.month = "",
    this.year = "",
    this.total = "",
    this.uploaded = "",
    this.downloaded = "",
  });

  @override
  List<Object?> get props => [id];
}
