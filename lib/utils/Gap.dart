import 'package:flutter/cupertino.dart';



class Gap extends StatelessWidget {
  final double size;


  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
