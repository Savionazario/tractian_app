import 'package:get_it/get_it.dart';
import 'package:tractian_app/layers/data/datasources/local/local_datasource.dart';
import 'package:tractian_app/layers/data/datasources/local/local_datasource_impl.dart';
import 'package:tractian_app/layers/data/repositories/assets_repository_impl.dart';
import 'package:tractian_app/layers/domain/repositories/assets_repository.dart';
import 'package:tractian_app/layers/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_components_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_tree_usecase.dart';
import 'package:tractian_app/layers/presentation/cubits/assets_cubit.dart';

class InjectionContainer {
  static void init() {
    GetIt getIt = GetIt.instance;

    //* datasouces
    getIt.registerLazySingleton<LocalDatasource>(
      () => LocalDatasourceImpl(),
    );

    //* repositories
    getIt.registerLazySingleton<AssetsRepository>(
      () => AssetsRepositoryImpl(getIt()),
    );

    //* usecases
    getIt.registerLazySingleton<GetLocationsUsecase>(
      () => GetLocationsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetAssetsUsecase>(
      () => GetAssetsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetComponentsUsecase>(
      () => GetComponentsUsecase(getIt()),
    );
    getIt.registerLazySingleton<GetTreeUsecase>(
      () => GetTreeUsecase(),
    );

    //* cubits
    getIt.registerLazySingleton<AssetsCubit>(
      () => AssetsCubit(getIt(), getIt(), getIt(), getIt()),
    );
  }
}
