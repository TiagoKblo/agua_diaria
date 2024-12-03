import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZDVwbThlYmhjMnRnaXZsdnRrZmxicXVtZXpkOGV6b3F2eGY2aTZ3bSZlcD12MV9naWZzX3NlYXJjaCZjdD1n/SRISNle9ppFhizFkSo/giphy.gif',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}