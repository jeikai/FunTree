
import 'package:flutter/cupertino.dart';
import 'package:funtree/core/utils/size_utils.dart';
import 'package:funtree/presentation/shoppingscreen_page/widgets/userprofile_item_widget.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.v),
        _buildUserProfile(context),
        SizedBox(height: 32.v),
      ],
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.h),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 174.v,
          crossAxisCount: 2,
          mainAxisSpacing: 22.h,
          crossAxisSpacing: 22.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return UserprofileItemWidget();
        },
      ),
    );
  }
}