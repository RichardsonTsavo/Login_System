import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:portfolio/app/modules/register/register_store.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/shared/utils/custom_text_form_field/custom_text_form_field.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}
class RegisterPageState extends State<RegisterPage> {
  final RegisterStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Scaffold(
      backgroundColor: constStyle.primaryColor,
      appBar: AppBar(
        backgroundColor: constStyle.secondaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        title: const Text("SIGN UP"),
      ),
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
                          store.email = text;
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
                              store.setPassword(text);
                            },
                            validator: (text) {
                              if(text!.length < 6){
                                return "please put a valid email";
                              }
                            },
                          )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Observer(
                        builder: (context) => FlutterPasswordStrength(
                          password: store.password,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
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
                          store.signUp();
                        }
                      },
                      child:  Observer(
                        builder: (context) => store.isLoading?
                            const CircularProgressIndicator(valueColor:
                              AlwaysStoppedAnimation(Colors.white),)
                            :const Text("Sign Up",style: TextStyle(color: Colors.white)),
                      )
                  ),
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