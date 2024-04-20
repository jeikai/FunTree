import 'package:flutter/material.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/app_export.dart';
import 'package:funtree/presentation/chattingscreen_screen/threedot.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../backend/backend.dart';
import '../../widgets/ToastNoti.dart';
import 'chatmessage.dart';

class ChattingscreenScreen extends StatefulWidget {
  const ChattingscreenScreen({super.key});

  @override
  State<ChattingscreenScreen> createState() => _ChattingscreenScreenState();
}

class _ChattingscreenScreenState extends State<ChattingscreenScreen> {
  TextEditingController messageController = TextEditingController();
  final List<ChatMessage> _message = [];
  final _formKey = GlobalKey<FormState>();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    addData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addData() async {
    String userId = (await SharePref.getUserId()!);
    var response = await Api().getData('chat/' + userId);

    for (var messageData in response!["data"]["history"]) {
      setState(() {
        ChatMessage message = ChatMessage(
          text: messageData["message"],
          sender: messageData["sender"],
          isImage: false,
        );
        _message.insert(0, message);
      });
    }
  }

  void _sendMessage() async {
    if (messageController.text.isEmpty) return;
    ChatMessage message =
        ChatMessage(text: messageController.text, sender: "user");
    setState(() {
      _message.insert(0, message);
      _isTyping = true;
    });
    Map<String, dynamic> request = {
      "prompt": messageController.text,
    };
    String userId = (await SharePref.getUserId()!);
    messageController.clear();
    var response = await Api().postData("chat/" + userId, request);
    insertNewData(response!["data"]["response"]["modelChat"]["message"]);
  }

  void insertNewData(String response, {bool isImage = false}) {
    ChatMessage message = ChatMessage(
      text: response,
      sender: "bot",
      isImage: isImage,
    );
    setState(() {
      _isTyping = false;
      _message.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appTheme.green50,
      // resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 20.v),
          child: SafeArea(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 80),
                    itemBuilder: (context, index) {
                      return _message[index];
                    },
                    itemCount: _message.length,
                  ),
                ),
                if (_isTyping) const ThreeDots(),
                const Divider(
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(color: context.cardColor),
                  child: _buildMessage(),
                )
              ],
            ),
          )),
    ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xebf3e8),
      title: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/img_brave_ai.png'),
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          Text('Tree AI',
              style: TextStyle(
                  color: Color.fromRGBO(73, 136, 85, 1), fontSize: 32))
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              controller: messageController,
              onFieldSubmitted: (value) => _sendMessage(),
              validator: (value) {
                if (value!.isEmpty) {
                  ToastNoti.show("Bạn chưa nhập gì");
                }
                return null;
              },
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: "Nhập tin nhắn",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(73, 136, 85, 1),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              ),
              style: TextStyle(
                color: Color.fromRGBO(73, 136, 85, 1),
                fontSize: 20.0,
                fontFamily: 'Paytone One',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.send,
            color: Color.fromRGBO(73, 136, 85, 1),
          ),
          onPressed: () async {
            _sendMessage();
          },
        ),
      ],
    ).px16();
  }
}
