import 'package:flutter/material.dart';
import 'package:focus_scope_exam/widgets/input_widget.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final Function? onPressed;

  void _handleChangePage(BuildContext context) {
    InputWidget.of(context)!.nextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0.0,
      child: SizedBox(
        width: size.width * .9,
        child: MaterialButton(
          onPressed: () => _handleChangePage(context),
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
