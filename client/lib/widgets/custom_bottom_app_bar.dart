import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
        icon: ImageConstant.imgNavMyGarden,
        activeIcon: ImageConstant.imgNavMyGarden,
        title: "My garden",
        type: BottomBarEnum.Mygarden,
        isSelected: true),
    BottomMenuModel(
      icon: ImageConstant.imgNavShop,
      activeIcon: ImageConstant.imgNavShop,
      title: "Shop",
      type: BottomBarEnum.Shop,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavCommunity,
      activeIcon: ImageConstant.imgNavCommunity,
      title: "Community",
      type: BottomBarEnum.Community,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBraveAi,
      activeIcon: ImageConstant.imgBraveAi,
      title: "AI",
      type: BottomBarEnum.Ai,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.h),
      ),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: theme.colorScheme.onError,
        child: SizedBox(
          height: 70.v,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomMenuList.length,
              (index) {
                return InkWell(
                  //make inkwell bigger

                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h),
                  ),

                  onTap: () {
                    for (var element in bottomMenuList) {
                      element.isSelected = false;
                    }
                    bottomMenuList[index].isSelected = true;
                    widget.onChanged?.call(bottomMenuList[index].type);
                    setState(() {});
                  },
                  child: bottomMenuList[index].isSelected
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: bottomMenuList[index].activeIcon,
                              height: 25.adaptSize,
                              width: 25.adaptSize,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.v),
                              child: Text(
                                bottomMenuList[index].title ?? "",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: appTheme.green60001,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: bottomMenuList[index].icon,
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                            ),
                            Text(
                              bottomMenuList[index].title ?? "",
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: appTheme.green60001,
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum BottomBarEnum {
  Mygarden,
  Shop,
  Community,
  Ai,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
    this.isSelected = false,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;

  bool isSelected;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
