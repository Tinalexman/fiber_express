import "package:fiber_express/components/subscription_and_device.dart";

import "authentication.dart" show token;

import "base.dart";
export "base.dart" show FiberResponse, log;



Future<FiberResponse> getServicePlan(String planID) async {
  try {
    Response response = await dio.get(
      "/admin/servicePlan/retrievePlanById",
      queryParameters: {
        "planId": planID,
      },
    );
    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"];
      log("Service Plan");
      log("$data");
      return FiberResponse(
        message: "Success",
        data: null,
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