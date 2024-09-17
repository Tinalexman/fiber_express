import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String userGroup;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String state;
  final DateTime createdAt;

  const User({
    this.id = "",
    this.userGroup = "",
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.phone = "",
    this.address = "",
    this.state = "",
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}
