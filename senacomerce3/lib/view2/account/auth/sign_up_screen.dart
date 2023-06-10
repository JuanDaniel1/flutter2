import 'package:flutter/material.dart';
import 'package:senacomerce3/controller/controllers.dart';
import 'package:senacomerce3/extention/string_extention.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import '../../test.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
                const Text("Crear Cuenta,",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                const Text(
                  "Registrate para comenzar!",
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
                  title: 'Nombre completo',
                  textEditingController: fullNameController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Email',
                  textEditingController: emailController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    } else if (!value.isValidEmail) {
                      return "Por favor digite un email valido";
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
                    List<String> _validation = [];
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    } else {
                      if (!value.isValidPasswordHasNumber) {
                        _validation.add("Debe contener 1 numero");
                      }
                      if (!value.isValidPasswordHasCapitalLetter) {
                        _validation.add("Debe tener 1 mayuscula");
                      }
                      if (!value.isValidPasswordHasLowerCaseLetter) {
                        _validation.add("Debe contener 1 minuscula");
                      }
                      if (!value.isValidPasswordHasSpecialCharacter) {
                        _validation.add(
                            "Debe contener 1 caracter especial[! @ # \$ %]");
                      }
                    }
                    String msg = '';
                    if (_validation.isNotEmpty) {
                      for (var i = 0; i < _validation.length; i++) {
                        msg = msg + _validation[i];
                        if ((i + 1) != _validation.length) {
                          msg = "$msg\n";
                        }
                      }
                    }
                    return msg.isNotEmpty ? msg : null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Confirmar contraseña',
                  obsecureText: true,
                  textEditingController: confirmController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Este campo no puede estar vacio";
                    } else if (passwordController.text != value) {
                      return "Confirm password not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Spacer(),
                InputTextButton(
                  title: "Registrarse",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signUp(fullName: fullNameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                InputOutlineButton(
                  title: "Atras",
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ya soy un miembro, "),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: const Text(
                        "Iniciar Sesion",
                        style: TextStyle(color: Colors.blue),
                      ),
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
