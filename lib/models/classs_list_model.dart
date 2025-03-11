class ClassListModel {
  List<Classes>? classes;
  String? type;

  ClassListModel({this.classes, this.type});

  ClassListModel.fromJson(Map<String, dynamic> json) {
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Classes {
  String? packageClassId;
  String? packageid;
  String? packageClassStatus;
  String? className;
  String? classId;
  String? classDescription;
  String? classImage;

  Classes(
      {this.packageClassId,
      this.packageid,
      this.packageClassStatus,
      this.className,
      this.classId,
      this.classDescription,
      this.classImage});

  Classes.fromJson(Map<String, dynamic> json) {
    packageClassId = json['package_class_id'];
    packageid = json['packageid'];
    packageClassStatus = json['package_class_status'];
    className = json['class_name'];
    classId = json['class_id'];
    classDescription = json['class_description'];
    classImage = json['class_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_class_id'] = this.packageClassId;
    data['packageid'] = this.packageid;
    data['package_class_status'] = this.packageClassStatus;
    data['class_name'] = this.className;
    data['class_id'] = this.classId;
    data['class_description'] = this.classDescription;
    data['class_image'] = this.classImage;
    return data;
  }
}