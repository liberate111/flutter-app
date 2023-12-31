import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final authService = AuthService();
  bool isLoading = false;

  Future<void> _login(Map<dynamic, dynamic> formValue) async {
    setState(() {
      isLoading = true;
    });
    var response = await authService.login(
        email: formValue['email'], password: formValue['password']);
    var resp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      await authService.getProfile();
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Login', 'success', backgroundColor: Colors.green.shade200);
      Future.delayed(const Duration(seconds: 1), () {
        Get.offNamedUntil('/tab', (route) => false);
      });
    } else {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Login', '${resp['message']}',
          backgroundColor: Colors.red.shade200,
          snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.lightGreen,
                Colors.greenAccent,
                Colors.blueGrey
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset('assets/images/3.PNG'),
                      const SizedBox(
                        height: 40,
                      ),
                      Card(
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                          child: Column(
                            children: [
                              const Text('Login'),
                              const SizedBox(
                                height: 10,
                              ),
                              FormBuilder(
                                key: _formKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    FormBuilderTextField(
                                      name: 'email',
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          icon:
                                              const Icon(Icons.email_outlined),
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
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
                                            errorText:
                                                'Please fill the password'),
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
                                      child: MaterialButton(
                                    autofocus: true,
                                    height: 40,
                                    color:
                                        const Color.fromARGB(255, 231, 96, 18),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amberAccent),
                                    ),
                                    onPressed: () async {
                                      _formKey.currentState?.saveAndValidate();
                                      if (_formKey.currentState!.validate()) {
                                        await _login(
                                            _formKey.currentState!.value);
                                      }
                                    },
                                  )),
                                  Expanded(
                                      child: TextButton(
                                          onPressed: () {
                                            Get.toNamed('/register');
                                          },
                                          child: const Text(
                                            'Register',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
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
