import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({super.key});

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text(
            "Fund your fiberXpress wallet",
            style: context.textTheme.labelLarge,
          ),
          SizedBox(height: 2.h),
          SpecialForm(
            controller: priceController,
            width: 390.w,
            height: 50.h,
            hint: "e.g 1000",
            type: TextInputType.number,
          ),
          SizedBox(height: 450.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(390.w, 50.h),
              fixedSize: Size(390.w, 50.h),
              backgroundColor: darkTheme ? secondary : primary,
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.5.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Pay Now",
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
