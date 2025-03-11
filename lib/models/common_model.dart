class CommonModel {
  final String type;
  final String message;

  CommonModel({required this.type, required this.message});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      type: json['type'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'message': message,
    };
  }
}
