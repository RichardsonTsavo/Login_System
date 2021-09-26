import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/shared/utils/snackbar/global_scaffold.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login System',
      theme: ThemeData(
          primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        key: GlobalScaffold.instance.scafoldKey,
        body: child,
        resizeToAvoidBottomInset: false,
      ),
    ).modular();
  }
}