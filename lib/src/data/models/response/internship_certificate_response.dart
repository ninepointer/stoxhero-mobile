class InternshipCertificateResponse {
  String? status;
  String? message;
  List<InternshipBatches>? batches;

  InternshipCertificateResponse({this.status, this.message, this.batches});

  InternshipCertificateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['batches'] != null) {
      batches = <InternshipBatches>[];
      json['batches'].forEach((v) {
        batches!.add(new InternshipBatches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.batches != null) {
      data['batches'] = this.batches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InternshipBatches {
  String? id;
  String? name;
  String? startDate;
  String? endDate;

  InternshipBatches({this.id, this.name, this.startDate, this.endDate});

  InternshipBatches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}
