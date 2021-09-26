import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/home/home_store.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {

  final ConstStyle constStyle = ConstStyle();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Scaffold(
      backgroundColor: constStyle.primaryColor,
      appBar: AppBar(
        backgroundColor: constStyle.secondaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        title: const Text("HOME"),
      ),
      body: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                minimumSize: Size(constraints.maxWidth/2,50),
                padding: const EdgeInsets.all(5),
                primary: constStyle.secondaryColor
            ),
            onPressed: (){
              store.signOut();
            },
            child: const Text("Sign Out",style: TextStyle(color: Colors.white))
        ),
      ),
    )
    );
  }
}