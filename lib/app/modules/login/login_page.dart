import 'package:email_validator/email_validator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/shared/utils/custom_text_form_field/custom_text_form_field.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage> {
  final LoginStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();
  GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Scaffold(
      backgroundColor: constStyle.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: form,
          child: SingleChildScrollView(
            child: SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlutterLogo(size: constraints.maxWidth/2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              minimumSize: Size(constraints.maxWidth/4,50),
                              padding: const EdgeInsets.all(5),
                              primary: constStyle.primaryColor
                          ),
                          onPressed: (){
                            store.signWithGoogle();
                          },
                          child: Image.asset(
                            constStyle.imageGooglePath,
                            width: constraints.maxWidth/8,
                            height: constraints.maxWidth/10,
                          )
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              minimumSize: Size(constraints.maxWidth/4,50),
                              padding: const EdgeInsets.all(5),
                              primary: constStyle.primaryColor
                          ),
                          onPressed: (){
                            store.signWithFacebook();
                          },
                          child: Image.asset(
                            constStyle.imageFacebookPath,
                            width: constraints.maxWidth/8,
                            height: constraints.maxWidth/10,
                          )
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CustomTextFormField(
                        prefixIcon: Icon(
                          Icons.email,
                          color: constStyle.secondaryColor,
                        ),
                        validator: (text) {
                          if(!EmailValidator.validate(text!)){
                            return "please put a valid email";
                          }
                        },
                        onChanged: (text){
                          store.fields["email"] = text;
                        },
                        obscureText: false,
                        needTheSpace: false,
                        hint: "Email",
                      ),
                      Observer(
                        builder: (_) => CustomTextFormField(
                          needTheSpace: true,
                          obscureText: store.isPasswordVisible,
                          suffixIcon: IconButton(
                            onPressed: () {
                              store.changePasswordVisible();
                            },
                            icon: Icon(
                              store.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: constStyle.secondaryColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: constStyle.secondaryColor,
                          ),
                          hint: "Password",
                          onChanged: (text) {
                            store.fields["password"] = text;
                          },
                          validator: (text) {
                            if(text!.length < 6){
                              return "please put a valid email";
                            }
                          },
                        )
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Observer(
                        builder: (context) => ElevatedButton(
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
                              if(form.currentState!.validate()){
                                store.signIn();
                              }
                            },
                            child: store.isLoading
                                ? const CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation(Colors.white),
                            ):const Text("Sign In",style: TextStyle(color: Colors.white))
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                      color: constStyle.secondaryColor,width: 3
                                  )
                              ),
                              elevation: 0,
                              minimumSize: Size(constraints.maxWidth/4,50),
                              padding: const EdgeInsets.all(5),
                              primary: constStyle.transparent
                          ),
                          onPressed: (){
                            Modular.to.pushNamed("/signUp/");
                          },
                          child: Text("Sign Up",style: TextStyle(color: constStyle.secondaryColor),)
                      )
                    ],
                  ),
                  TextButton(
                      onPressed: (){
                        Modular.to.pushNamed("/recover/");
                      },
                      child: Text("Recover password",
                          style: TextStyle(color: constStyle.secondaryColor,fontSize: 15)
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}