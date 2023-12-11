import 'package:dartz/dartz.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/domain/models/location_model.dart';
import 'package:tractian_app/layers/domain/repositories/assets_repository.dart';

class GetLocationsUsecase{
  final AssetsRepository _assetsRepository;
  GetLocationsUsecase(this._assetsRepository);

  Future<Either<Failure, List<Location>>> call({required String buttonId}) async {
    return _assetsRepository.getLocations(buttonId: buttonId);
  }
}