import "package:fiber_express/components/transaction.dart";

import "authentication.dart" show token;
import "base.dart";

export "base.dart" show FiberResponse, log;

Future<FiberResponse<List<WalletTransaction>>> getWalletTransactions(
    String username, String search, int page) async {
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
      List<dynamic> data = response.data;
      List<WalletTransaction> transactions = [];

      for (var element in data) {
        double before = double.tryParse(element["BalanceBefore"]) ?? 0.0;
        double after = double.tryParse(element["BalanceAfter"]) ?? 0.0;
        double amount = double.tryParse(element["Amount"]) ?? 0.0;
        if (before > after) amount *= -1;

        WalletTransaction transaction = WalletTransaction(
          reference: element["Reference"],
          amount: amount,
          id: element["CreatedAt"],
          createdAt: element["CreatedAt"],
          purpose: element["Purpose"],
          narration: element["Narration"],
          balanceAfter: after,
          balanceBefore: before,
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

Future<FiberResponse<List<PaymentTransaction>>> getPaymentTransactions(
    String username, String search, int page) async {
  try {
    Response response = await dio.get(
      "/client/users/report/paymentRequests",
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
      List<dynamic> data = response.data;
      List<PaymentTransaction> transactions = [];

      for (var element in data) {
        double amount = double.tryParse(element["TotalAmountPaid"]) ?? 0.0;

        PaymentTransaction transaction = PaymentTransaction(
          reference: element["TransactionRef"],
          payment: element["PaymentRef"],
          method: element["PaymentMethod"],
          amount: amount,
          status: element["Status"],
          id: element["TransactionDate"],
          createdAt: element["TransactionDate"],
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
    log("Payment Transaction Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: [],
    success: false,
  );
}

Future<FiberResponse<List<SubscriptionTransaction>>>
    getSubscriptionTransactions(
        String username, String search, int page) async {
  try {
    Response response = await dio.get(
      "/client/users/report/subscriptions",
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
      List<dynamic> data = response.data;
      List<SubscriptionTransaction> transactions = [];

      for (var element in data) {
        double amount = double.tryParse(element["AmountPaid"]) ?? 0.0;

        SubscriptionTransaction transaction = SubscriptionTransaction(
          createdAt: element["TransactionDate"],
          formerExpiry: element["FormerExpiryDate"],
          newExpiry: element["NewExpiryDate"],
          id: element["NewExpiryDate"],
          reference: element["TransactionRef"],
          status: element["SubscriptionStatus"],
          method: element["PaymentMethod"],
          plan: element["PlanName"],
          amount: amount,
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
    log("Subscription Transaction Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: [],
    success: false,
  );
}
