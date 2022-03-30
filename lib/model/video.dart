class Video {
  String? id;
  String? video;

  Video({this.id, this.video});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
  }
}
