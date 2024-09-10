import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fiber_express/components/plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'constants.dart';
import 'functions.dart';

const SpinKitDancingSquare loader = SpinKitDancingSquare(
  color: primary,
  size: 20,
);

const SpinKitDancingSquare whiteLoader = SpinKitDancingSquare(
  color: Colors.white,
  size: 32,
);

class TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  TabHeaderDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: context.isDark ? Colors.black : Colors.white,
        child: tabBar,
      );

  @override
  bool shouldRebuild(TabHeaderDelegate oldDelegate) => false;
}

class Popup extends StatelessWidget {
  const Popup({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CenteredPopup(),
      );
}

class CenteredPopup extends StatelessWidget {
  const CenteredPopup({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: loader);
}

class SpecialForm extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final bool obscure;
  final bool autoValidate;
  final FocusNode? focus;
  final bool autoFocus;
  final Function? onChange;
  final Function? onActionPressed;
  final Function? onValidate;
  final Function? onSave;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool readOnly;
  final int maxLines;
  final bool allowHeightExpand;
  final double width;
  final double height;

  const SpecialForm({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.padding,
    this.hintStyle,
    this.style,
    this.focus,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscure = false,
    this.allowHeightExpand = false,
    this.autoValidate = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.none,
    this.onActionPressed,
    this.onChange,
    this.onValidate,
    this.onSave,
    this.radius,
    this.hint,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;
    return SizedBox(
      width: width,
      height: allowHeightExpand ? null : height,
      child: TextFormField(
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        maxLines: maxLines,
        focusNode: focus,
        autofocus: autoFocus,
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        textInputAction: action,
        readOnly: readOnly,
        onEditingComplete: () {
          if (onActionPressed != null) {
            onActionPressed!(controller.text);
          }
        },
        cursorColor: primary,
        style: style ??
            context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          fillColor: fillColor ?? (darkTheme ? monokai : light),
          filled: true,
          contentPadding: padding ??
              EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: maxLines == 1 ? 5.h : 10.h,
              ),
          prefixIcon: prefix != null
              ? SizedBox(
                  width: height,
                  height: height,
                  child: Center(
                    child: prefix,
                  ),
                )
              : null,
          suffixIcon: suffix != null
              ? SizedBox(
                  width: height,
                  height: height,
                  child: Center(child: suffix),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: radius ?? BorderRadius.circular(7.5.r),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: radius ?? BorderRadius.circular(7.5.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: radius ?? BorderRadius.circular(7.5.r),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          hintStyle: hintStyle ??
              context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                color: darkTheme ? Colors.white38 : Colors.black45,
              ),
        ),
        onChanged: (value) {
          if (onChange == null) return;
          onChange!(value);
        },
        validator: (value) {
          if (onValidate == null) return null;
          return onValidate!(value);
        },
        onSaved: (value) {
          if (onSave == null) return;
          onSave!(value);
        },
      ),
    );
  }
}

class ComboBox extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool noDecoration;

  const ComboBox({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.noDecoration = false,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                  alignment: valueAlignment,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: (noDecoration) ? null : buttonHeight ?? 40,
          width: (noDecoration) ? 80 : buttonWidth ?? 140,
          padding: (noDecoration)
              ? null
              : buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: (noDecoration)
              ? null
              : buttonDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      buttonHeight == null ? 20 : 7.5.r,
                    ),
                  ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? 140,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStatePropertyAll(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStatePropertyAll(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40,
          padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

Widget heroShuttleBuilder(
    BuildContext context,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromContext,
    BuildContext toContext) {
  switch (direction) {
    case HeroFlightDirection.push:
      return ScaleTransition(
        scale: animation.drive(
          Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(
            CurveTween(curve: Curves.fastOutSlowIn),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: toContext.widget,
        ),
      );
    case HeroFlightDirection.pop:
      return fromContext.widget;
  }
}

class PlanContainer extends StatelessWidget {
  final Plan plan;

  const PlanContainer({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;

    return Container(
      width: 375.w,
      height: 130.h,
      decoration: BoxDecoration(
        color: darkTheme ? secondary : primary,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Package",
            style: context.textTheme.bodyMedium!.copyWith(
              color: light,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            plan.name,
            style: context.textTheme.titleLarge!.copyWith(
              color: light,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "₦${formatAmount(plan.amount.toStringAsFixed(0))}",
            style: context.textTheme.headlineLarge!.copyWith(
              color: light,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "Capped at ${plan.mbLimit}Mbps (VAT incl.)",
            style: context.textTheme.bodyMedium!.copyWith(
              color: light,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ChoosePlanContainer extends StatefulWidget {
  final Function onSelect;

  const ChoosePlanContainer({
    super.key,
    required this.onSelect,
  });

  @override
  State<ChoosePlanContainer> createState() => _ChoosePlanContainerState();
}

class _ChoosePlanContainerState extends State<ChoosePlanContainer> {
  Plan plan = const Plan();

  final List<Plan> allPlans = const [
    Plan(
      name: "Royal Plan",
      mbLimit: 100,
      amount: 59500,
    ),
    Plan(
      name: "Gold Plan",
      mbLimit: 40,
      amount: 28500,
    ),
  ];

  void showPlans() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        bool darkTheme = context.isDark;

        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50.h,
            maxHeight: 180.h,
            minWidth: 375.w,
            maxWidth: 375.w,
          ),
          child: ListView.builder(
            itemBuilder: (_, index) => ListTile(
              onTap: () {
                Navigator.of(ctx).pop();
                setState(() => plan = allPlans[index]);
                widget.onSelect(allPlans[index]);
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              leading: Icon(
                IconsaxPlusLinear.gift,
                size: 26.r,
                color: darkTheme ? secondary : primary,
              ),
              title: Text(
                "${allPlans[index].name} (${"₦${formatAmount(allPlans[index].amount.toStringAsFixed(0))}"})",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Capped at ${allPlans[index].mbLimit}Mbps",
                style: context.textTheme.bodyMedium,
              ),
            ),
            itemCount: allPlans.length,
            physics: const BouncingScrollPhysics(),
          ),
        );
      },
      showDragHandle: true,
      elevation: 1.0,
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool darkTheme = context.isDark;

    return GestureDetector(
      onTap: showPlans,
      child: Container(
        width: 375.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: plan.isEmpty
              ? (darkTheme ? neutral : light)
              : (darkTheme ? secondary : primary),
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 10.h,
        ),
        alignment: plan.isEmpty ? Alignment.center : null,
        child: plan.isEmpty
            ? Text(
                "Tap to select a new plan",
                style: context.textTheme.bodyLarge,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Package",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    plan.name,
                    style: context.textTheme.titleLarge!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "₦${formatAmount(plan.amount.toStringAsFixed(0))}",
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "Capped at ${plan.mbLimit}Mbps (VAT incl.)",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: light,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
