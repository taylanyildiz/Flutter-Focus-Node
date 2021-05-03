import 'package:flutter/material.dart';
import 'package:focus_scope_exam/widgets/custom_button.dart';

class _InputScope extends InheritedWidget {
  _InputScope({
    Key? key,
    required Widget child,
    required this.state,
  }) : super(key: key, child: child);

  final _InputWidgetState state;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      (oldWidget as _InputScope).state != state;
}

class InputWidget extends StatefulWidget {
  InputWidget({
    Key? key,
  }) : super(key: key);

  static _InputWidgetState? of(BuildContext context) {
    final _InputScope? scope =
        context.dependOnInheritedWidgetOfExactType<_InputScope>();
    return scope!.state;
  }

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  PageController? _pageController;
  final _controller = <TextEditingController>[];
  final _key = <GlobalKey<FormState>>[];

  final node = <FocusNode>[];
  void nextPage() async {
    final check = _key[currentPage].currentState!.validate();

    if (check) {
      final page = _controller[currentPage].text;
      await checkController(page);
      if (currentPage < 2) currentPage++;
    }

    _pageController!.animateToPage(
      currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  void backPage() {
    if (currentPage != 0) {
      currentPage--;
    }
    _pageController!.animateToPage(
      currentPage,
      duration: Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  Future checkController(value) async {
    switch (currentPage) {
      case 0:
        currentName = _controller[currentPage].text;
        print('name : $currentName');
        break;
      case 1:
        userName = _controller[currentPage].text;
        print('user namme : $userName');
        break;
      case 2:
        email = _controller[currentPage].text;
        print('email : $email');
        break;
      default:
        print('not found');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 3; i++) {
      node.add(new FocusNode());
      _controller.add(new TextEditingController());
      _key.add(GlobalKey<FormState>(debugLabel: '$i'));
    }
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  final p = <String>[
    'Name',
    'User Name',
    'E-mail',
  ];

  String? currentName;
  String? userName;
  String? email;
  final help = <String>[
    'Hey Welcome,Please Enter Your Name,',
    'Hey .. Enter User name',
    'Finally Enter mail adress',
  ];

  final _iconsData = <IconData>[
    Icons.person,
    Icons.person,
    Icons.mail,
  ];

  Future<List<Widget>> profile(Size size) async {
    final prf = <Widget>[];

    for (var i = 0; i < 3; i++) {
      prf.add(
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  help[i],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 40.0),
              SizedBox(
                width: size.width * .7,
                child: Form(
                  key: _key[i],
                  child: TextFormField(
                    validator: (page) {
                      if (page!.isEmpty)
                        return 'Can not be null';
                      else {
                        return null;
                      }
                    },
                    focusNode: node[i],
                    autofocus: true,
                    controller: _controller[i],
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        _iconsData[i],
                        color: Colors.orange,
                      ),
                      labelText: p[i],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return prf;
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _InputScope(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder<List<Widget>>(
              future: profile(size),
              builder: (context, constraint) {
                if (constraint.hasData) {
                  final profile = constraint.data;
                  return PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (page) => currentPage = page,
                    controller: _pageController!,
                    itemBuilder: (context, index) {
                      FocusScope.of(context).requestFocus(node[currentPage]);
                      return profile![index];
                    },
                  );
                } else {
                  return Container();
                }
              }),
          Positioned(
            top: 100.0,
            left: 20.0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => backPage(),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          CustomButton(),
        ],
      ),
      state: this,
    );
  }
}
