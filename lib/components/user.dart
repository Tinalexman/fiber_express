import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? image;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String state;

  const User({
    this.id = "",
    this.image,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.phone = "",
    this.address = "",
    this.state = "",
  });

  @override
  List<Object?> get props => [id];
}
