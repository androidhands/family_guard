class ErrorMessage {
  int code;
  String message;
  String details;

  ErrorMessage({
    required this.code,
    required this.message,
    required this.details,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      code: json['code'],
      details: json['details'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['details'] = details;
    return data;
  }

  @override
  String toString() {
    return 'ErrorMessage{code: $code, message: $message, details: $details}';
  }
}
