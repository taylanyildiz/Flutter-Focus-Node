import 'package:flutter/material.dart';
import 'package:focus_scope_exam/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          InputWidget(),
        ],
      ),
    );
  }
}
