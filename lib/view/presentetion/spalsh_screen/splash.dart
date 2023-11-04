import 'package:flutter/material.dart';
import 'package:todo_app/view/presentetion/home_page/home_page.dart';

class SplashScreeen extends StatelessWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    navigator(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
      ),
    );
  }

  Future<void> navigator(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));
  }
}
