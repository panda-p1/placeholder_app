import 'package:flutter/material.dart';

class SeeMoreViewButton extends StatelessWidget {
  final void Function() onPressed;
  const SeeMoreViewButton(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const SizedBox(
        height: 50,
        child: Center(
          child: Text('See more',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
