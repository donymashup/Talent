class VideoModel {
  List<Videos>? videos;
  String? type;

  VideoModel({this.videos, this.type});

  VideoModel.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }
}

class Videos {
  String? batchVideosId;
  String? packageid;
  String? batchid;
  String? batchVideosStatus;
  String? videoId;
  String? videoName;
  String? videoThumbnail;
  String? videoVideoid;
  String? videoDuration;
  String? videoLink;
  String? videoHls;
  String? videoSource;
  String? videoDescription;
  int? viewDuration;
  int? totalDuration;
  int? seek;

  Videos(
      {this.batchVideosId,
      this.packageid,
      this.batchid,
      this.batchVideosStatus,
      this.videoId,
      this.videoName,
      this.videoThumbnail,
      this.videoVideoid,
      this.videoDuration,
      this.videoLink,
      this.videoHls,
      this.videoSource,
      this.videoDescription,
      this.viewDuration,
      this.totalDuration,
      this.seek});

  Videos.fromJson(Map<String, dynamic> json) {
    batchVideosId = json['batch_videos_id'];
    packageid = json['packageid'];
    batchid = json['batchid'];
    batchVideosStatus = json['batch_videos_status'];
    videoId = json['video_id'];
    videoName = json['video_name'];
    videoThumbnail = json['video_thumbnail'];
    videoVideoid = json['video_videoid'];
    videoDuration = json['video_duration'];
    videoLink = json['video_link'];
    videoHls = json['video_hls'];
    videoSource = json['video_source'];
    videoDescription = json['video_description'];
    viewDuration = json['view_duration'];
    totalDuration = json['total_duration'];
    seek = json['seek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_videos_id'] = this.batchVideosId;
    data['packageid'] = this.packageid;
    data['batchid'] = this.batchid;
    data['batch_videos_status'] = this.batchVideosStatus;
    data['video_id'] = this.videoId;
    data['video_name'] = this.videoName;
    data['video_thumbnail'] = this.videoThumbnail;
    data['video_videoid'] = this.videoVideoid;
    data['video_duration'] = this.videoDuration;
    data['video_link'] = this.videoLink;
    data['video_hls'] = this.videoHls;
    data['video_source'] = this.videoSource;
    data['video_description'] = this.videoDescription;
    data['view_duration'] = this.viewDuration;
    data['total_duration'] = this.totalDuration;
    data['seek'] = this.seek;
    return data;
  }
}