class AvailableCoursesModel {
  String? type;
  List<Category>? data;
  String? message;

  AvailableCoursesModel({this.type, this.data, this.message});

  AvailableCoursesModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['data'] != null) {
      data = <Category>[];
      json['data'].forEach((v) {
        data!.add(Category.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  List<Courses>? courses;

  Category({this.id, this.name, this.courses});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  CourseDetails? courseDetails;
  String? categoryId;
  String? categoryName;
  double? avgStars;
  bool? subscribed;
  String? batchid;
  // int? enrollmentList;

  Courses({
    this.courseDetails,
    this.categoryId,
    this.categoryName,
    this.avgStars,
    this.subscribed,
    this.batchid,
    // this.enrollmentList
  });

  Courses.fromJson(Map<String, dynamic> json) {
    courseDetails = json['course_details'] != null
        ? CourseDetails.fromJson(json['course_details'])
        : null;
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    avgStars = (json['avg_stars'] as num?)?.toDouble();
    //avgStars = json['avg_stars'];
    subscribed = json['subscribed'];
    batchid = json['batchid'];
    // enrollmentList = json['enrollment_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseDetails != null) {
      data['course_details'] = courseDetails!.toJson();
    }
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['avg_stars'] = avgStars ?? 0.0;
    //data['avg_stars'] = avgStars;
    data['subscribed'] = subscribed;
    data['batchid'] = batchid;
    // data['enrollment_list'] = enrollmentList;
    return data;
  }
}

class CourseDetails {
  String? id;
  String? name;
  String? start;
  String? end;
  String? type;
  String? level;
  String? duration;
  String? durationType;
  String? image;
  String? price;
  String? discount;
  String? description;
  String? created;
  String? status;

  CourseDetails(
      {this.id,
      this.name,
      this.start,
      this.end,
      this.type,
      this.level,
      this.duration,
      this.durationType,
      this.image,
      this.price,
      this.discount,
      this.description,
      this.created,
      this.status});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    type = json['type'];
    level = json['level'];
    duration = json['duration'];
    durationType = json['duration_type'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start'] = start;
    data['end'] = end;
    data['type'] = type;
    data['level'] = level;
    data['duration'] = duration;
    data['duration_type'] = durationType;
    data['image'] = image;
    data['price'] = price;
    data['discount'] = discount;
    data['description'] = description;
    data['created'] = created;
    data['status'] = status;
    return data;
  }
}
