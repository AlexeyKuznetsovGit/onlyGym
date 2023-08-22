class ExerciseModel {
  int? id;
  String? name;
  List<GroupsModel>? groups;

  ExerciseModel({this.id, this.name, this.groups});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups!.add(GroupsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    if (groups != null) {
      json['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
class GroupsModel {
  int? id;
  String? name;
  List<ValuesModel>? values;

  GroupsModel({this.id, this.name, this.values});

  GroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
        values!.add(ValuesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    if (values != null) {
      json['values'] = values!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
class ValuesModel {
  int? id;
  int? athleteId;
  String? name;
  int? typeId;
  String? description;
  bool? isCover;
  List<PhotosModel>? photos;

  ValuesModel(
      {this.id,
        this.athleteId,
        this.name,
        this.typeId,
        this.description,
        this.isCover,
        this.photos});

  ValuesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    athleteId = json['athlete_id'];
    name = json['name'];
    typeId = json['type_id'];
    description = json['description'];
    isCover = json['is_cover'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos!.add(PhotosModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['athlete_id'] = athleteId;
    json['name'] = name;
    json['type_id'] = typeId;
    json['description'] = description;
    json['is_cover'] = isCover;
    if (photos != null) {
      json['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
class PhotosModel {
  int? id;
  String? url;

  PhotosModel({this.id, this.url});

  PhotosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['url'] = url;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
