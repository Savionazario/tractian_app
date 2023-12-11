class Asset {
  String? name;
  String? locationId;
  String? parentId;
  String? id;

  Asset({this.name, this.locationId, this.parentId, this.id});

  Asset.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    locationId = json['locationId'];
    parentId = json['parentId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['locationId'] = this.locationId;
    data['parentId'] = this.parentId;
    data['id'] = this.id;
    return data;
  }
}