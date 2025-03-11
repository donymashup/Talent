class OngoingTestsModel {
  List<Ongoing>? ongoing;

  OngoingTestsModel({this.ongoing});

  OngoingTestsModel.fromJson(Map<String, dynamic> json) {
    if (json['ongoing'] != null) {
      ongoing = <Ongoing>[];
      json['ongoing'].forEach((v) {
        ongoing!.add(new Ongoing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ongoing != null) {
      data['ongoing'] = this.ongoing!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ongoing {
  String? mainTestsId;
  String? mainTestsName;
  String? mainTestsDuration;
  String? mainTestsQuestions;
  String? mainTestsStart;
  String? mainTestsEnd;

  Ongoing(
      {this.mainTestsId,
      this.mainTestsName,
      this.mainTestsDuration,
      this.mainTestsQuestions,
      this.mainTestsStart,
      this.mainTestsEnd});

  Ongoing.fromJson(Map<String, dynamic> json) {
    mainTestsId = json['main_tests_id'];
    mainTestsName = json['main_tests_name'];
    mainTestsDuration = json['main_tests_duration'];
    mainTestsQuestions = json['main_tests_questions'];
    mainTestsStart = json['main_tests_start'];
    mainTestsEnd = json['main_tests_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_tests_id'] = this.mainTestsId;
    data['main_tests_name'] = this.mainTestsName;
    data['main_tests_duration'] = this.mainTestsDuration;
    data['main_tests_questions'] = this.mainTestsQuestions;
    data['main_tests_start'] = this.mainTestsStart;
    data['main_tests_end'] = this.mainTestsEnd;
    return data;
  }
}
