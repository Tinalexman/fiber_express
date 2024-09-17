import "package:fiber_express/components/transaction.dart";

import "authentication.dart" show token;
import "base.dart";

export "base.dart" show FiberResponse, log;


Future<FiberResponse<List<WalletTransaction>>> getWalletTransactions(String username, String search, int page) async {
  try {
    Response response = await dio.get(
      "/client/users/report/walletTransaction",
      queryParameters: {
        "userName": username,
        "search": search,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "X-Pagination-Limit": 10,
          "X-Pagination-Page": page,
        },
      ),
    );
    if (response.statusCode! == 200) {
      List<dynamic> data = response.data["data"];
      List<WalletTransaction> transactions = [];

      for(var element in data) {
        log("$data");
        WalletTransaction transaction = WalletTransaction(
          reference: element["Reference"],
          amount: (element["Amount"] as num).toDouble(),
          id: element["CreatedAt"],
          createdAt: element["CreatedAt"],
          purpose: element["Purpose"],
          narration: element["Narration"],
          balanceAfter: (element["BalanceAfter"] as num).toDouble(),
          balanceBefore: (element["BalanceBefore"] as num).toDouble(),
        );
        transactions.add(transaction);
      }

      return FiberResponse(
        message: "Success",
        data: transactions,
        success: true,
      );
    }
  } catch (e) {
    log("Wallet Transaction Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: [],
    success: false,
  );

}


