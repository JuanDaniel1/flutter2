import 'package:flutter/material.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/controller/auth_controller.dart';
import 'package:senacomerce3/extention/string_extention.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../pantallainicio.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text("Bienvenido,",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                const Text(
                  "Inicia Sesion para continuar!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
                ),
                const Spacer(
                  flex: 3,
                ),
                InputTextField(
                  title: 'Email',
                  textEditingController: emailController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    } else if (!value.isValidEmail) {
                      return "Por favor digite un correo valido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Contraseña',
                  obsecureText: true,
                  textEditingController: passwordController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: const Text(
                        "Olvide mi contraseña",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                InputTextButton(
                  title: "Iniciar Sesion", onClick: (){
                    if(_formKey.currentState!.validate()){
                      authController.signIn(email: emailController.text, password: passwordController.text);
                    }

                },
                ),
                const SizedBox(height: 10),
                InputOutlineButton(
                  title: "Atras",
                  onClick: (){
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Soy un nuevo usuario, "),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text("Registrarse",
                      style: TextStyle(
                        color: Colors.blue
                      ),),
                    )
                  ],
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
