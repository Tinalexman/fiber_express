import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:fiber_express/pages/home/dashboard/drawer.dart';
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
    bool darkTheme = context.isDark;

    return Scaffold(
      key: scaffoldKey,
      drawer: FiberDrawer(
        onCloseDrawer: () => scaffoldKey.currentState?.closeDrawer(),
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
                radius: 20.r,
                backgroundColor: Colors.transparent,
              ),
              progressIndicatorBuilder: (_, __, c) => CircleAvatar(
                radius: 20.r,
                backgroundColor: secondary.withOpacity(0.5),
              ),
              imageBuilder: (_, provider) => GestureDetector(
                onTap: () => context.router.pushNamed(Pages.profile),
                child: CircleAvatar(
                  radius: 20.r,
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
