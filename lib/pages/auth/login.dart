import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:fiber_express/api/authentication.dart';
import 'package:fiber_express/api/file_service.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:fiber_express/misc/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends ConsumerStatefulWidget {
  final Map<String, String>? details;

  const LoginPage({
    super.key,
    this.details,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late Map<String, String> _authDetails;

  bool showPassword = false, loading = false, remember = false;

  @override
  void initState() {
    super.initState();
    if(widget.details != null) {
      loading = true;
      remember = true;
      _authDetails = widget.details!;
      emailController.text = _authDetails["username"]!;
      passwordController.text = _authDetails["password"]!;
      Future.delayed(Duration.zero, login);
    } else {
      _authDetails = {
        "username": "",
        "password": "",
      };
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void displayToast(String message) => showToast(message, context);

  void goToDashboard() => context.router.pushReplacementNamed(Pages.dashboard);

  void login() async {
    FiberResponse<LoginResponse?> response = await authenticate(_authDetails);
    setState(() => loading = false);

    if (!response.success) {
      displayToast(response.message);
      return;
    }

    FileManager.saveAuthDetails(remember ? _authDetails : null);

    ref.watch(userProvider.notifier).state = response.data!.user;
    ref.watch(deviceStatusProvider.notifier).state = response.data!.deviceStatus;
    ref.watch(subscriptionPlanProvider.notifier).state = response.data!.subscriptionPlan;

    goToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 63.h,
                ),
                RichText(
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
                Text(
                  "Welcome back",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 32.h),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        "Email",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        width: 390.w,
                        height: 50.h,
                        controller: emailController,
                        prefix: Icon(
                          Icons.mail_outline_rounded,
                          size: 18.r,
                        ),
                        type: TextInputType.emailAddress,
                        onValidate: (value) {
                          // if (value!.isEmpty || !value.contains("@")) {
                          //   showToast("Invalid Email Address", context);
                          //   return '';
                          // }
                          if (value!.trim().isEmpty) {
                            showToast("Please enter your email", context);
                            return '';
                          }

                          return null;
                        },
                        onSave: (value) =>
                            _authDetails["username"] = value!.trim(),
                        hint: "e.g johndoe@mail.com",
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Password",
                        style: context.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.h),
                      SpecialForm(
                        obscure: !showPassword,
                        width: 390.w,
                        height: 40.h,
                        controller: passwordController,
                        type: TextInputType.text,
                        prefix: Icon(
                          Icons.lock_outline_rounded,
                          size: 18.r,
                        ),
                        suffix: GestureDetector(
                          onTap: () =>
                              setState(() => showPassword = !showPassword),
                          child: AnimatedSwitcherTranslation.right(
                            duration: const Duration(milliseconds: 500),
                            child: Icon(
                              !showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18.r,
                              key: ValueKey<bool>(showPassword),
                            ),
                          ),
                        ),
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            showToast("Please enter your password", context);
                            return '';
                          }
                          return null;
                        },
                        onSave: (value) =>
                            _authDetails["password"] = value!.trim(),
                        hint: "********",
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: remember,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: darkTheme ? secondary : primary,
                                onChanged: (val) =>
                                    setState(() => remember = !remember),
                              ),
                              Text(
                                "Remember Me",
                                style: context.textTheme.bodyMedium,
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () => context.router.pushNamed(Pages.forgot),
                            child: Text(
                              "Forgot Password?",
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: darkTheme ? secondary : primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 100.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(390.w, 50.h),
                          backgroundColor: darkTheme ? secondary : primary,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5.r),
                          ),
                        ),
                        onPressed: () {
                          if (!validateForm(formKey)) return;
                          if (loading) return;

                          setState(() => loading = true);
                          login();
                        },
                        child: loading
                            ? loader
                            : Text(
                                "Log In",
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
