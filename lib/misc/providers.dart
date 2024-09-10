import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fiber_express/components/user.dart';


const User dummyUser = User(
  firstName: "John",
  lastName: "Doe",
  id: "Dummy ID",
  email: "johndoe@mail.com",
  address: "Somewhere in the world",
  phone: "2349012345678",
  state: "None"
);

final StateProvider<User> userProvider = StateProvider((ref) => dummyUser);



void logout(WidgetRef ref) {
  ref.invalidate(userProvider);
}