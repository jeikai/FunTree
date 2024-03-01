import 'package:flutter/material.dart';

class DetailController extends ChangeNotifier {
  bool _isShow = false;
  bool get isShow => _isShow;
  Map<String, dynamic> data = {};
  void show(Map<String, dynamic> data) {
    _isShow = true;
    this.data = data;
    notifyListeners();
  }
  void close() {
    _isShow = false;
    notifyListeners();
  }
}

class DetailWidget extends StatefulWidget {
  final DetailController controller;

  const DetailWidget({super.key, required this.controller});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  DetailController get _detailController => widget.controller;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _detailController.addListener(() {
      if(_detailController.isShow) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController, builder: (context, child) {
      return Positioned(
        top: _animationController.value * 100,
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: Text('Detail'),
        ),
      );
    },
    child: _buildDetail(),);
  }

  _buildDetail() {
    return Positioned(
      top: 0,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
        child: Text('Detail'),
      ),
    );
  }
}
