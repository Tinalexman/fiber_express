import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String id = ref.watch(userProvider.select((value) => value.id));
    String firstName =
        ref.watch(userProvider.select((value) => value.firstName));
    String lastName = ref.watch(userProvider.select((value) => value.lastName));
    String email = ref.watch(userProvider.select((value) => value.email));
    String phone = ref.watch(userProvider.select((value) => value.phone));
    String address = ref.watch(userProvider.select((value) => value.address));
    String state = ref.watch(userProvider.select((value) => value.state));
    String joined =
        ref.watch(userProvider.select((value) => value.createdAt));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: const Icon(Icons.chevron_left_rounded),
          iconSize: 26.r,
        ),
        title: Text(
          "Profile",
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            onSelected: (_) => context.router.pushNamed(Pages.resetPassword),
            elevation: 1.0,
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 0.h,
            ),
            itemBuilder: (_) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "Change Password",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                Center(
                  child: CachedNetworkImage(
                    imageUrl: roboImage(id),
                    errorWidget: (_, __, c) => CircleAvatar(
                      radius: 64.r,
                      backgroundColor: Colors.transparent,
                    ),
                    progressIndicatorBuilder: (_, __, c) => CircleAvatar(
                      radius: 64.r,
                      backgroundColor: secondary.withOpacity(0.5),
                    ),
                    imageBuilder: (_, provider) => CircleAvatar(
                      radius: 64.r,
                      backgroundImage: provider,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  "$firstName $lastName",
                  style: context.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  email,
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.isDark ? secondary : primary,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "$address, $state",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  phone,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Joined on ${formatDateRaw(DateTime.parse(joined))}",
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
