import 'package:fiber_express/api/reports.dart';
import 'package:fiber_express/components/transaction.dart';
import 'package:fiber_express/misc/constants.dart';
import 'package:fiber_express/misc/functions.dart';
import 'package:fiber_express/misc/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  DataTableSource dataSource = WalletSource(
    transactions: [],
    textStyle: const TextStyle(),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(
        () => dataSource = WalletSource(
          transactions: ref.read(walletTransactionsProvider),
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
    FiberResponse<List<WalletTransaction>> response =
        await getWalletTransactions(username, search, newPage);
    if (!response.success) {
      displayToast(response.message);
      return;
    }

    //setTotalRows(getPR.headers["x-pagination-totalcount"]);

    List<WalletTransaction> transactions = response.data;
    ref.watch(walletTransactionsProvider.notifier).state = transactions;

    setState(
      () => dataSource = WalletSource(
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
    listenForSearchChanges();

    return PaginatedDataTable(
      rowsPerPage: 10,
      onPageChanged: (newPage) => getData(newPage: newPage),
      columns: [
        DataColumn(
          label: Text(
            'Amount',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Balance After',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Balance Before',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Created At',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Narration',
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            'Purpose',
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

class WalletSource extends DataTableSource {
  final TextStyle? textStyle;
  final List<WalletTransaction> transactions;

  WalletSource({
    required this.transactions,
    required this.textStyle,
  });

  @override
  int get rowCount => transactions.length;

  @override
  DataRow? getRow(int index) {
    WalletTransaction transaction = transactions[index];

    return DataRow(
      cells: [
        DataCell(
          Text(
            "${transaction.amount < 0 ? "-" : ""}₦${formatRawAmount(transaction.amount)}",
            style: textStyle?.copyWith(
              color: transaction.amount < 0 ? Colors.red : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            "₦${formatRawAmount(transaction.balanceAfter)}",
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            "₦${formatRawAmount(transaction.balanceBefore)}",
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
            transaction.narration,
            style: textStyle,
          ),
        ),
        DataCell(
          Text(
            transaction.purpose,
            style: textStyle?.copyWith(
              fontWeight: FontWeight.w600,
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
