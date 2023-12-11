import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tractian_app/layers/data/datasources/local/local_datasource.dart';

class LocalDatasourceImpl implements LocalDatasource{

  @override
  Future<dynamic> getAssets({required String buttonId}) async {
    final String response = await rootBundle.loadString('assets/json/$buttonId/assets.json');
    final parsedJson = await json.decode(response);

    return parsedJson;
  }

  @override
  Future<dynamic> getComponents({required String buttonId}) async {
    final String response = await rootBundle.loadString('assets/json/$buttonId/assets.json');
    final parsedJson = await json.decode(response);

    return parsedJson;
  }
  
  @override
  Future<dynamic> getLocations({required String buttonId}) async {
    final String response = await rootBundle.loadString('assets/json/$buttonId/locations.json');
    final parsedJson = await json.decode(response);

    return parsedJson;
  }

}