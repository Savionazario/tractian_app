class Location {
  String? name;
  String? parentId;
  String? id;

  Location({this.name, this.parentId, this.id});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parentId = json['parentId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['id'] = this.id;
    return data;
  }
}