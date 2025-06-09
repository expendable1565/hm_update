import 'package:flutter/material.dart';

class DecoratedImageButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;
  final MaterialColor color;
  final bool colorImage;

  const DecoratedImageButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.color = Colors.blue,
    this.colorImage = true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: color[50]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage(icon), height: 45, color: colorImage ? color : null),
              SizedBox(width: 15, height: 0),
              Text(text, style: TextStyle(fontSize: 30, color: color[800])),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerButton extends StatelessWidget {
  final String icon;
  final MaterialColor color;
  final VoidCallback onPressed;

  const PlayerButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
          backgroundColor: WidgetStatePropertyAll(color[50]),
        ),
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          child: Image(image: AssetImage(icon), height: 32, color: color[900]),
        ),
      ),
    );
  }
}
