import 'package:onlygym/models/photos_model.dart';

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? dateBirth;
  String? contacts;
  String? goal;
  List<PhotosModel>? photos;
  List<ParametersModel>? parameters;

  UserModel(
      {this.id,
        this.email,
        this.firstName,
        this.lastName,
        this.dateBirth,
        this.contacts,
        this.goal,
        this.photos,
        this.parameters});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateBirth = json['date_birth'];
    contacts = json['contacts'];
    goal = json['goal'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos!.add(PhotosModel.fromJson(v));
      });
    }
    if (json['parameters'] != null) {
      parameters = [];
      json['parameters'].forEach((v) {
        parameters!.add(ParametersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['email'] = email;
    json['first_name'] = firstName;
    json['last_name'] = lastName;
    json['date_birth'] = dateBirth;
    json['contacts'] = contacts;
    json['goal'] = goal;
    if (photos != null) {
      json['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    if (parameters != null) {
      json['parameters'] = parameters!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ParametersModel {
  String? name;
  double? value;
  String? unit;

  ParametersModel({this.name, this.value, this.unit});

  ParametersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['name'] = name;
    json['value'] = value;
    json['unit'] = unit;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
