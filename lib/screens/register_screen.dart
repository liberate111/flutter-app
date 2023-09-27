import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final authService = AuthService();

  Future<void> _register(Map<dynamic, dynamic> formValue) async {
    var response = await authService.register(
        name: formValue['name'],
        email: formValue['email'],
        password: formValue['password']);
    if (response.statusCode == 201) {
      var resp = jsonDecode(response.body);
      Get.snackbar('Register', '${resp['message']}',
          backgroundColor: Colors.green.shade200);
      Future.delayed(const Duration(seconds: 2), () {
        Get.offNamedUntil('/login', (route) => false);
      });
    } else {
      var resp = jsonDecode(response.body);
      Get.snackbar(
          'Register', '${resp['message']}\n${resp['errors']['email'][0]}',
          backgroundColor: Colors.red.shade200,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 236, 238, 113),
          Color.fromARGB(255, 190, 238, 60),
          Color.fromARGB(255, 251, 255, 10)
        ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/egat_logo.png'),
                const SizedBox(
                  height: 40,
                ),
                Card(
                  color: const Color.fromARGB(255, 214, 113, 113),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      children: [
                        const Text('Register'),
                        const SizedBox(
                          height: 10,
                        ),
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'name',
                                maxLines: 1,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.verified_user),
                                    labelText: 'Name',
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        220, 255, 255, 255),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Please fill the name'),
                                ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormBuilderTextField(
                                name: 'email',
                                maxLines: 1,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.email_outlined),
                                    labelText: 'Email',
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        220, 255, 255, 255),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Please fill the Email'),
                                  FormBuilderValidators.email(
                                      errorText: 'Invalid email')
                                ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FormBuilderTextField(
                                name: 'password',
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.password),
                                    labelText: 'Password',
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        220, 255, 255, 255),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                      errorText: 'Please fill the password'),
                                  FormBuilderValidators.minLength(3,
                                      errorText:
                                          'password must greater than 3 characters')
                                ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: MaterialButton(
                                  height: 40,
                                  color: const Color.fromARGB(255, 231, 96, 18),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amberAccent),
                                  ),
                                  onPressed: () async {
                                    _formKey.currentState?.save();
                                    if (_formKey.currentState!.validate()) {
                                      await _register(
                                          _formKey.currentState!.value);
                                    }
                                  },
                                )),
                            Expanded(
                                flex: 1,
                                child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline),
                                    )))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
