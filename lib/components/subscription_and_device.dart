class SubscriptionPlan {
  final String currentPlan;
  final String status;
  final DateTime expiration;

  const SubscriptionPlan({
    this.currentPlan = "",
    this.status = "",
    required this.expiration,
  });
}

class DeviceStatus {
  final DateTime lastOnline;
  final String status;
  final String password;

  const DeviceStatus({
    required this.lastOnline,
    this.status = "",
    this.password = "",
  });
}
