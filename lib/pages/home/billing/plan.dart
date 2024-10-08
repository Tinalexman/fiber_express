import 'package:fiber_express/api/billing.dart';
import 'package:fiber_express/components/plan.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class PlanTab extends ConsumerStatefulWidget {
  const PlanTab({super.key});

  @override
  ConsumerState<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends ConsumerState<PlanTab> {
  bool loading = false;
  int mode = -1;

  Plan newPlan = const Plan();

  Color get backgroundColor {
    bool darkTheme = context.isDark;
    Color color = darkTheme ? secondary : primary;
    if(mode == -1 || newPlan.isEmpty) {
      color = color.withOpacity(0.65);
    }
    return color;
  }

  void showMessage(String message) => showToast(message, context);
  void goBackHome() => context.router.pop();

  Future<void> makePayment() async {
    String username = ref.watch(userProvider.select((value) => value.username));
    String subscriptionPlan = ref.watch(subscriptionPlanProvider.select((value) => value.currentPlan));

    var response = await renewPaymentPlan({
      "userName": username,
      "servicePlanId": subscriptionPlan,
      "paymentMethod": mode == 0 ? "wallet" : "paystack",
    });
    setState(() => loading = false);
    showMessage(response.message);
    if(response.success) {
      if(response.data != null) {
        Future.delayed(Duration.zero, () {
          launchURL(response.data!.authorizationUrl);
        });
      } else {
        bool initialState = ref.watch(refreshHomeDashboardProvider);
        ref.watch(refreshHomeDashboardProvider.notifier).state = !initialState;
        goBackHome();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Plan currentPlan = ref.watch(currentPlanProvider);
    bool darkTheme = context.isDark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          PlanContainer(plan: currentPlan),
          SizedBox(height: 15.h),
          Center(
            child: Icon(
              IconsaxPlusLinear.arrow_swap,
              size: 26.r,
            ),
          ),
          SizedBox(height: 15.h),
          ChoosePlanContainer(
            onSelect: (Plan plan) => setState(() => newPlan = plan),
          ),
          SizedBox(height: 30.h),
          Text(
            "Mode of payment",
            style: context.textTheme.bodyLarge,
          ),
          Wrap(
            spacing: 20.w,
            children: [
              GestureDetector(
                onTap: () => setState(() => mode = 0),
                child: Chip(
                  label: Text(
                    "Wallet",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: mode == 0 ? light : null,
                      fontWeight:
                          mode == 0 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  elevation: mode == 0 ? 1 : 0,
                  deleteIcon: mode == 0
                      ? Icon(
                          Icons.done_rounded,
                          size: 16.r,
                          color: mode == 0 ? light : null,
                        )
                      : null,
                  onDeleted: mode == 0 ? () {} : null,
                  backgroundColor: mode == 0
                      ? (darkTheme ? secondary : primary)
                      : (darkTheme ? neutral : light),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5.r),
                  ),
                  side: const BorderSide(color: Colors.transparent),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => mode = 1),
                child: Chip(
                  label: Text(
                    "Paystack",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: mode == 1 ? light : null,
                      fontWeight:
                          mode == 1 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  deleteIcon: mode == 1
                      ? Icon(
                          Icons.done_rounded,
                          size: 16.r,
                          color: mode == 1 ? light : null,
                        )
                      : null,
                  onDeleted: mode == 1 ? () {} : null,
                  elevation: mode == 1 ? 1 : 0,
                  backgroundColor: mode == 1
                      ? (darkTheme ? secondary : primary)
                      : (darkTheme ? neutral : light),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5.r),
                  ),
                  side: const BorderSide(color: Colors.transparent),
                ),
              ),
            ],
          ),
          SizedBox(height: 150.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(390.w, 50.h),
              fixedSize: Size(390.w, 50.h),
              backgroundColor: backgroundColor,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.5.r),
              ),
            ),
            onPressed: () {
              if (mode == -1 || newPlan.isEmpty || loading) return;
              setState(() => loading = true);
              makePayment();
            },
            child: loading
                ? loader
                : Text(
                    "Pay ₦${formatAmount(newPlan.amount.toStringAsFixed(0))}",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
