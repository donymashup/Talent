class AttendedTestsModel {
  List<Attended>? attended;
  String? type;
  String? message;

  AttendedTestsModel({this.attended, this.type, this.message});

  AttendedTestsModel.fromJson(Map<String, dynamic> json) {
    if (json['attended'] != null) {
      attended = <Attended>[];
      json['attended'].forEach((v) {
        attended!.add(new Attended.fromJson(v));
      });
    }
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attended != null) {
      data['attended'] = this.attended!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

class Attended {
  String? testid;
  String? subTime;
  String? answerid;
  String? start;
  String? duration;
  String? name;

  Attended(
      {this.testid,
      this.subTime,
      this.answerid,
      this.start,
      this.duration,
      this.name});

  Attended.fromJson(Map<String, dynamic> json) {
    testid = json['testid'];
    subTime = json['sub_time'];
    answerid = json['answerid'];
    start = json['start'];
    duration = json['duration'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testid'] = this.testid;
    data['sub_time'] = this.subTime;
    data['answerid'] = this.answerid;
    data['start'] = this.start;
    data['duration'] = this.duration;
    data['name'] = this.name;
    return data;
  }
}
