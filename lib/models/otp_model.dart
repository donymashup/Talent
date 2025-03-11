class OtpModel {
  final String type;
  final String otp;

  OtpModel({required this.type, required this.otp});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
      type: json['type'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'otp': otp,
    };
  }
}
