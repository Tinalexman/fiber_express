import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:fiber_express/pages/home/report/payment.dart';
import 'package:fiber_express/pages/home/report/subscription.dart';
import 'package:fiber_express/pages/home/report/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({super.key});

  @override
  ConsumerState<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  final TextEditingController controller = TextEditingController();

  final List<String> menus = [
    "Wallet",
    "Subscription",
    "Payment",
  ];

  late List<Widget> children;

  late String currentMenu;

  @override
  void initState() {
    super.initState();
    currentMenu = menus.first;
    children = const [
      Wallet(),
      Subscription(),
      Payment(),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
        ),
        title: Text(
          "$currentMenu Report",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) => setState(() => currentMenu = value),
            elevation: 1.0,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 0.h,
            ),
            itemBuilder: (_) => List.generate(
              menus.length,
              (index) => PopupMenuItem<String>(
                value: menus[index],
                child: Text(
                  menus[index],
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SpecialForm(
                controller: controller,
                width: 375.w,
                height: 50.h,
                hint: "Search ${currentMenu.toLowerCase()}",
                action: TextInputAction.search,
                prefix: Icon(
                  IconsaxPlusLinear.search_normal,
                  size: 20.r,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: IndexedStack(
                  index: menus.indexOf(currentMenu),
                  children: children,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
