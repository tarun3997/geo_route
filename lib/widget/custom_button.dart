import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
            color: const Color(0xff363333),
            borderRadius: BorderRadius.circular(30)
        ),
        child:  Center(child: Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),)),
      ),
    );
  }
}
