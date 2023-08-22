class MuscleGroupsModel {
  List<MuscleGroupsModel>? muscleGroups;

  MuscleGroupsModel({this.muscleGroups});

  MuscleGroupsModel.fromJson(Map<String, dynamic> json) {
    if (json['muscle_groups'] != null) {
      muscleGroups = [];
      json['muscle_groups'].forEach((v) {
        muscleGroups!.add(MuscleGroupsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (muscleGroups != null) {
      json['muscle_groups'] = muscleGroups!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
class MuscleGroupModel {
  int? id;
  String? name;

  MuscleGroupModel({this.id, this.name});

  MuscleGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}