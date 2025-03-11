class SubjectListModel {
  List<Subjects>? subjects;
  String? type;

  SubjectListModel({this.subjects, this.type});

  SubjectListModel.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Subjects {
  String? packageSubjectId;
  String? packageid;
  String? packageSubjectStatus;
  String? subjectName;
  String? subjectId;
  String? subjectDescription;
  String? subjectImage;

  Subjects(
      {this.packageSubjectId,
      this.packageid,
      this.packageSubjectStatus,
      this.subjectName,
      this.subjectId,
      this.subjectDescription,
      this.subjectImage});

  Subjects.fromJson(Map<String, dynamic> json) {
    packageSubjectId = json['package_subject_id'];
    packageid = json['packageid'];
    packageSubjectStatus = json['package_subject_status'];
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    subjectDescription = json['subject_description'];
    subjectImage = json['subject_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_subject_id'] = this.packageSubjectId;
    data['packageid'] = this.packageid;
    data['package_subject_status'] = this.packageSubjectStatus;
    data['subject_name'] = this.subjectName;
    data['subject_id'] = this.subjectId;
    data['subject_description'] = this.subjectDescription;
    data['subject_image'] = this.subjectImage;
    return data;
  }
}