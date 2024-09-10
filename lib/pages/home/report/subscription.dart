import 'package:fiber_express/components/transaction.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Subscription extends ConsumerStatefulWidget {
  const Subscription({super.key});

  @override
  ConsumerState<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends ConsumerState<Subscription> {
  DataTableSource dataSource = SubscriptionSource(
    transactions: [],
    textStyle: const TextStyle(),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(
        () => dataSource = SubscriptionSource(
          transactions: ref.read(subscriptionTransactionsProvider),
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
            'Plan Name',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Amount Paid',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Former Expiry',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'New Expiry',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Payment Method',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Status',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Transaction Date',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Reference',
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

class SubscriptionSource extends DataTableSource {
  final TextStyle? textStyle;
  final List<SubscriptionTransaction> transactions;

  SubscriptionSource({
    required this.transactions,
    required this.textStyle,
  });

  @override
  int get rowCount => transactions.length;

  @override
  DataRow? getRow(int index) {
    SubscriptionTransaction transaction = transactions[index];

    return DataRow(
      cells: [
        DataCell(
          Text(
            transaction.plan,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            "₦${formatRawAmount(transaction.amount)}",
            style: textStyle?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            formatDateRawWithTime(transaction.formerExpiry),
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            formatDateRawWithTime(transaction.newExpiry),
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            transaction.method,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            transaction.status,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            formatDateRawWithTime(transaction.createdAt),
            style: textStyle?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DataCell(
          Text(
            transaction.reference,
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
