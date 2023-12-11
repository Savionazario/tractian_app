import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_app/layers/domain/models/node_model.dart';
import 'package:tractian_app/layers/domain/usecases/get_assets_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_components_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_locations_usecase.dart';
import 'package:tractian_app/layers/domain/usecases/get_tree_usecase.dart';
import 'package:tractian_app/layers/presentation/cubits/assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  final GetLocationsUsecase _getLocationsUsecase;
  final GetAssetsUsecase _getAssetsUsecase;
  final GetComponentsUsecase _getComponentsUsecase;
  final GetTreeUsecase _getTreeUseCase;

  List<Node> fullTree = [];

  AssetsCubit(
    this._getLocationsUsecase,
    this._getAssetsUsecase,
    this._getComponentsUsecase, this._getTreeUseCase,
  ) : super(AssetsLoadingState());

  loadTreeData({required String buttonId}) async {
    emit(AssetsLoadingState());

    final response = await _getLocationsUsecase(buttonId: buttonId);

    response.fold(
      (error) => emit(AssetsErrorState(errorMessage: "$error")),
      (locations) async {
        final responseAssets = await _getAssetsUsecase(buttonId: buttonId);

        responseAssets.fold(
          (error) => emit(AssetsErrorState(errorMessage: "$error")),
          (assets) async {
            final responseComponents = await _getComponentsUsecase(buttonId: buttonId);

            responseComponents.fold(
              (error) => emit(AssetsErrorState(errorMessage: "$error")),
              (components) {
                final responsetree = _getTreeUseCase.getTree(assets: assets, locations: locations, components: components);

                responsetree.fold(
                  (error) => emit(AssetsErrorState(errorMessage: "$error")), 
                  (tree) {
                    fullTree = tree;
                    final treeNodes = _getTreeUseCase.convertToTreeNodes(tree);
                    emit(AssetsSucessfulState(treeNodes: treeNodes));
                  },
                );
              } 
            );
          },
        );
      },
    );
  }

  loadFilteredTree({required String seachText}){
    try {
      emit(AssetsLoadingState());

      final filteredNodes = _getTreeUseCase.filterNodesByText(nodes: fullTree, searchText: seachText);
      final filteredTreeNodes = _getTreeUseCase.convertToTreeNodes(filteredNodes);

      if(filteredTreeNodes.isEmpty){
        emit(AssetsEmptyListState(emptyMessage: "Nenhum Component, Asset ou Location foram encontrados!"));
      }else{
        emit(AssetsSucessfulState(treeNodes: filteredTreeNodes));
      }
    } catch (e) {
      emit(AssetsErrorState(errorMessage: "Ops, algo deu errado!\nTente novamente mais tarde!"));
    }
    
  }
}
