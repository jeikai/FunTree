import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funtree/core/map/map.dart';
import 'package:funtree/core/utils/size_utils.dart';
import 'package:funtree/presentation/caredetailscreen_tab_container_screen/caredetailscreen_tab_container_screen.dart';
import 'package:funtree/presentation/homescreen_screen/mapeditorscreen_screen/mapeditorscreen_screen.dart';
import 'package:funtree/routes/app_routes.dart';
import 'package:funtree/theme/custom_text_style.dart';
import 'package:funtree/theme/theme_helper.dart';

import '../../core/utils/image_constant.dart';
import '../custom_image_view.dart';

Function resetMap= () {};

class HomeMap extends StatefulWidget {
  HomeMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeMapState();
}

final Widget addWidget = Align(
    alignment: Alignment.bottomCenter,
    child: DottedBorder(
        color: appTheme.green300Bc,
        strokeWidth: 2.h,
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        dashPattern: [10, 10],
        radius: Radius.circular(20.h),
        child: SizedBox(
          height: 400.v,
          width: 300.h,
          child: Center(
            child: Icon(
              Icons.add,
              color: appTheme.green200,
              size: 24,
            ),
          ),
        )));

class HomeMapState extends State<HomeMap> {
  int state = 0;

  late Listenable mapListenable;

  late void Function() mapListener;

  @override
  void initState() {
    super.initState();
    mapListener = () {
      setState(() {});
    };
    mapListenable = Listenable.merge(maps);
    mapListenable.addListener(mapListener);
    resetMap = () {
      setState(() {});
    };
  }

  @override
  void dispose() {
    mapListenable.removeListener(mapListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 454.v,
            width: 300.h,
            child: GestureDetector(
              onTap: () {
                _onTapMap(context);
              },
              child: state == maps.length ? addWidget : _buildMap(context, state),
            )),
        SizedBox(height: 13.v),
        _buildNavBar(context),
        SizedBox(height: 13.v),
      ],
    );
  }

  _onTapMap(BuildContext context) {
    if (state == maps.length) {
      _createMap(context);
      setState(() {});
    } else {
      mapIndex = state;
      Navigator.pushNamed(context, AppRoutes.mapEditorScreen);
    }
  }

  _onTapTree(BuildContext context, tid) {
    treeIndex = tid;
    Navigator.pushNamed(context, AppRoutes.caredetailscreenTabContainerScreen);
  }

  _createMap(BuildContext context) {
    maps.add(TreeMap());
  }

  _buildMap(BuildContext context, int state) {
    TreeMap map = maps[state];
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 400.v,
        child: Stack(children: [
          CustomImageView(
              imagePath: ImageConstant.imgBedroom,
              height: 400.v,
              width: 300.h,
              alignment: Alignment.bottomCenter),
          ...map.treeObjects.map((e) {
            return Positioned(
                left: e.x - e.width / 2,
                top: e.y - e.height / 2,
                child: CustomImageView(
                    border: Border.all(),
                    radius: BorderRadius.circular(50.adaptSize),
                    imagePath: e.imagePath,
                    height: e.height,
                    width: e.width,
                    alignment: Alignment.center,
                    onTap: () {
                      _onTapTree(context, state - 1);
                    }));
          }),
        ]),
      ),
    );
  }

  _buildNavBar(BuildContext context) {
    print("a");
    var name = "New Map";
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgNextPage,
            height: 33.adaptSize,
            width: 33.adaptSize,
            margin: EdgeInsets.only(top: 5.v),
            onTap: () {
              if (state == maps.length) {
                setState(() {
                  state = 0;
                });
                return;
              }
              setState(() {
                state = state + 1;
              });
            },
          ),
          Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Text(state == maps.length ? name : maps[state].mapName,
                  style: CustomTextStyles.headlineLargeGreen60001)),
          CustomImageView(
              imagePath: ImageConstant.imgNextPage33x33,
              height: 33.adaptSize,
              width: 33.adaptSize,
              margin: EdgeInsets.only(left: 13.h, top: 5.v),
              onTap: () {
                if (state == 0) {
                  setState(() {
                    state = maps.length;
                  });
                  return;
                }
                setState(() {
                  state = state - 1;
                });
              })
        ]);
  }
}
// Align(
// alignment: Alignment.topRight,
// child: Container(
// height: 76.adaptSize,
// width: 76.adaptSize,
// margin:
// EdgeInsets.only(right: 52.h),
// child: Stack(
// alignment:
// Alignment.topCenter,
// children: [
// CustomImageView(
// imagePath: ImageConstant
//     .imgTopic,
// height: 76.adaptSize,
// width: 76.adaptSize,
// alignment:
// Alignment.center),
// Align(
// alignment:
// Alignment.topCenter,
// child: Padding(
// padding:
// EdgeInsets.only(
// top: 24.v),
// child: Text(
// "Cactus",
// style: CustomTextStyles
// .bodyMediumOnError_1)))
// ])))
