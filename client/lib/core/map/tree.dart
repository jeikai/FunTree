import 'package:flutter/cupertino.dart';
import 'package:funtree/core/inventory/tree.dart';
import 'package:funtree/core/utils/size_utils.dart';

import '../utils/image_constant.dart';

class TreeObject extends ChangeNotifier {
  double _x;
  double _y;
  final double width;
  final double height;
  final String uuid;

  String get imagePath {
    var temp = ImageConstant.imgTree;
    treeList.forEach((element) {
      if (element.uuid != uuid) return;
      temp = element.imagePath;
      return;
    });
    return temp;
  }

  set x(double x) {
    _x = x;
    notifyListeners();
  }

  double get x => _x;

  set y(double y) {
    _y = y;
    notifyListeners();
  }

  double get y => _y;

  TreeObject(
      {required double x,
      required double y,
      double? width,
      double? height,
      required this.uuid})
      : width = width ?? 20.h,
        height = height ?? 20.h,
        _x = x,
        _y = y;

  @override
  String toString() {
    return 'TreeObject{x: $x, y: $y, width: $width, height: $height, uuid: $uuid}';
  }

  static TreeObject fromJson(element) {
    return TreeObject(
        x: element['x'],
        y: element['y'],
        width: element['width'],
        height: element['height'],
        uuid: element['uuid']);
  }
}
