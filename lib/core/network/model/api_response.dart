import 'error_message.dart';

class APIResponse<T> {
  bool success;
  T? data;
  ErrorMessage? message;

  APIResponse(this.success, this.data, this.message);

  factory APIResponse.fromJson(Map<String, dynamic> json, Function? builder) {
    return APIResponse(
      json['success'] != null ? json['success'] as bool : false,
      (builder == null || json['result'] == null)
          ? json['result']
          : builder(json['result']),
      json['error'] == null ? null : ErrorMessage.fromJson(json['error']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['result'] = data;
    jsonData['error'] = message?.toJson();
    jsonData['success'] = success;
    return jsonData;
  }
}
