import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:is_first_run/is_first_run.dart';

import 'misc/constants.dart';
import 'misc/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ScreenUtil.ensureScreenSize();

  bool firstRun = await IsFirstRun.isFirstRun();

  runApp(ProviderScope(child: FiberExpress(firstRun: firstRun)));
}

class FiberExpress extends StatefulWidget {
  final bool firstRun;

  const FiberExpress({
    super.key,
    required this.firstRun,
  });

  @override
  State<FiberExpress> createState() => _FiberExpressState();
}

class _FiberExpressState extends State<FiberExpress> {
  late GoRouter router;

  @override
  void initState() {
    super.initState();
    router = GoRouter(
      initialLocation: Pages.login.path,
      routes: routes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp.router(
        title: 'Fiber Express',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: FlexColorScheme.light(
          scheme: FlexScheme.aquaBlue,
          fontFamily: "Montserrat",
          useMaterial3: true,
          appBarStyle: FlexAppBarStyle.scaffoldBackground,
        ).toTheme.copyWith(
          cardTheme: const CardTheme(
            elevation: 0.0,
            color: null,
            shape: LinearBorder(),
            shadowColor: Colors.black12,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        darkTheme: FlexColorScheme.dark(
          scheme: FlexScheme.aquaBlue,
          fontFamily: "Montserrat",
          useMaterial3: true,
          appBarStyle: FlexAppBarStyle.scaffoldBackground,
        ).toTheme.copyWith(
          cardTheme: const CardTheme(
            elevation: 0.0,
            color: null,
            shape: LinearBorder(),
            shadowColor: Colors.white10,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        routerConfig: router,
      ),
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      designSize: const Size(375, 800),
      minTextAdapt: true,
    );
  }
}
