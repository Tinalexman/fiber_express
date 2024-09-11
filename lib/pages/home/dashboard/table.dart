import 'package:fiber_express/components/usage.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataUsage extends ConsumerStatefulWidget {
  const DataUsage({super.key});

  @override
  ConsumerState<DataUsage> createState() => _UsageState();
}

class _UsageState extends ConsumerState<DataUsage> {
  DataTableSource dataSource = UsageSource(
    usages: [],
    textStyle: const TextStyle(),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(
        () => dataSource = UsageSource(
          usages: ref.read(dataUsageProvider),
          textStyle: context.textTheme.bodyMedium?.copyWith(
            color: null,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: [
        DataColumn(
          label: Text(
            'Month',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Year',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Total Usage',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      source: dataSource,
    );
  }
}

class UsageSource extends DataTableSource {
  final TextStyle? textStyle;
  final List<Usage> usages;

  UsageSource({
    required this.usages,
    required this.textStyle,
  });

  @override
  int get rowCount => usages.length;

  @override
  DataRow? getRow(int index) {
    Usage usage = usages[index];

    return DataRow(
      cells: [
        DataCell(
          Text(
            usage.month,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            usage.year,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            usage.total,
            style: textStyle,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
