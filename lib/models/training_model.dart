class TrainingModel {
  List<String>? dateList;
  List<TrainingListModel>? trainingList;

  TrainingModel({this.dateList, this.trainingList});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    if (json['date_list'] != null) {
      dateList = [];
      json['date_list'].forEach((v) {
        dateList!.add(v);
      });
    }
    if (json['training_list'] != null) {
      trainingList = [];
      json['training_list'].forEach((v) {
        trainingList!.add(TrainingListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['date_list'] = dateList;
    if (trainingList != null) {
      json['training_list'] = trainingList!.map((v) => v.toJson()).toList();
    }
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
class TrainingListModel {
  int? id;
  String? name;
  String? time;

  TrainingListModel({this.id, this.name, this.time});

  TrainingListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['name'] = name;
    json['time'] = time;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}