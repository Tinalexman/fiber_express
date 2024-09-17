import "package:fiber_express/components/subscription_and_device.dart";
import "package:fiber_express/components/user.dart";

import "base.dart";

export "base.dart" show FiberResponse, log;

String token = "";

class LoginResponse {
  final User user;
  final SubscriptionPlan subscriptionPlan;
  final DeviceStatus deviceStatus;

  const LoginResponse({
    required this.user,
    required this.subscriptionPlan,
    required this.deviceStatus,
  });
}

Future<FiberResponse<LoginResponse?>> authenticate(
    Map<String, String> details) async {
  try {
    Response response = await dio.post(
      "/client/users/authenticateUser",
      data: details,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic ${btoa(frontEndClientUsername, frontEndClientPassword)}"
        }
      ),
    );
    if (response.statusCode! == 200) {
      Map<String, dynamic> data = response.data["data"];
      User user = User(
        id: data["id"],
        userGroup: data["userGroup"],
        username: data["userName"],
        firstName: data["profileData"]["firstName"],
        lastName: data["profileData"]["lastName"],
        email: data["profileData"]["email"],
        state: data["profileData"]["state"],
        phone: data["profileData"]["phoneNumber"],
        address: data["profileData"]["address"],
        createdAt: data["createdAt"],
      );

      SubscriptionPlan subscriptionPlan = SubscriptionPlan(
        status: data["subscription"]["status"],
        currentPlan: data["subscription"]["currentServicePlan"],
        expiration: DateTime.parse(data["subscription"]["expiration"]),
      );

      DeviceStatus deviceStatus = DeviceStatus(
        lastOnline: DateTime.parse(data["device"]["lastOnline"]),
        status: data["device"]["currentDeviceStatus"],
        password: data["device"]["onuPassword"],
      );

      token = response.headers.value("user-token")!;

      return FiberResponse(
        message: "Success",
        data: LoginResponse(
          user: user,
          deviceStatus: deviceStatus,
          subscriptionPlan: subscriptionPlan,
        ),
        success: true,
      );
    }
  } catch (e) {
    log("Login Error: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}


Future<FiberResponse> changePassword(
    Map<String, String> details) async {
  try {
    Response response = await dio.put(
      "/client/users/changePassword",
      data: details,
      options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          }
      ),
    );
    if (response.statusCode! == 200) {
      return const FiberResponse(
        message: "Success",
        data: null,
        success: true,
      );
    }
  } catch (e) {
    log("Change Password: $e");
  }

  return const FiberResponse(
    message: "An error occurred. Please try again",
    data: null,
    success: false,
  );
}
