import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian_app/layers/core/assets.dart';
import 'package:tractian_app/layers/core/errors/failure.dart';
import 'package:tractian_app/layers/domain/models/asset_model.dart';
import 'package:tractian_app/layers/domain/models/component_model.dart';
import 'package:tractian_app/layers/domain/models/location_model.dart';
import 'package:tractian_app/layers/domain/models/node_model.dart';

class GetTreeUsecase {
  List<Node> fullTree = [];

  GetTreeUsecase();

  Either<Failure, List<Node>> getTree(
      {required List<Asset> assets,
      required List<Component> components,
      required List<Location> locations}) {
    try {
      Map<String, Node> nodeMap = {};

      // Mapeia todos os nós pelo ID
      assets.forEach(
        (asset) => nodeMap[asset.id!] = Node(
          id: asset.id!,
          parentId: asset.parentId,
          locationId: asset.locationId,
          name: asset.name!,
          type: "asset",
          sensorType: null,
          status: null,
        ),
      );
      components.forEach(
        (component) => nodeMap[component.id!] = Node(
          id: component.id!,
          parentId: component.parentId,
          locationId: component.locationId,
          name: component.name!,
          type: "component",
          sensorType: component.sensorType!,
          status: component.status!,
        ),
      );
      locations.forEach(
        (location) => nodeMap[location.id!] = Node(
          id: location.id!,
          parentId: location.parentId,
          locationId: null,
          name: location.name!,
          type: "location",
          sensorType: null,
          status: null,
        ),
      );

      // Adiciona os nós filhos aos seus respectivos pais
      nodeMap.values.forEach((node) {
        final parentId = node.parentId ?? node.locationId;
        if (parentId != null) {
          final parentNode = nodeMap[parentId]; // Obtém o nó pai a partir do map nodeMap
          if (parentNode != null) {
            parentNode.children ??= []; // Verifica se a lista de filhos é nula, se for nula a lista é inicializada
            parentNode.children!.add(node); // Adiciona o nó atual a lista de filhos do nó pai
          }
        }
      });

      // Encontra e retorna os nós raiz
      final tree = nodeMap.values
          .where((node) => node.parentId == null && node.locationId == null)
          .toList();

      // Ordenando para quem tem filhos vir primeiro
      tree.sort((a, b) {
         if ((a.children?.isNotEmpty ?? false) && !(b.children?.isNotEmpty ?? false)) {
            return -1;
          } else if (!(a.children?.isNotEmpty ?? false) && (b.children?.isNotEmpty ?? false)) {
            return 1;
          } else {
            return 0;
          }
      });

      fullTree = tree;

      return Right(tree);
    } catch (e) {
      return left(Failure(errorMessage: "Ops, algo deu errado!\nTente novamente mais tarde!"));
    }
    
  }

  List<Node> filterNodesByText({required List<Node> nodes, required String searchText}) {
    List<Node> filteredNodes = [];

    // Retorna a lista original caso o texto de pesquisa esteja vazio
    if (searchText.isEmpty || searchText == "") {
      return fullTree;
    }

    // Percorrendo a lista de nós
    for (var node in nodes) {
      // Verifica se o nó raiz atende ao critério de pesquisa, nesse caso está pesquisando por nome, status e sensorType
      bool nodeMatchesSearch = node.name.toLowerCase().contains(searchText.toLowerCase()) || (node.status != null && node.status!.toLowerCase().contains(searchText.toLowerCase())) || (node.sensorType != null && node.sensorType!.toLowerCase().contains(searchText.toLowerCase()));

      // Verifica se algum filho atende ao critério de pesquisa
      var filteredChildren = filterNodesByText(nodes: node.children ?? [], searchText: searchText);
      bool anyChildMatchesSearch = filteredChildren.isNotEmpty;

      // Adiciona o nó à lista filtrada se atender ao critério de pesquisa
      if (nodeMatchesSearch || anyChildMatchesSearch) {

        Node no = Node(
          id: node.id,
          parentId: node.parentId,
          locationId: node.locationId,
          name: node.name,
          type: node.type,
          sensorType: node.sensorType,
          status: node.status,
        );

        no.children = filteredChildren;

        filteredNodes.add(no);
      }
    }

    return filteredNodes;
  }

  // Essa função basicamente converte uma lista de Nodes em uma lista de TreeNode(é um widget que vem do package flutter_simple_treeview)
  List<TreeNode> convertToTreeNodes(List<Node> nodes) {
    bool isComponent = false;

    return nodes.map((node) {
      var icon;
      Widget componentIcon = const SizedBox.shrink();
      switch (node.type) {
        case "location":
          icon = SvgPicture.asset(Assets.locationIcon);
          break;
        case "asset":
          icon = SvgPicture.asset(Assets.assetIcon);
          break;
        case "component":
          isComponent = true;
          if (node.sensorType == "energy") {
            componentIcon = SvgPicture.asset(Assets.rayFullIcon);
          } else {
            componentIcon = SvgPicture.asset(Assets.vibrationIcon);
          }
          icon = Image.asset(Assets.componentIcon);
          break;
        default:
          break;
      }

      if (node.type == "location") {
        icon = SvgPicture.asset(Assets.locationIcon);
      }

      return TreeNode(
        // key: node.id,
        content: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0),
              child: Text("${node.name}", overflow: TextOverflow.ellipsis),
            ),
            isComponent == true ? componentIcon : const SizedBox.shrink(),
          ],
        ),
        children:
            node.children != null ? convertToTreeNodes(node.children!) : [],
      );
    }).toList();
  }
}
