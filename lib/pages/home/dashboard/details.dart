import 'package:fiber_express/api/dashboard.dart';
import 'package:fiber_express/components/plan.dart';
import 'package:fiber_express/components/subscription_and_device.dart';
import 'package:fiber_express/components/usage.dart';
import 'package:fiber_express/components/wallet.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class Details extends ConsumerStatefulWidget {
  const Details({super.key});

  @override
  ConsumerState<Details> createState() => _DetailsState();
}

class _DetailsState extends ConsumerState<Details> {
  bool loading = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, getData);
  }

  void displayToast(String message) => showToast(message, context);

  Future<void> planDetails() async {
    String planID = ref
        .watch(subscriptionPlanProvider.select((value) => value.currentPlan));
    FiberResponse<Plan?> response = await getServicePlan(planID);
    if (!response.success) {
      displayToast(response.message);
      return;
    }

    ref.watch(currentPlanProvider.notifier).state = response.data!;
  }

  Future<void> dataUsage() async {
    String username = ref.watch(userProvider.select((value) => value.username));
    FiberResponse<Usage?> response = await getCurrentMonthDataUsage(username);
    if (!response.success) {
      displayToast(response.message);
      return;
    }

    ref.watch(currentDataUsageProvider.notifier).state = response.data!;
  }

  Future<void> walletBalance() async {
    String username = ref.watch(userProvider.select((value) => value.username));
    FiberResponse<Wallet?> response = await getWalletBalance(username);
    if (!response.success) {
      displayToast(response.message);
      return;
    }

    ref.watch(currentWalletProvider.notifier).state = response.data!;
  }

  void getData() {
    planDetails();
    dataUsage();
    walletBalance();
  }

  void shouldRefresh() {
    ref.listen(refreshHomeDashboardProvider, (previous, next) {
      if ((!previous! && next) || (previous && !next)) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    shouldRefresh();
    bool darkTheme = context.isDark;

    SubscriptionPlan subscriptionPlan = ref.watch(subscriptionPlanProvider);
    Plan plan = ref.watch(currentPlanProvider);
    Usage usage = ref.watch(currentDataUsageProvider);
    Wallet wallet = ref.watch(currentWalletProvider);

    String status = subscriptionPlan.status;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 85.h,
          width: 375.w,
          decoration: BoxDecoration(
            color: darkTheme ? secondary : primary,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active Package",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: light,
                    ),
                  ),
                  Text(
                    plan.name,
                    style: context.textTheme.titleLarge!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Capped at ${plan.downloadRate}Mbps (VAT incl.)",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 10.w,
                top: 5.h,
                child: Icon(
                  IconsaxPlusLinear.gift,
                  size: 26.r,
                  color: light,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 85.h,
          width: 375.w,
          decoration: BoxDecoration(
            color: darkTheme ? secondary : primary,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Wallet Balance",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: light,
                    ),
                  ),
                  Text(
                    "${wallet.currency} ${formatAmount(wallet.balance.toStringAsFixed(0))}",
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 10.w,
                top: 5.h,
                child: Icon(
                  IconsaxPlusLinear.wallet,
                  size: 26.r,
                  color: light,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 85.h,
          width: 375.w,
          decoration: BoxDecoration(
            color: darkTheme ? secondary : primary,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data Usage for ${usage.month}, ${usage.year}",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: light,
                    ),
                  ),
                  Text(
                    usage.total,
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Upload: ${usage.uploaded}",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Download: ${usage.downloaded}",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 10.w,
                top: 5.h,
                child: Icon(
                  IconsaxPlusLinear.status,
                  size: 26.r,
                  color: light,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 85.h,
          width: 375.w,
          decoration: BoxDecoration(
            color: darkTheme ? secondary : primary,
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Expiry Date",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: light,
                    ),
                  ),
                  Text(
                    formatDateRawWithTime(subscriptionPlan.expiration,
                        shorten: true),
                    style: context.textTheme.titleLarge!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Status: ${status.capitalize}",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Account: ${plan.enabled ? "Enabled" : "Disabled"}",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 10.w,
                top: 5.h,
                child: Icon(
                  IconsaxPlusLinear.calendar,
                  size: 26.r,
                  color: light,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
