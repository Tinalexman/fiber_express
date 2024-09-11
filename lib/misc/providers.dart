import 'dart:math';

import 'package:fiber_express/components/plan.dart';
import 'package:fiber_express/components/transaction.dart';
import 'package:fiber_express/components/usage.dart';
import 'package:fiber_express/components/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const User dummyUser = User(
  firstName: "John",
  lastName: "Doe",
  id: "Dummy ID",
  email: "johndoe@mail.com",
  address: "12 Marina Street, Necom House",
  phone: "2349012345678",
  state: "Lagos",
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

final StateProvider<List<Usage>> dataUsageProvider = StateProvider(
  (ref) => List.generate(
    10,
    (index) => Usage(
      id: "Usage ID $index",
      month: "Septemer",
      year: "2024",
      total: "240GB",
    ),
  ),
);

final StateProvider<List<WalletTransaction>> walletTransactionsProvider =
    StateProvider(
  (ref) => List.generate(
    15,
    (index) {
      DateTime now = DateTime.now();
      Random random = Random(now.millisecondsSinceEpoch);

      double amount = min(-100000, random.nextInt(100000)).toDouble();
      double before = min(1000, random.nextInt(50000)).toDouble();
      double after = before + amount;

      return WalletTransaction(
        createdAt: now,
        id: "Wallet Transaction $index",
        amount: amount,
        balanceBefore: before,
        balanceAfter: after,
        narration: "Royal Plan subscription purpose",
        purpose: amount < 0 ? "Payment" : "Deposit",
        reference: "subs-d43af94c1a774772992jkjddwnw0inw082ekj00hnkj",
      );
    },
  ),
);

final StateProvider<List<SubscriptionTransaction>>
    subscriptionTransactionsProvider = StateProvider(
  (ref) => List.generate(
    15,
    (index) {
      DateTime now = DateTime.now();
      Random random = Random(now.millisecondsSinceEpoch);
      double amount = min(-100000, random.nextInt(100000)).toDouble();

      return SubscriptionTransaction(
        createdAt: now,
        id: "Subscription Transaction $index",
        amount: amount,
        formerExpiry: now,
        newExpiry: now,
        status: random.nextBool() ? "Active" : "Expired",
        method: "Wallet",
        plan: "Royal Plan",
        reference: "subs-d43af94c1a774772992jkjddwnw0inw082ekj00hnkj",
      );
    },
  ),
);

final StateProvider<List<PaymentTransaction>> paymentTransactionsProvider =
    StateProvider(
  (ref) => List.generate(
    15,
    (index) {
      DateTime now = DateTime.now();
      Random random = Random(now.millisecondsSinceEpoch);

      double amount = min(-100000, random.nextInt(100000)).toDouble();

      return PaymentTransaction(
          createdAt: now,
          id: "Payment Transaction $index",
          amount: amount,
          payment: "paystack-0301dc1a5726438cjddwnw0inw082ekj",
          reference: "subs-d43af94c1a774772992jkjddwnw0inw082ekj00hnkj",
          method: "Paystack",
          status: random.nextBool() ? "Completed" : "Awaiting Callback");
    },
  ),
);

void logout(WidgetRef ref) {
  ref.invalidate(dataUsageProvider);
  ref.invalidate(subscriptionTransactionsProvider);
  ref.invalidate(paymentTransactionsProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(currentPlanProvider);
  ref.invalidate(userProvider);
}
