import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class TreeWidget extends StatefulWidget {

  final List<TreeNode> treeNodes;
  const TreeWidget({Key? key, required this.treeNodes}) : super(key: key);

  @override
  _TreeWidgetState createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  final TreeController _treeController = TreeController();

  @override
  void initState() {
    _treeController.collapseAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TreeView(
        indent: 10,
        nodes: widget.treeNodes,
        treeController: _treeController,
      ),
    );
  }
}
