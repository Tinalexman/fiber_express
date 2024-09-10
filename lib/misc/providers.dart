import 'package:fiber_express/components/plan.dart';
import 'package:fiber_express/components/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const User dummyUser = User(
  firstName: "John",
  lastName: "Doe",
  id: "Dummy ID",
  email: "johndoe@mail.com",
  address: "Somewhere in the world",
  phone: "2349012345678",
  state: "None",
  image: "",
);

final StateProvider<User> userProvider = StateProvider((ref) => dummyUser);
final StateProvider<Plan> currentPlanProvider = StateProvider(
  (ref) => const Plan(
    name: "Royal Plan",
    mbLimit: 100,
    amount: 59500,
  ),
);

void logout(WidgetRef ref) {
  ref.invalidate(currentPlanProvider);
  ref.invalidate(userProvider);
}
