import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String id = ref.watch(userProvider.select((value) => value.id));

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
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
              Image.asset(
                "assets/images/fiber.png",
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50.h),
              ListTile(
                onTap: () {
                  scaffoldKey.currentState?.closeDrawer();
                  context.router.pushNamed(Pages.dashboard);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                leading: Icon(
                  IconsaxPlusLinear.menu_1,
                  size: 26.r,
                  color: primary,
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
                  scaffoldKey.currentState?.closeDrawer();
                  context.router.pushNamed(Pages.billing);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                leading: Icon(
                  IconsaxPlusLinear.chart_1,
                  size: 26.r,
                  color: primary,
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
                  scaffoldKey.currentState?.closeDrawer();
                  context.router.pushNamed(Pages.report);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                leading: Icon(
                  IconsaxPlusLinear.graph,
                  size: 26.r,
                  color: primary,
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
                  scaffoldKey.currentState?.closeDrawer();
                  context.router.pushNamed(Pages.profile);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                leading: Icon(
                  IconsaxPlusLinear.profile,
                  size: 26.r,
                  color: primary,
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
                  scaffoldKey.currentState?.closeDrawer();
                  logout(ref);
                  context.router.goNamed(Pages.login);
                },
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                leading: Icon(
                  IconsaxPlusLinear.logout,
                  size: 26.r,
                  color: primary,
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
      ),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
          icon: const Icon(IconsaxPlusLinear.menu),
          iconSize: 26.r,
        ),
        title: Text(
          "Dashboard",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: CachedNetworkImage(
              imageUrl: roboImage(id),
              errorWidget: (_, __, c) => CircleAvatar(
                radius: 22.r,
                backgroundColor: Colors.transparent,
              ),
              progressIndicatorBuilder: (_, __, c) => CircleAvatar(
                radius: 22.r,
                backgroundColor: secondary.withOpacity(0.5),
              ),
              imageBuilder: (_, provider) => GestureDetector(
                onTap: () => context.router.pushNamed(Pages.profile),
                child: CircleAvatar(
                  radius: 22.r,
                  backgroundImage: provider,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
