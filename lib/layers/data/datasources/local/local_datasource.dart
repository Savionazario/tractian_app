abstract class LocalDatasource{
  Future<dynamic> getLocations({required String buttonId});
  Future<dynamic> getAssets({required String buttonId});
  Future<dynamic> getComponents({required String buttonId});
}