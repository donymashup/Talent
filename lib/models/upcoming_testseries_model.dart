class UpcomingTestsModel {
  List<Upcoming>? upcoming;

  UpcomingTestsModel({this.upcoming});

  UpcomingTestsModel.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(new Upcoming.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Upcoming {
  String? mainTestsId;
  String? mainTestsName;
  String? mainTestsDuration;
  String? mainTestsQuestions;
  String? mainTestsStart;
  String? mainTestsEnd;

  Upcoming(
      {this.mainTestsId,
      this.mainTestsName,
      this.mainTestsDuration,
      this.mainTestsQuestions,
      this.mainTestsStart,
      this.mainTestsEnd});

  Upcoming.fromJson(Map<String, dynamic> json) {
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
