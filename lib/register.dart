import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  String? name;
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
              padding: const EdgeInsets.all(39),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 39, fontWeight: FontWeight.w900),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color.fromRGBO(0, 174, 255, 0.98),
                                width: 3),
                          ),
                        ),
                        child: const Text("                            "),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Name',
                        hintText: 'Username',
                      ),
                      onChanged: (value) => name = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must not empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Email',
                        hintText: 'example@example.com',
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not empty';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: hidepassword,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Password',
                        hintText: 'At least 6 Characters',
                        suffixIcon: IconButton(
                          icon: Icon(hidepassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              hidepassword = !hidepassword;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) => password = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'password must not empty';
                        } else if (value.length < 6) {
                          return "Must have a minimum of 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          var currentContext = context;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmation'),
                                content: const Text(
                                    'Are You Sure The Data Is Correct?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          InkWell(
                            child: const Text(
                              "Login",
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
