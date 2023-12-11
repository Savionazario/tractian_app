import 'package:dartz/dartz.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/domain/models/component_model.dart';
import 'package:tractian_app/layers/domain/repositories/assets_repository.dart';

class GetComponentsUsecase{
  final AssetsRepository _assetsRepository;
  GetComponentsUsecase(this._assetsRepository);

  Future<Either<Failure, List<Component>>> call({required String buttonId}) async {
    return _assetsRepository.getComponents(buttonId: buttonId);
  }
}