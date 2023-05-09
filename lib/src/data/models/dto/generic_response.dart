class GenericResponse {
  String? status;
  String? message;
  dynamic data;

  GenericResponse({
    this.status,
    this.message,
    this.data,
  });

  GenericResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }
}
