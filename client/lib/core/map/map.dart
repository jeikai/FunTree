import 'package:flutter/cupertino.dart';
import 'package:funtree/core/map/tree.dart';

class TreeMap extends ChangeNotifier {
  String _mapName;
  List<TreeObject> _treeObjects = [];

  List<TreeObject> get treeObjects => List.unmodifiable(_treeObjects);

  addTreeObject(TreeObject treeObject) {
    _treeObjects.add(treeObject);
    treeObject.addListener(() {
      notifyListeners();
    });
    notifyListeners();
  }

  String get mapName => _mapName;
  set mapName(String mapName) {
    _mapName = mapName;
    notifyListeners();
  }

  TreeMap({String mapName = "New Map"}): _mapName = mapName;

  static fromJson(e) {
    TreeMap temp = TreeMap(mapName: e['mapName']);
    e['treeObjects'].forEach((element) {
      temp.addTreeObject(TreeObject.fromJson(element));
    });
    return temp;
  }
}

List<TreeMap> maps = [];
