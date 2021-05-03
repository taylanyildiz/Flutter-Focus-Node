import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    this.name,
    this.user,
    this.mail,
  }) : super(key: key);

  final String? name;
  final String? user;
  final String? mail;

  Future<List<String>> profile() async {
    final prof = <String>[
      'name : ${name!}',
      'user name :${user!}',
      'mail : ${mail!}',
    ];

    return prof;
  }

  Future<bool> back(BuildContext context) async {
    Navigator.popUntil(context, (route) => route.isFirst);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst)),
      ),
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () => back(context),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
                child: Container(
                    height: 200.0,
                    child: Center(
                      child: FutureBuilder<List<String>>(
                        future: profile(),
                        builder: (context, constraint) {
                          if (constraint.hasData) {
                            final profile = constraint.data;
                            return ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index) => Center(
                                child: Text(
                                  profile![index],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
