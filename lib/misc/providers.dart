import 'dart:math';

import 'package:fiber_express/api/file_service.dart';
import 'package:fiber_express/components/plan.dart';
import 'package:fiber_express/components/subscription_and_device.dart';
import 'package:fiber_express/components/transaction.dart';
import 'package:fiber_express/components/usage.dart';
import 'package:fiber_express/components/user.dart';
import 'package:fiber_express/components/wallet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

User dummyUser = const User(
  id: "Dummy ID",
);

final StateProvider<User> userProvider = StateProvider((ref) => dummyUser);
final StateProvider<SubscriptionPlan> subscriptionPlanProvider = StateProvider(
  (ref) => SubscriptionPlan(
    expiration: DateTime.now(),
  ),
);

final StateProvider<DeviceStatus> deviceStatusProvider = StateProvider(
  (ref) => DeviceStatus(
    lastOnline: DateTime.now(),
  ),
);

final StateProvider<Plan> currentPlanProvider =
    StateProvider((ref) => const Plan());

final StateProvider<Usage> currentDataUsageProvider =
    StateProvider((ref) => const Usage());

final StateProvider<Wallet> currentWalletProvider =
    StateProvider((ref) => const Wallet());

final StateProvider<List<Usage>> dataUsageProvider = StateProvider((ref) => []);

final StateProvider<List<WalletTransaction>> walletTransactionsProvider =
    StateProvider((ref) => []);

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

final StateProvider<bool> refreshHomeDashboardProvider =
    StateProvider((ref) => false);

void logout(WidgetRef ref) {
  ref.invalidate(currentDataUsageProvider);
  ref.invalidate(currentPlanProvider);
  ref.invalidate(currentWalletProvider);
  ref.invalidate(refreshHomeDashboardProvider);
  ref.invalidate(deviceStatusProvider);
  ref.invalidate(subscriptionPlanProvider);
  ref.invalidate(dataUsageProvider);
  ref.invalidate(subscriptionTransactionsProvider);
  ref.invalidate(paymentTransactionsProvider);
  ref.invalidate(walletTransactionsProvider);
  ref.invalidate(currentPlanProvider);
  ref.invalidate(userProvider);
  FileManager.saveAuthDetails(null);
}
