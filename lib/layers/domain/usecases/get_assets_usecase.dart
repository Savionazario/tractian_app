import 'package:dartz/dartz.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/domain/models/asset_model.dart';
import 'package:tractian_app/layers/domain/repositories/assets_repository.dart';

class GetAssetsUsecase{
  final AssetsRepository _assetsRepository;
  GetAssetsUsecase(this._assetsRepository);

  Future<Either<Failure, List<Asset>>> call({required String buttonId}) async {
    return _assetsRepository.getAssets(buttonId: buttonId);
  }
}