import 'groups_model.dart';

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
