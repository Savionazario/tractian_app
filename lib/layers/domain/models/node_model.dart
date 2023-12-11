class Node {
  final String id;
  final String? parentId;
  final String? locationId;
  final String name;
  final String type;
  final String? sensorType;
  final String? status;
  List<Node>? children;

  Node({required this.id, required this.parentId, required this.locationId, required this.name, required this.type, required this.sensorType, required this.status});
}