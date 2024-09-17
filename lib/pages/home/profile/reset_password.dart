import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool showCurrent = false, showNew = false, showConfirm = false;

  bool loading = false;

  final Map<String, String> resetDetails = {
    "currentPassword": "",
    "newPassword": "",
  };

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
        ),
        title: Text(
          "Change Password",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Current Password",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 2.h),
                  SpecialForm(
                    controller: currentPasswordController,
                    width: 390.w,
                    height: 50.h,
                    hint: "******",
                    obscure: !showCurrent,
                    suffix: GestureDetector(
                      onTap: () => setState(() => showCurrent = !showCurrent),
                      child: AnimatedSwitcherTranslation.right(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          !showCurrent
                              ? IconsaxPlusLinear.eye
                              : IconsaxPlusLinear.eye_slash,
                          size: 22.r,
                          key: ValueKey<bool>(showCurrent),
                          color: darkTheme ? light : monokai,
                        ),
                      ),
                    ),
                    onValidate: (value) {
                      if (value!.isEmpty) {
                        showToast(
                            "Please provide your current password", context);
                        return '';
                      }
                      return null;
                    },
                    onSave: (value) => resetDetails["currentPassword"] = value!,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "New Password",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 2.h),
                  SpecialForm(
                    controller: newPasswordController,
                    width: 390.w,
                    height: 50.h,
                    hint: "******",
                    obscure: !showNew,
                    suffix: GestureDetector(
                      onTap: () => setState(() => showNew = !showNew),
                      child: AnimatedSwitcherTranslation.right(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          !showNew
                              ? IconsaxPlusLinear.eye
                              : IconsaxPlusLinear.eye_slash,
                          size: 22.r,
                          key: ValueKey<bool>(showNew),
                          color: darkTheme ? light : monokai,
                        ),
                      ),
                    ),
                    onValidate: (value) {
                      if (value!.isEmpty) {
                        showToast("Please provide your new password", context);
                        return '';
                      }
                      return null;
                    },
                    onSave: (value) => resetDetails["newPassword"] = value!,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Confirm Password",
                    style: context.textTheme.labelLarge,
                  ),
                  SizedBox(height: 2.h),
                  SpecialForm(
                    controller: confirmPasswordController,
                    width: 390.w,
                    height: 50.h,
                    hint: "******",
                    obscure: !showConfirm,
                    suffix: GestureDetector(
                      onTap: () => setState(() => showConfirm = !showConfirm),
                      child: AnimatedSwitcherTranslation.right(
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          !showConfirm
                              ? IconsaxPlusLinear.eye
                              : IconsaxPlusLinear.eye_slash,
                          size: 22.r,
                          key: ValueKey<bool>(showConfirm),
                          color: darkTheme ? light : monokai,
                        ),
                      ),
                    ),
                    onValidate: (value) {
                      String confirmPassword = value.trim();
                      String newPassword = newPasswordController.text.trim();
                      if (confirmPassword != newPassword) {
                        showToast("Passwords do not match", context);
                        return '';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 100.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(390.w, 50.h),
                      fixedSize: Size(390.w, 50.h),
                      backgroundColor: primary,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.5.r),
                      ),
                    ),
                    onPressed: () {
                      if (loading || !validateForm(formKey)) return;
                      setState(() => loading = true);
                    },
                    child: loading
                        ? loader
                        : Text(
                      "Change",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
