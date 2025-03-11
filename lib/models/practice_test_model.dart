class PracticeTestModel {
  List<Practices>? practices;
  String? type;

  PracticeTestModel({this.practices, this.type});

  PracticeTestModel.fromJson(Map<String, dynamic> json) {
    if (json['practices'] != null) {
      practices = <Practices>[];
      json['practices'].forEach((v) {
        practices!.add(new Practices.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.practices != null) {
      data['practices'] = this.practices!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Practices {
  String? batchPracticeTestsId;
  String? packageid;
  String? batchid;
  String? batchPracticeTestsStatus;
  String? practiceTestsId;
  String? practiceTestsName;
  String? practiceQuestions;
  String? practiceTestsDuration;
  bool? attended;

  Practices(
      {this.batchPracticeTestsId,
      this.packageid,
      this.batchid,
      this.batchPracticeTestsStatus,
      this.practiceTestsId,
      this.practiceTestsName,
      this.practiceQuestions,
      this.practiceTestsDuration,
      this.attended});

  Practices.fromJson(Map<String, dynamic> json) {
    batchPracticeTestsId = json['batch_practice_tests_id'];
    packageid = json['packageid'];
    batchid = json['batchid'];
    batchPracticeTestsStatus = json['batch_practice_tests_status'];
    practiceTestsId = json['practice_tests_id'];
    practiceTestsName = json['practice_tests_name'];
    practiceQuestions = json['practice_questions'];
    practiceTestsDuration = json['practice_tests_duration'];
    attended = json['attended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_practice_tests_id'] = this.batchPracticeTestsId;
    data['packageid'] = this.packageid;
    data['batchid'] = this.batchid;
    data['batch_practice_tests_status'] = this.batchPracticeTestsStatus;
    data['practice_tests_id'] = this.practiceTestsId;
    data['practice_tests_name'] = this.practiceTestsName;
    data['practice_questions'] = this.practiceQuestions;
    data['practice_tests_duration'] = this.practiceTestsDuration;
    data['attended'] = this.attended;
    return data;
  }
}