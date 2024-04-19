import 'package:flutter/material.dart';
import 'package:funtree/backend/backend.dart';
import 'package:funtree/presentation/homescreen_screen/homescreen_screen.dart';
import 'package:funtree/routes/app_routes.dart';
import 'package:funtree/widgets/ToastNoti.dart';
import 'package:funtree/widgets/camera/camera.dart';

class PlantDetailScreen extends StatelessWidget {
  final Tree tree;

  const PlantDetailScreen({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image(
              image: NetworkImage(tree.image_url),
              height: screenHeight * 0.3,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: screenWidth * 0.07,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.04),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.04),
                            child: Image(
                              image: NetworkImage(tree.image_url),
                              height: screenHeight * 0.25,
                              width: screenWidth * 0.4,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            try{
                              Map<String, dynamic> data = {
                                "name": tree.name,
                                "common_names": tree.common_names,
                                "url": tree.image_url,
                                "description": tree.description
                              };
                              print(data);
                              var responseUpload = await Api().postData('plant/create', data);
                              if(responseUpload!["status"] == true) {
                                ToastNoti.show("Add plant successfully");
                                Navigator.pushNamed(context, AppRoutes.navigationMenu);
                              } else {
                                ToastNoti.show("Fail");
                              }
                            }catch(e){
                              print(e);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: screenWidth * 0.1,
                                top: screenHeight * 0.12),
                            height: screenWidth * 0.2,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenWidth * 0.1),
                              color: Color.fromRGBO(45, 116, 73, 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(45, 116, 73, 0.5),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: screenWidth * 0.15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tree.name, // Sử dụng tiêu đề phim từ thông tin phim
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Common name: ${tree.common_names}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            Text(
                              'ID: ${tree.plantId}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Text(
                          'Description:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          tree.description,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.04,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
