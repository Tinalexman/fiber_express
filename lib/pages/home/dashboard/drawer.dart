import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class FiberDrawer extends ConsumerWidget {
  final VoidCallback onCloseDrawer;

  const FiberDrawer({
    super.key,
    required this.onCloseDrawer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool darkTheme = context.isDark;

    return Drawer(
      width: 270.w,
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "fiber",
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkTheme ? light : primary,
                      ),
                    ),
                    TextSpan(
                      text: "Xpress",
                      style: context.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkTheme ? light : secondary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 50.h),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.dashboard);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.menu_1,
                size: 26.r,
                color: darkTheme ? light : monokai,
              ),
              title: Text(
                "Dashboard",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.billing);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.chart_1,
                size: 26.r,
                color: darkTheme ? light : monokai,
              ),
              title: Text(
                "Billing",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.report);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.graph,
                size: 26.r,
                color: darkTheme ? light : monokai,
              ),
              title: Text(
                "Report",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                onCloseDrawer();
                context.router.pushNamed(Pages.profile);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.profile,
                size: 26.r,
                color: darkTheme ? light : monokai,
              ),
              title: Text(
                "Profile",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 50.h),
            ListTile(
              onTap: () {
                onCloseDrawer();
                logout(ref);
                context.router.goNamed(Pages.login);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.logout,
                size: 26.r,
                color: darkTheme ? light : monokai,
              ),
              title: Text(
                "Logout",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
