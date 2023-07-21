class PhotosModel {
  String? url;
  bool? isAvatar;
  String? pubDate;

  PhotosModel({this.url, this.isAvatar, this.pubDate});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    isAvatar = json['is_avatar'];
    pubDate = json['pub_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['url'] = url;
    json['is_avatar'] = isAvatar;
    json['pub_date'] = pubDate;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}