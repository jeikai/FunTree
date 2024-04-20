import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.iconData,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color.fromRGBO(243, 245, 246, 1), padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Container(
              width: 22.0,
              child: Icon(iconData, color: Colors.black,),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(
              color: Colors.black
            ),)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}