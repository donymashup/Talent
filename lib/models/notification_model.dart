class NotificationModel {
  List<Notifications>? notifications;

  NotificationModel({this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? pushid;
  String? batchid;
  String? title;
  String? body;
  String? image;
  String? url;
  String? response;
  String? created;
  String? notify;

  Notifications(
      {this.id,
      this.pushid,
      this.batchid,
      this.title,
      this.body,
      this.image,
      this.url,
      this.response,
      this.created,
      this.notify});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pushid = json['pushid'];
    batchid = json['batchid'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    url = json['url'];
    response = json['response'];
    created = json['created'];
    notify = json['notify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pushid'] = this.pushid;
    data['batchid'] = this.batchid;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    data['url'] = this.url;
    data['response'] = this.response;
    data['created'] = this.created;
    data['notify'] = this.notify;
    return data;
  }
}
