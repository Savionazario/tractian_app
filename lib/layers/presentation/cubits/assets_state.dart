import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

abstract class AssetsState{}

class AssetsInitialState extends AssetsState{}

class AssetsLoadingState extends AssetsState{}

class AssetsSucessfulState extends AssetsState{
  final List<TreeNode> treeNodes;

  AssetsSucessfulState({required this.treeNodes,});
}

class AssetsEmptyListState extends AssetsState{
  final String emptyMessage;

  AssetsEmptyListState({required this.emptyMessage,});
}

class AssetsErrorState extends AssetsState{
  final String errorMessage;

  AssetsErrorState({required this.errorMessage});
}