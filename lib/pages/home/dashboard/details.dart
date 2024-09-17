import 'package:fiber_express/api/dashboard.dart';
import 'package:fiber_express/components/plan.dart';
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


  Future<void> getData() async {
    String planID = ref.watch(subscriptionPlanProvider.select((value) => value.currentPlan));
    await getServicePlan(planID);
  }


  void shouldRefresh() {
    ref.listen(refreshHomeDashboardProvider, (previous, next) {
      if((!previous! && next) || (previous && !next)) {
        getData();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    shouldRefresh();

    bool darkTheme = context.isDark;
    Plan plan = ref.watch(currentPlanProvider);
    double balance = 66500, dataUsed = 49.05, upload = 5.58, download = 43.46;
    DateTime expiry = DateUtilities.getCurrentMonthEnd();
    String status = "active";
    bool enabled = true;


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
                    "Capped at ${plan.mbLimit}Mbps (VAT incl.)",
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
                    "₦${formatAmount(balance.toStringAsFixed(0))}",
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
                    "Data Usage",
                    style: context.textTheme.labelMedium!.copyWith(
                      color: light,
                    ),
                  ),
                  Text(
                    "${dataUsed.toStringAsFixed(2)}GB",
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
                        "Upload: ${upload.toStringAsFixed(2)}GB",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Download: ${download.toStringAsFixed(2)}GB",
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
                    formatDateRawWithTime(expiry, shorten: true),
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
                        "Status: $status",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: light,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Account: ${enabled ? "enabled" : "disabled"}",
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
