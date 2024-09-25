import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/pages/home/billing/payment.dart';
import 'package:fiber_express/pages/home/billing/plan.dart';
import 'package:fiber_express/pages/home/billing/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillingPage extends ConsumerStatefulWidget {
  const BillingPage({super.key});

  @override
  ConsumerState<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends ConsumerState<BillingPage> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => context.router.pop(),
            icon: const Icon(Icons.chevron_left_rounded),
            iconSize: 26.r,
          ),
          title: Text(
            "Billing",
            style: context.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor: darkTheme ? secondary : primary,
                  labelStyle: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  tabAlignment: TabAlignment.start,
                  indicatorColor: darkTheme ? secondary : primary,
                  unselectedLabelColor: darkTheme ? light : neutral,
                  unselectedLabelStyle: context.textTheme.bodyLarge,
                  tabs: const [
                    Tab(text: "Payment"),
                    Tab(text: "Change Plan"),
                    Tab(text: "Wallet Top Up"),
                  ],
                ),
                SizedBox(height: 5.h),
                const Expanded(
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      PaymentTab(),
                      PlanTab(),
                      WalletTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
