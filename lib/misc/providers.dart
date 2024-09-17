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
    subscriptionTransactionsProvider = StateProvider((ref) => []);

final StateProvider<List<PaymentTransaction>> paymentTransactionsProvider =
    StateProvider((ref) => []);

final StateProvider<bool> refreshHomeDashboardProvider =
    StateProvider((ref) => false);
final StateProvider<bool> refreshReportsProvider =
    StateProvider((ref) => false);
final StateProvider<String> reportsSearchProvider = StateProvider((ref) => "");

void logout(WidgetRef ref) {
  ref.invalidate(refreshReportsProvider);
  ref.invalidate(reportsSearchProvider);
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
