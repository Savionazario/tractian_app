import 'package:dartz/dartz.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/data/datasources/local/local_datasource.dart';
import 'package:tractian_app/layers/domain/models/asset_model.dart';
import 'package:tractian_app/layers/domain/models/component_model.dart';
import 'package:tractian_app/layers/domain/models/location_model.dart';

abstract class AssetsRepository{
  final LocalDatasource _localDatasource;
  AssetsRepository(this._localDatasource);

  Future<Either<Failure, List<Location>>> getLocations({required String buttonId});
  Future<Either<Failure, List<Asset>>> getAssets({required String buttonId});
  Future<Either<Failure, List<Component>>> getComponents({required String buttonId});
}