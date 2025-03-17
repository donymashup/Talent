class MiscellaneousFoldersModel {
  String? title;
  String? type;
  String? thumbnail;
  String? id;
  String? link;
  String? duration;
  List<MiscellaneousFoldersModel>? list;

  MiscellaneousFoldersModel({
    this.title,
    this.type,
    this.thumbnail,
    this.id,
    this.link,
    this.duration,
    this.list,
  });

  MiscellaneousFoldersModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    thumbnail = json['thumbnail'];
    id = json['id'];
    link = json['link'];
    duration = json['duration'];
    if (json['list'] != null) {
      list = <MiscellaneousFoldersModel>[];
      json['list'].forEach((v) {
        list!.add(MiscellaneousFoldersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['thumbnail'] = thumbnail;
    data['id'] = id;
    data['link'] = link;
    data['duration'] = duration;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class MiscellaneousFoldersModel {
//   String? title;
//   String? type;
//   String? thumbnail;
//   String? id;
//   String? link;
//   String? duration;
//   List<MiscellaneousFoldersModel>? list;

//   MiscellaneousFoldersModel({
//     this.title,
//     this.type,
//     this.thumbnail,
//     this.id,
//     this.link,
//     this.duration,
//     this.list,
//   });

//   /// ✅ JSON to Model
//   factory MiscellaneousFoldersModel.fromJson(Map<String, dynamic> json) {
//     return MiscellaneousFoldersModel(
//       title: json['title'] as String?,
//       type: json['type'] as String?,
//       thumbnail: json['thumbnail'] as String?,
//       id: json['id'] as String?,
//       link: json['link'] as String?,
//       duration: json['duration'] as String?,
//       list: (json['list'] as List<dynamic>?)
//           ?.map((item) => MiscellaneousFoldersModel.fromJson(item))
//           .toList(), // ✅ Safe null check, no need for extra if condition
//     );
//   }

//   /// ✅ Model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'type': type,
//       'thumbnail': thumbnail,
//       'id': id,
//       'link': link,
//       'duration': duration,
//       'list': list?.map((item) => item.toJson()).toList(), // ✅ Simplified
//     };
//   }
// }
