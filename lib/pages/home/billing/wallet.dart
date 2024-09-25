import 'package:fiber_express/api/billing.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletTab extends ConsumerStatefulWidget {
  const WalletTab({super.key});

  @override
  ConsumerState<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends ConsumerState<WalletTab> {
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  bool loading = false;

  void showMessage(String message) => showToast(message, context);

  void goBackHome() => context.router.pop();

  Future<void> fund() async {
    String username = ref.watch(userProvider.select((value) => value.username));
    String amount = priceController.text.trim().replaceAll(",", "");

    var response = await fundWallet({
      "userName": username,
      "amount": amount,
      "paymentMethod": "paystack",
    });
    setState(() => loading = false);
    showMessage(response.message);


    if (response.success && response.data != null) {
      Future.delayed(Duration.zero, () {
        launchURL(response.data!.authorizationUrl);
      });
      return;
    }

    bool initialState = ref.watch(refreshHomeDashboardProvider);
    ref.watch(refreshHomeDashboardProvider.notifier).state = !initialState;
    goBackHome();
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
            hint: "e.g 1,000",
            type: TextInputType.number,
            formatters: [DigitGroupFormatter()],
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
            onPressed: () {
              String value = priceController.text.trim();
              if (value.isEmpty) {
                showMessage("Invalid amount");
                return;
              }

              if (loading) return;
              setState(() => loading = true);
              fund();
            },
            child: loading
                ? loader
                : Text(
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
