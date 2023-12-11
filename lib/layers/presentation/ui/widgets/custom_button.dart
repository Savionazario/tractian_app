import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Widget title;
  final Color color;
  final Widget icon;
  final VoidCallback onPressed;
  const CustomButton({ Key? key, required this.title, required this.onPressed, required this.icon, this.color = Colors.transparent }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(
            color: Color(0xFFD8DFE6)
          )
        )
      ),
      onPressed: widget.onPressed,
      child: Row(
        children: [
          widget.icon,
          const SizedBox(width: 6.0,),
          widget.title,
        ],
      ),
    );
  }
}