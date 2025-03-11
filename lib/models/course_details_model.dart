class CourseDetailsModel {
  String? description;
  String? type;
  Details? details;
  List<Review>? reviews;
  List<Chapters>? chapters;

  CourseDetailsModel(
      {this.description, this.type, this.details, this.reviews, this.chapters});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    type = json['type'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['type'] = type;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
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

  Details(
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

  Details.fromJson(Map<String, dynamic> json) {
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

class Chapters {
  String? chapId;
  String? chapName;
  String? chapImage;
  String? subjectName;
  String? className;
  Contents? contents;

  Chapters(
      {this.chapId,
      this.chapName,
      this.chapImage,
      this.subjectName,
      this.className,
      this.contents});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapId = json['chap_id'];
    chapName = json['chap_name'];
    chapImage = json['chap_image'];
    subjectName = json['subject_name'];
    className = json['class_name'];
    contents =
        json['contents'] != null ? Contents.fromJson(json['contents']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chap_id'] = chapId;
    data['chap_name'] = chapName;
    data['chap_image'] = chapImage;
    data['subject_name'] = subjectName;
    data['class_name'] = className;
    if (contents != null) {
      data['contents'] = contents!.toJson();
    }
    return data;
  }
}

class Contents {
  List<ContentItem>? videos;
  List<ContentItem>? pdf;
  List<ContentItem>? test;

  Contents({this.videos, this.pdf, this.test});

  Contents.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <ContentItem>[];
      json['videos'].forEach((v) {
        videos!.add(ContentItem.fromJson(v));
      });
    }
    if (json['pdf'] != null) {
      pdf = <ContentItem>[];
      json['pdf'].forEach((v) {
        pdf!.add(ContentItem.fromJson(v));
      });
    }
    if (json['test'] != null) {
      test = <ContentItem>[];
      json['test'].forEach((v) {
        test!.add(ContentItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    if (pdf != null) {
      data['pdf'] = pdf!.map((v) => v.toJson()).toList();
    }
    if (test != null) {
      data['test'] = test!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentItem {
  String? contentId;
  String? contentName;
  String? contentType;
  String? status;
  String? link;

  ContentItem(
      {this.contentId,
      this.contentName,
      this.contentType,
      this.status,
      this.link});

  ContentItem.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentName = json['content_name'];
    contentType = json['content_type'];
    status = json['status'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['content_name'] = contentName;
    data['content_type'] = contentType;
    data['status'] = status;
    data['link'] = link;
    return data;
  }
}

class Review {
  String? name;
  String? rating;
  String? review;
  String? image;

  Review({this.name, this.rating, this.review, this.image});

  Review.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    review = json['review'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['rating'] = rating;
    data['review'] = review;
    data['image'] = image;
    return data;
  }
}
