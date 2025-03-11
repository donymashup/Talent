class ChapterListModel {
  List<Chapters>? chapters;
  String? type;

  ChapterListModel({this.chapters, this.type});

  ChapterListModel.fromJson(Map<String, dynamic> json) {
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(new Chapters.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chapters != null) {
      data['chapters'] = this.chapters!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Chapters {
  String? packageChapterId;
  String? packageid;
  String? packageChapterStatus;
  String? chaptersName;
  String? chaptersId;
  String? chaptersDescription;
  String? chaptersImage;
  int? cpi;

  Chapters(
      {this.packageChapterId,
      this.packageid,
      this.packageChapterStatus,
      this.chaptersName,
      this.chaptersId,
      this.chaptersDescription,
      this.chaptersImage,
      this.cpi});

  Chapters.fromJson(Map<String, dynamic> json) {
    packageChapterId = json['package_chapter_id'];
    packageid = json['packageid'];
    packageChapterStatus = json['package_chapter_status'];
    chaptersName = json['chapters_name'];
    chaptersId = json['chapters_id'];
    chaptersDescription = json['chapters_description'];
    chaptersImage = json['chapters_image'];
    cpi = json['cpi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_chapter_id'] = this.packageChapterId;
    data['packageid'] = this.packageid;
    data['package_chapter_status'] = this.packageChapterStatus;
    data['chapters_name'] = this.chaptersName;
    data['chapters_id'] = this.chaptersId;
    data['chapters_description'] = this.chaptersDescription;
    data['chapters_image'] = this.chaptersImage;
    data['cpi'] = this.cpi;
    return data;
  }
}