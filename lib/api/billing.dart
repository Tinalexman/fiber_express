import "package:fiber_express/components/plan.dart";

import "authentication.dart";
import "base.dart";

export "base.dart" show log;

class PaystackMandate {
  final double amount;
  final String currency;
  final String accessCode;
  final String authorizationUrl;
  final String paymentRef;

  const PaystackMandate({
    this.amount = 0.0,
    this.currency = "",
    this.accessCode = "",
    this.authorizationUrl = "",
    this.paymentRef = "",
  });
}

// class

Future<FiberResponse<PaystackMandate?>> renewPaymentPlan(
    Map<String, dynamic> data) async {
  try {
    Response response = await dio.post(
      "/client/users/renewSubscription",
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }),
    );

    if (response.statusCode! == 200) {
      if (response.data["data"] == null) {
        return const FiberResponse(
          message: "Subscription renewal initiated successfully",
          data: null,
          success: true,
        );
      }

      Map<String, dynamic> data = response.data["data"] as Map<String, dynamic>;
      return FiberResponse(
        message: "Paystack Payment mandate created.",
        data: PaystackMandate(
          amount: double.tryParse(data["totalAmountToPay"]) ?? 0.0,
          currency: data["currency"],
          accessCode: data["accessCode"],
          authorizationUrl: data["authorizationUrl"],
          paymentRef: data["paymentRef"],
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Renew Payment Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<FiberResponse<List<Plan>>> getAvailablePlans() async {
  try {
    Response response = await dio.get(
      "/admin/servicePlan/retrieveAllActivePlan",
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Basic ${btoa(frontEndClientUsername, frontEndClientPassword)}"
      }),
    );

    if (response.statusCode! == 200) {
      List<dynamic> data = response.data["data"] as List<dynamic>;
      List<Plan> availablePlans = [];
      for (var element in data) {
        Plan plan = Plan(
          amount: (element["price"] as num).toDouble(),
          id: element["id"],
          enabled: element["status"] == "enabled",
          downloadRate: (element["downloadRate"] as num).toInt(),
          uploadRate: (element["uploadRate"] as num).toInt(),
          name: element["name"],
        );
        availablePlans.add(plan);
      }

      return FiberResponse(
        message: "Retrieved Available Plans",
        data: availablePlans,
        success: true,
      );
    }
  } catch (e) {
    log("Available Plans Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: [],
    success: false,
  );
}

Future<FiberResponse> fundWallet(
    Map<String, dynamic> data) async {
  try {
    Response response = await dio.post(
      "/client/wallet/fundWallet",
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }),
    );

    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"] as Map<String, dynamic>;
      return FiberResponse(
        message: "Paystack Payment mandate created.",
        data: PaystackMandate(
          amount: double.tryParse(data["totalAmountToPay"]) ?? 0.0,
          currency: data["currency"],
          accessCode: data["accessCode"],
          authorizationUrl: data["authorizationUrl"],
          paymentRef: data["paymentRef"],
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Fund Wallet Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}