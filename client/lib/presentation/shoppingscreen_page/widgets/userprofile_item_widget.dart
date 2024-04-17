import 'package:flutter/material.dart';
import 'package:funtree/core/app_export.dart';

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillGreen200.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgPicShop11,
            height: 113.v,
            width: 141.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 1.h,
              vertical: 3.v,
            ),
            decoration: AppDecoration.fillOnError1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text(
                    "Heather wreaths",
                    style: CustomTextStyles.bodySmallPrimary,
                  ),
                ),
                SizedBox(height: 3.v),
                Container(
                  width: 134.h,
                  margin: EdgeInsets.only(left: 3.h),
                  child: Text(
                    "This is a type of ornamental plant with dark green leaves, often\ngrown in small pots to decorate work desks or guest tables.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.itimPrimary,
                  ),
                ),
                SizedBox(height: 2.v),
                Padding(
                  padding: EdgeInsets.only(left: 3.h),
                  child: Text(
                    " 20.00",
                    style: CustomTextStyles.bodySmallPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
