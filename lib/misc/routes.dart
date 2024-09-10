import 'package:fiber_express/pages/auth/forgot.dart';
import 'package:fiber_express/pages/auth/login.dart';
import 'package:fiber_express/pages/home/billing/billing.dart';
import 'package:fiber_express/pages/home/dashboard/dashboard.dart';
import 'package:fiber_express/pages/home/profile/profile.dart';
import 'package:fiber_express/pages/home/profile/reset_password.dart';
import 'package:fiber_express/pages/home/report/report.dart';
import 'package:go_router/go_router.dart';
import 'constants.dart';


final List<GoRoute> routes = [

  GoRoute(
    path: Pages.login.path,
    name: Pages.login,
    builder: (_, __) => const LoginPage(),
  ),
  GoRoute(
    path: Pages.forgot.path,
    name: Pages.forgot,
    builder: (_, __) => const ForgotPasswordPage(),
  ),
  GoRoute(
    path: Pages.dashboard.path,
    name: Pages.dashboard,
    builder: (_, __) => const DashboardPage(),
  ),
  GoRoute(
    path: Pages.profile.path,
    name: Pages.profile,
    builder: (_, __) => const ProfilePage(),
  ),
  GoRoute(
    path: Pages.billing.path,
    name: Pages.billing,
    builder: (_, __) => const BillingPage(),
  ),
  GoRoute(
    path: Pages.report.path,
    name: Pages.report,
    builder: (_, __) => const ReportPage(),
  ),
  GoRoute(
    path: Pages.resetPassword.path,
    name: Pages.resetPassword,
    builder: (_, __) => const ResetPasswordPage(),
  ),
];