import 'package:dartz/dartz.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/data/datasources/local/local_datasource.dart';
import 'package:tractian_app/layers/domain/models/asset_model.dart';
import 'package:tractian_app/layers/domain/models/component_model.dart';
import 'package:tractian_app/layers/domain/models/location_model.dart';
import 'package:tractian_app/layers/domain/repositories/assets_repository.dart';


class AssetsRepositoryImpl implements AssetsRepository{
  final LocalDatasource _localDatasource;
  AssetsRepositoryImpl(this._localDatasource);
  
  @override
  Future<Either<Failure, List<Asset>>> getAssets({required String buttonId}) async {
    try {
      List jsonList = await _localDatasource.getAssets(buttonId: buttonId);

      List<Asset> assetList = [];

      for(int i = 0; i < jsonList.length; i++){
        
        if((jsonList[i]["sensorType"] == null)){
          assetList.add(Asset.fromJson(jsonList[i]));
        }
      }

      return Right(assetList);
    } catch (e) {
      return Left(Failure(errorMessage: "Ops, algo deu errado!\nTente novamente mais tarde!"));
    }
  }

  @override
  Future<Either<Failure, List<Component>>> getComponents({required String buttonId}) async{
    try {
      List jsonList = await _localDatasource.getComponents(buttonId: buttonId);

      List<Component> componentsList = [];

      for(int i = 0; i < jsonList.length; i++){
        
        if((jsonList[i]["sensorType"] != null)){
          componentsList.add(Component.fromJson(jsonList[i]));
        }
      }

      return Right(componentsList);
    } catch (e) {
      return Left(Failure(errorMessage: "Ops, algo deu errado!\nTente novamente mais tarde!"));
    }
  }

  @override
  Future<Either<Failure, List<Location>>> getLocations({required String buttonId}) async {
    try {
      List jsonList = await _localDatasource.getLocations(buttonId: buttonId);

      List<Location> locationList = jsonList.map((location) => Location.fromJson(location)).toList();

      return Right(locationList);
    } catch (e) {
      return Left(Failure(errorMessage: "Ops, algo deu errado!\nTente novamente mais tarde!"));
    }
    
  }

}