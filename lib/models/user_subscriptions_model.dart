class UserSubscriptionsModel {
  String? type;
  List<Courses>? courses;
  String? message;

  UserSubscriptionsModel({this.type, this.courses, this.message});

  UserSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
    message = json['message'];
  }

  get userid => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Courses {
  CourseDetails? courseDetails;
  PackageDetails? packageDetails;
  int? likesCount;
  int? commentsCount;
  List<LikedUserImages>? likedUserImages;
  double? avgStars;

  Courses(
      {this.courseDetails,
      this.packageDetails,
      this.likesCount,
      this.commentsCount,
      this.likedUserImages,
      this.avgStars});

  Courses.fromJson(Map<String, dynamic> json) {
    courseDetails = json['course_details'] != null
        ? new CourseDetails.fromJson(json['course_details'])
        : null;
    packageDetails = json['package_details'] != null
        ? new PackageDetails.fromJson(json['package_details'])
        : null;
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    if (json['liked_user_images'] != null) {
      likedUserImages = <LikedUserImages>[];
      json['liked_user_images'].forEach((v) {
        likedUserImages!.add(new LikedUserImages.fromJson(v));
      });
    }
    avgStars = (json['avg_stars'] is int) 
    ? (json['avg_stars'] as int).toDouble() 
    : json['avg_stars'];
    //avgStars = json['avg_stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseDetails != null) {
      data['course_details'] = this.courseDetails!.toJson();
    }
    if (this.packageDetails != null) {
      data['package_details'] = this.packageDetails!.toJson();
    }
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    if (this.likedUserImages != null) {
      data['liked_user_images'] =
          this.likedUserImages!.map((v) => v.toJson()).toList();
    }
    data['avg_stars'] = this.avgStars;
    return data;
  }
}

class CourseDetails {
  String? courseListId;
  String? courseListName;
  String? courseListStart;
  String? courseListEnd;
  String? courseListType;
  String? courseListDuration;
  String? courseListImage;
  String? courseListPrice;
  String? courseListDiscount;
  String? batchListId;
  String? courseListStatus;

  CourseDetails(
      {this.courseListId,
      this.courseListName,
      this.courseListStart,
      this.courseListEnd,
      this.courseListType,
      this.courseListDuration,
      this.courseListImage,
      this.courseListPrice,
      this.courseListDiscount,
      this.batchListId,
      this.courseListStatus});

  CourseDetails.fromJson(Map<String, dynamic> json) {
    courseListId = json['course_list_id'];
    courseListName = json['course_list_name'];
    courseListStart = json['course_list_start'];
    courseListEnd = json['course_list_end'];
    courseListType = json['course_list_type'];
    courseListDuration = json['course_list_duration'];
    courseListImage = json['course_list_image'];
    courseListPrice = json['course_list_price'];
    courseListDiscount = json['course_list_discount'];
    batchListId = json['batch_list_id'];
    courseListStatus = json['course_list_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_list_id'] = this.courseListId;
    data['course_list_name'] = this.courseListName;
    data['course_list_start'] = this.courseListStart;
    data['course_list_end'] = this.courseListEnd;
    data['course_list_type'] = this.courseListType;
    data['course_list_duration'] = this.courseListDuration;
    data['course_list_image'] = this.courseListImage;
    data['course_list_price'] = this.courseListPrice;
    data['course_list_discount'] = this.courseListDiscount;
    data['batch_list_id'] = this.batchListId;
    data['course_list_status'] = this.courseListStatus;
    return data;
  }
}

class PackageDetails {
  Package? package;
  List<Classes>? classes;
  List<Subjects>? subjects;
  List<Chapters>? chapters;

  PackageDetails({this.package, this.classes, this.subjects, this.chapters});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    if (json['classes'] != null) {
      classes = <Classes>[];
      json['classes'].forEach((v) {
        classes!.add(new Classes.fromJson(v));
      });
    }
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? id;
  String? name;
  String? description;
  String? created;
  String? status;

  Package({this.id, this.name, this.description, this.created, this.status});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    created = json['created'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created'] = this.created;
    data['status'] = this.status;
    return data;
  }
}

class Classes {
  String? packageClassId;
  String? className;

  Classes({this.packageClassId, this.className});

  Classes.fromJson(Map<String, dynamic> json) {
    packageClassId = json['package_class_id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_class_id'] = this.packageClassId;
    data['class_name'] = this.className;
    return data;
  }
}

class Subjects {
  String? packageSubjectId;
  String? subjectName;

  Subjects({this.packageSubjectId, this.subjectName});

  Subjects.fromJson(Map<String, dynamic> json) {
    packageSubjectId = json['package_subject_id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_subject_id'] = this.packageSubjectId;
    data['subject_name'] = this.subjectName;
    return data;
  }
}

class Chapters {
  String? packageChapterId;
  String? chapterName;
  String? chapterId;

  Chapters({this.packageChapterId, this.chapterName, this.chapterId});

  Chapters.fromJson(Map<String, dynamic> json) {
    packageChapterId = json['package_chapter_id'];
    chapterName = json['chapter_name'];
    chapterId = json['chapter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_chapter_id'] = this.packageChapterId;
    data['chapter_name'] = this.chapterName;
    data['chapter_id'] = this.chapterId;
    return data;
  }
}

class LikedUserImages {
  String? userimage;
  String? username;

  LikedUserImages({this.userimage, this.username});

  LikedUserImages.fromJson(Map<String, dynamic> json) {
    userimage = json['userimage'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userimage'] = this.userimage;
    data['username'] = this.username;
    return data;
  }
}
