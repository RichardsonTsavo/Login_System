import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/splash/splash_store.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}
class SplashPageState extends State<SplashPage> {
  final SplashStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();

  @override
  void initState() {
    store.setColor();
    store.getPersistentLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: constStyle.primaryColor,
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlutterLogo(size: constraints.maxWidth/2),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white)
              )
            ],
          ),
        ),
      ),
    );
  }
}