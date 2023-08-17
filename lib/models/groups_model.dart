class GroupsModel {
  int? id;
  String? name;
  List<dynamic>? values;

  GroupsModel({this.id, this.name, this.values});

  GroupsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['values'] != null) {
      values = [];
      json['values'].forEach((v) {
       // values!.add(dynamic.fromJson(v));
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
