class Component {
  String? name;
  String? parentId;
  String? sensorType;
  String? status;
  String? locationId;
  String? id;

  Component(
      {this.name,
      this.parentId,
      this.sensorType,
      this.status,
      this.locationId,
      this.id});

  Component.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parentId = json['parentId'];
    sensorType = json['sensorType'];
    status = json['status'];
    locationId = json['locationId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['sensorType'] = this.sensorType;
    data['status'] = this.status;
    data['locationId'] = this.locationId;
    data['id'] = this.id;
    return data;
  }
}