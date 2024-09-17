import 'package:fiber_express/api/reports.dart';
import 'package:fiber_express/components/transaction.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Payment extends ConsumerStatefulWidget {
  const Payment({super.key});

  @override
  ConsumerState<Payment> createState() => _PaymentState();
}

class _PaymentState extends ConsumerState<Payment> {
  DataTableSource dataSource = PaymentSource(
    transactions: [],
    textStyle: const TextStyle(),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(
        () => dataSource = PaymentSource(
          transactions: ref.read(paymentTransactionsProvider),
          textStyle: context.textTheme.bodyMedium?.copyWith(
            color: null,
          ),
        ),
      );
      getData();
    });
  }

  void displayToast(String message) => showToast(message, context);

  Future<void> getData({int newPage = 1}) async {
    String username = ref.watch(userProvider.select((value) => value.username));
    String search = ref.watch(reportsSearchProvider);
    FiberResponse<List<PaymentTransaction>> response =
        await getPaymentTransactions(username, search, newPage);
    if (!response.success) {
      displayToast(response.message);
      return;
    }

    List<PaymentTransaction> transactions = response.data;
    ref.watch(paymentTransactionsProvider.notifier).state = transactions;

    setState(
      () => dataSource = PaymentSource(
        transactions: transactions,
        textStyle: context.textTheme.bodyMedium?.copyWith(
          color: null,
        ),
      ),
    );
  }

  void listenForSearchChanges() {
    ref.listen(reportsSearchProvider, (_, __) {
      getData();
    });

    ref.listen(refreshReportsProvider, (_, __) {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: [
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
            'Payment Ref',
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

class PaymentSource extends DataTableSource {
  final TextStyle? textStyle;
  final List<PaymentTransaction> transactions;

  PaymentSource({
    required this.transactions,
    required this.textStyle,
  });

  @override
  int get rowCount => transactions.length;

  @override
  DataRow? getRow(int index) {
    PaymentTransaction transaction = transactions[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            transaction.method,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            transaction.payment,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            "${transaction.amount < 0 ? "-" : ""}₦${formatRawAmount(transaction.amount)}",
            style: textStyle?.copyWith(
              fontWeight: FontWeight.w600,
            ),
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
            formatDateRawWithTime(DateTime.parse(transaction.createdAt)),
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
