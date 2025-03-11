class LiveModel {
  List<Ongoing>? ongoing;
  List<Upcoming>? upcoming;
  List<Completed>? completed;

  LiveModel({this.ongoing, this.upcoming, this.completed});

  LiveModel.fromJson(Map<String, dynamic> json) {
    if (json['ongoing'] != null) {
      ongoing = (json['ongoing'] as List).map((v) => Ongoing.fromJson(v)).toList();
    }
    if (json['upcoming'] != null) {
      upcoming = (json['upcoming'] as List).map((v) => Upcoming.fromJson(v)).toList();
    }
    if (json['completed'] != null) {
      completed = (json['completed'] as List).map((v) => Completed.fromJson(v)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (ongoing != null) 'ongoing': ongoing!.map((v) => v.toJson()).toList(),
      if (upcoming != null) 'upcoming': upcoming!.map((v) => v.toJson()).toList(),
      if (completed != null) 'completed': completed!.map((v) => v.toJson()).toList(),
    };
  }
}

class Ongoing {
  String? meetListId;
  String? title;
  String? meetingUid;
  String? description;
  String? start;
  String? end;
  String? faculty;
  String? avatar;
  String? alias;
  String? password;
  String? url;
  String? type;
  String? videoid;
  String? hls;
  String? source;

  Ongoing({
    this.meetListId,
    this.title,
    this.meetingUid,
    this.description,
    this.start,
    this.end,
    this.faculty,
    this.avatar,
    this.alias,
    this.password,
    this.url,
    this.type,
    this.videoid,
    this.hls,
    this.source,
  });

  Ongoing.fromJson(Map<String, dynamic> json)
      : meetListId = json['meet_list_id'],
        title = json['title'],
        meetingUid = json['meeting_uid'],
        description = json['description'],
        start = json['start'],
        end = json['end'],
        faculty = json['faculty'],
        avatar = json['avatar'],
        alias = json['alias'],
        password = json['password'],
        url = json['url'],
        type = json['type'],
        videoid = json['videoid'],
        hls = json['hls'],
        source = json['source'];

  Map<String, dynamic> toJson() {
    return {
      'meet_list_id': meetListId,
      'title': title,
      'meeting_uid': meetingUid,
      'description': description,
      'start': start,
      'end': end,
      'faculty': faculty,
      'avatar': avatar,
      'alias': alias,
      'password': password,
      'url': url,
      'type': type,
      'videoid': videoid,
      'hls': hls,
      'source': source,
    };
  }
}

class Upcoming{
  String? name;
  String? title;
  String? start;
  String? end;
  String? avatar;
  String? faculty;

  Upcoming.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        title = json['title'],
        start = json['start'],
        end = json['end'],
        avatar = json['avatar'],
        faculty = json['faculty'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'start': start,
      'end': end,
      'avatar': avatar,
      "faculty": faculty,
    };
  }
  
}

class Completed {
  String? name;
  List<Months>? months;

  Completed({this.name, this.months});

  Completed.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        months = json['months'] != null
            ? (json['months'] as List).map((v) => Months.fromJson(v)).toList()
            : null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (months != null) 'months': months!.map((v) => v.toJson()).toList(),
    };
  }
}

class Months {
  String? name;
  List<Data>? data;

  Months({this.name, this.data});

  Months.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        data = json['data'] != null
            ? (json['data'] as List).map((v) => Data.fromJson(v)).toList()
            : null;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (data != null) 'data': data!.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  String? meetListId;
  String? title;
  String? meetingUid;
  String? description;
  String? start;
  String? end;
  String? faculty;
  String? avatar;
  String? alias;
  String? password;
  String? url;
  String? type;
  String? videoid;
  String? hls;
  String? source;

  Data({
    this.meetListId,
    this.title,
    this.meetingUid,
    this.description,
    this.start,
    this.end,
    this.faculty,
    this.avatar,
    this.alias,
    this.password,
    this.url,
    this.type,
    this.videoid,
    this.hls,
    this.source,
  });

  Data.fromJson(Map<String, dynamic> json)
      : meetListId = json['meet_list_id'],
        title = json['title'],
        meetingUid = json['meeting_uid'],
        description = json['description'],
        start = json['start'],
        end = json['end'],
        faculty = json['faculty'],
        avatar = json['avatar'],
        alias = json['alias'],
        password = json['password'],
        url = json['url'],
        type = json['type'],
        videoid = json['videoid'],
        hls = json['hls'],
        source = json['source'];

  Map<String, dynamic> toJson() {
    return {
      'meet_list_id': meetListId,
      'title': title,
      'meeting_uid': meetingUid,
      'description': description,
      'start': start,
      'end': end,
      'faculty': faculty,
      'avatar': avatar,
      'alias': alias,
      'password': password,
      'url': url,
      'type': type,
      'videoid': videoid,
      'hls': hls,
      'source': source,
    };
  }
}
