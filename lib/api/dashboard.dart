import "package:fiber_express/components/plan.dart";
import "package:fiber_express/components/usage.dart";
import "package:fiber_express/components/wallet.dart";

import "authentication.dart" show token;
import "base.dart";

export "base.dart" show FiberResponse, log;

Future<FiberResponse<Plan?>> getServicePlan(String planID) async {
  try {
    Response response = await dio.get(
      "/admin/servicePlan/retrievePlanById",
      queryParameters: {
        "planId": planID,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic ${btoa(radiusClientUsername, radiusClientPassword)}"
        },
      ),
    );
    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"];
      return FiberResponse(
        message: "Success",
        data: Plan(
          id: data["id"],
          name: data["name"],
          amount: (data["price"] as num).toDouble(),
          downloadRate: (data["downloadRate"] as num).toInt(),
          uploadRate: (data["uploadRate"] as num).toInt(),
          enabled: data["status"] == "enabled",
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Subscription Plan Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<FiberResponse<Usage?>> getCurrentMonthDataUsage(String username) async {
  try {
    Response response = await dio.get(
      "/client/users/retrieveCurrentMonthUsage",
      queryParameters: {
        "userName": username,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"];
      List<String> date = data["shortMonth"].split(", ");
      String month = date[0], year = date[1];

      return FiberResponse(
        message: "Success",
        data: Usage(
          id: "${data["month"]}${data["totalUsage"]}",
          total: data["totalUsage"],
          year: year,
          month: month,
          downloaded: data["totalDownload"],
          uploaded: data["totalUpload"],
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Data Usage Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}

Future<FiberResponse<List<Usage>>> getFullYearDataUsage(String username) async {
  try {
    Response response = await dio.get(
      "/client/users/retrieveCurrentYearsUsagePerMonth",
      queryParameters: {
        "userName": username,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode! == 200) {
      List<dynamic> data = response.data["data"];
      List<Usage> usages = [];

      for(var element in data) {
        Usage usage = Usage(
          id: "${element["sn"]}${element["totalUsageInGiB"]}",
          total: element["totalUsageInGiB"],
          year: element["Year"],
          month: element["month"],
          downloaded: "",
          uploaded: "",
        );
        usages.add(usage);
      }

      return FiberResponse(
        message: "Success",
        data: usages,
        success: true,
      );
    }
  } catch (e) {
    log("Data Usage Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: [],
    success: false,
  );
}

Future<FiberResponse<Wallet?>> getWalletBalance(String username) async {
  try {
    Response response = await dio.get(
      "/client/wallet/retrieveWallet",
      queryParameters: {
        "userName": username,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ),
    );
    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"];

      return FiberResponse(
        message: "Success",
        data: Wallet(
          id: data["id"],
          balance: (data["balance"] as num).toDouble(),
          currency: data["currency"],
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Wallet Balance Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}
