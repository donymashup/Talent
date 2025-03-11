class TimeLineModel {
  List<Timeline>? timeline;

  TimeLineModel({this.timeline});

  TimeLineModel.fromJson(Map<String, dynamic> json) {
    if (json['timeline'] != null) {
      timeline = <Timeline>[];
      json['timeline'].forEach((v) {
        timeline!.add(new Timeline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timeline != null) {
      data['timeline'] = this.timeline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Timeline {
  String? type;
  String? time;
  String? id;
  String? name;
  String? thumbnail;
  String? link;
  String? description;

  Timeline(
      {this.type,
      this.time,
      this.id,
      this.name,
      this.thumbnail,
      this.link,
      this.description});

  Timeline.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    time = json['time'];
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    link = json['link'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['time'] = this.time;
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['description'] = this.description;
    return data;
  }
}