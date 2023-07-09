import 'package:finalexam/controller/auth_controller.dart';
import 'package:finalexam/model/user_model.dart';
import 'package:finalexam/view/admin/home/admin.dart';
import 'package:finalexam/view/dokter/dokter.dart';

import 'package:flutter/material.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthController authCtr = AuthController();
  String? email;
  String? password;
  bool hidepassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          height: 850,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              focal: Alignment.topLeft,
              focalRadius: 2,
              colors: [Colors.blue, Colors.white],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(39.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 39, fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(0, 174, 255, 0.98),
                              width: 3,
                            ),
                          ),
                        ),
                        child: const Text("                      "),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Email',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: 'example@example.com',
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: hidepassword,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Password',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        hintText: 'At least 6 Characters',
                        suffixIcon: IconButton(
                          icon: Icon(hidepassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(
                              () {
                                hidepassword = !hidepassword;
                              },
                            );
                          },
                        ),
                      ),
                      onChanged: (value) => password = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      child: const Text('Log In'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          UserModel? loginUser =
                              await authCtr.signInWithEmailAndPassword(
                            email!,
                            password!,
                          );
                          if (loginUser != null) {
                            // Login success
                            if (loginUser.role == 'admin') {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const AdminHome();
                                  },
                                ),
                              );
                            } else {
                              // User login success
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const DokterHome();
                                  },
                                ),
                              );
                            }
                          } else {
                            // Login failed
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Login'),
                                  content: const Text(
                                      'An error occurred during login'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Doesn't have an account yet? "),
                          InkWell(
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const Register(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ], // Children
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
