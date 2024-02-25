import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/core/inventory/tree.dart';
import 'package:funtree/core/map/map.dart';
import 'package:funtree/core/map/tree.dart';
import 'package:funtree/core/utils/size_utils.dart';
import 'package:funtree/theme/theme_helper.dart';

int mapIndex = 0;

class MapEditorScreen extends StatefulWidget {
  const MapEditorScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MapEditorScreenState();
}

class MapEditorScreenState extends State<MapEditorScreen> {
  int? _index = null;


  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: WillPopScope(
        child: SizedBox(
          height: 800.v,
          child: ColoredBox(
            color: Colors.white,
            child: Stack(
              children: [
                ValueListenableBuilder(
                  valueListenable: _isPlaced,
                  builder: (BuildContext context, bool? value, Widget? child) {
                    print("rebuilt 1");
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: METreeSelector(
                        key: Key('slider'),
                        onChoose: _onChoose,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _isPlaced,
                  builder: (BuildContext context, bool? value, Widget? child) {
                    print("rebuilt 1");
                    return Align(
                      alignment: Alignment.center,
                      child: DottedBorder(
                        color: appTheme.green300Bc,
                        strokeWidth: 2.h,
                        borderType: BorderType.RRect,
                        strokeCap: StrokeCap.round,
                        dashPattern: [10, 10],
                        radius: Radius.circular(20.h),
                        child: SizedBox(
                          height: 400.v + 20.adaptSize,
                          width: 300.h + 20.adaptSize,
                          child: Center(
                            child: MainEditor(
                              index: _index,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: MENavBar(),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, AppRoutes.homescreenScreen);
          return false;
        },
      ),
    ));
  }

  void _onChoose(int index) {
    print("choose: $index");
    _index = index;
    _isPlaced.value = false;
  }
}

class MENavBar extends StatefulWidget {
  const MENavBar({super.key});

  @override
  State<MENavBar> createState() => _MENavBarState();
}

final _menavbar_radius = Radius.circular(30.adaptSize);

class _MENavBarState extends State<MENavBar> {
  TextEditingController? _controller;
  bool _isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.v,
      decoration: BoxDecoration(
          color: appTheme.green100,
          borderRadius: BorderRadius.only(
              bottomLeft: _menavbar_radius, bottomRight: _menavbar_radius)),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: new Icon(
                        Icons.arrow_back,
                        color: appTheme.green60001,
                        size: 35.adaptSize,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Text("Map Editor",
                        style: CustomTextStyles.headlineLargeBluegray700),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                  flex: 1,
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Expanded(
                flex: 2,
                child: Container(
                  width: 360.h - 15.adaptSize,
                  height: 80.v,
                  padding: EdgeInsets.all(20.adaptSize),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(_menavbar_radius)),
                  child: Center(
                    child: _isEditMode
                        ? _buildEditMode()
                        : _buildNormalNameTitle(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  onHold() {
    setState(() {
      _isEditMode = true;
    });
  }

  onSubmitted(String newName) {
    maps[mapIndex].mapName = newName;
    setState(() {
      _isEditMode = false;
    });
  }

  _buildNormalNameTitle() {
    return GestureDetector(
      onLongPress: onHold,
      child: Text(maps[mapIndex].mapName,
          style: CustomTextStyles.headlineLargeGreen60001),
    );
  }

  _buildEditMode() {
    _controller = new TextEditingController(text: maps[mapIndex].mapName);
    return TextField(
      maxLength: 20,
      onSubmitted: onSubmitted,
      controller: _controller,
      style: CustomTextStyles.headlineLargeGreen60001,
    );
  }
}

class METreeSelector extends StatefulWidget {
  final Function(int) onChoose;

  const METreeSelector({Key? key, required this.onChoose}) : super(key: key);

  @override
  State<StatefulWidget> createState() => METreeSelectorState();
}

class METreeSelectorState extends State<METreeSelector> {
  @override
  Widget build(BuildContext context) {
    List<Tree> list = [];
    for (int i = 0; i < treeList.length; i++) {
      if (isPlaced(i)) continue;
      list.add(treeList[i]);
    }
    return Container(
        color: appTheme.green100,
        child: CarouselSlider.builder(
          options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              height: 145.v,
              enlargeFactor: 0.3),
          itemCount: (list.length / 2).round(),
          itemBuilder: (context, index, realIdx) {
            final int first = index * 2;
            final int second = first + 1;
            return Row(
              children: [first, second].map((idx) {
                if (idx >= list.length) {
                  return Expanded(flex: 1,
                    child: Center(
                        child: Container(
                          height: 100.v,
                          width: 100.v,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: appTheme.green60001, width: 1),
                              color: appTheme.gray300.withAlpha(100),
                              backgroundBlendMode: BlendMode.multiply
                          ),
                          child: Center(
                            child: Icon(Icons.add,
                              color: appTheme.blueGray700,
                              size: 25.adaptSize,
                            ),
                          ),
                        )
                    ),
                  );
                }
                return Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                          flex: 10,
                          child: CustomImageView(
                            fit: BoxFit.fill,
                            radius: BorderRadius.all(Radius.circular(50.h)),
                            border: Border.all(
                                color: appTheme.green60001, width: 1),
                            alignment: Alignment.bottomCenter,
                            height: 100.v,
                            width: 100.v,
                            imagePath: list[idx].imagePath,
                            onTap: () => widget.onChoose(idx),
                          )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('${list[idx].name}'),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}

class MainEditor extends StatefulWidget {
  final int? index;
  final (double, double, double, double) rect = (30.h, 215.v, 330.h, 615.v);

  MainEditor({Key? key, required this.index}) : super(key: key);

  @override
  State<MainEditor> createState() => _MainEditorState();
}

ValueNotifier<bool?> _isPlaced = ValueNotifier(null);

class _MainEditorState extends State<MainEditor> {
  int? get index => _isPlaced.value == null || _isPlaced.value! ? null : widget.index;

  bool _isDragging = false;
  TreeObject? draggingObject;

  @override
  Widget build(BuildContext context) {
    print('build main editor: _isPlaced = $_isPlaced');
    return SizedBox(
      height: 400.v,
      width: 300.h,
      child: Builder(
        builder: (BuildContext context) {
          final Widget child = _buildMap(context);
          return index == null
              ? child
              : GestureDetector(
                  child: child,
                  onTapDown: onPlaceTree,
                );
        },
      ),
    );
  }

  onPlaceTree(TapDownDetails details) {
    setPlaced(index!);
    setState(() {
      Offset pos = details.localPosition;
      TreeObject object =
          TreeObject(x: pos.dx, y: pos.dy, uuid: treeList[index!].uuid);
      maps[mapIndex].addTreeObject(object);
      _isPlaced.value = true;
    });
  }

  _buildMap(BuildContext context) {
    TreeMap map = maps[mapIndex];
    return Stack(
        key: Key("editor-map"),
        alignment: Alignment.topRight,
        children: [
          CustomImageView(
              imagePath: ImageConstant.imgBedroom,
              height: 400.v,
              width: 300.h,
              alignment: Alignment.bottomCenter),
          ...map.treeObjects.map((e) {
            var w = _isDragging? e.width * 1.5 : e.width;
            var h = _isDragging? e.height * 1.5 : e.height;
            return Positioned(
                left: e.x - w / 2,
                top: e.y - h / 2,
                child: GestureDetector(
                  onLongPress: _isDragging ? null : () => _onHold(e),
                  onPanUpdate: _isDragging ? _onDrag : null,
                  onLongPressEnd: (details) => setState(() => _isDragging = false),
                  onPanEnd: (details) => setState(() => _isDragging = false),
                  child: CustomImageView(
                    border: Border.all(),
                    radius: BorderRadius.circular(50.adaptSize),
                    imagePath: e.imagePath,
                    height: h,
                    width: w,
                    alignment: Alignment.center,
                  ),
                ));
          }),
        ]);
  }

  _onHold(TreeObject object) {
    setState(() {
      _isDragging = true;
      draggingObject = object;
    });
  }

  _onDrag(DragUpdateDetails details) {
    print("a");
    setState(() {
      draggingObject!.x += details.delta.dx;
      draggingObject!.y += details.delta.dy;
    });
  }
}
