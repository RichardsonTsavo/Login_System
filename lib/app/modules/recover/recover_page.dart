import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:portfolio/app/modules/recover/recover_store.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/shared/utils/custom_text_form_field/custom_text_form_field.dart';
import 'package:portfolio/app/shared/utils/style/style.dart';

class RecoverPage extends StatefulWidget {
  final String title;
  const RecoverPage({Key? key, this.title = 'RecoverPage'}) : super(key: key);
  @override
  RecoverPageState createState() => RecoverPageState();
}
class RecoverPageState extends State<RecoverPage> {
  final RecoverStore store = Modular.get();
  final ConstStyle constStyle = ConstStyle();
  GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          backgroundColor: constStyle.primaryColor,
          appBar: AppBar(
            backgroundColor: constStyle.secondaryColor,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            centerTitle: true,
            title: const Text("PASSWORD RECOVERY"),
          ),
          body: Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "STEP BY STEP",
                      style: TextStyle(fontSize: 25),
                    ),
                    const Text(
                      "1) Put your email in the text box below.\n"
                          "2) Press the send request button.\n"
                          "3) Wait for the request to be confirmed.\n"
                          "4) Open your email and follow the steps indicated.",
                      style: TextStyle(
                          fontSize: 15),
                    ),
                    CustomTextFormField(
                      validator: (data) {
                        if (!EmailValidator.validate(data!)) {
                          return "Add a valid email";
                        }
                      },
                      needTheSpace: true,
                      obscureText: false,
                      onChanged: (data) {
                        store.email = data;
                      },
                      hint: "Email",
                      prefixIcon: Icon(
                        Icons.email,
                        color: constStyle.secondaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Observer(
                      builder: (context) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                              Size(constraints.maxWidth / 2, 50),
                              primary: constStyle.secondaryColor),
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              store.recoverPassword();
                            }
                          },
                          child: store.isLoading
                              ? const CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                          )
                              : const Text("Send Request")),
                    )
                  ]),
            ),
          ),
        ));
  }
}