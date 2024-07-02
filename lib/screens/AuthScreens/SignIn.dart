import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/server/api/authenticationApi.dart';

import 'Signup.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/3.6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      const Text("Welcome Back",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text("Sign Up to continue"),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'email',
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.mail_outline),
                                  hintText: "email",
                                  label: Text("Email"),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'password',
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "password",
                                  filled: true,
                                  label: Text("Password"),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(height: 10,),
                              GestureDetector(onTap: (){}, child: const Text("Forgot Password",style: TextStyle(color: Colors.blue),)),
                              const SizedBox(height: 20,),
                              MaterialButton(
                                elevation: 4,
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                onPressed: () {
                                  if(_formKey.currentState?.saveAndValidate() ?? false){
                                    final email = _formKey.currentState?.fields['email']?.value;
                                    final password = _formKey.currentState?.fields['password']?.value;
                                    Authentication().handelUserLogin(email, password, context);
                                  }
                                },
                                child: const Text('Log In',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600,fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account?"),
                          const SizedBox(width: 5,),
                          GestureDetector(onTap: (){
                            if (Theme.of(context).platform == TargetPlatform.iOS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => const SignupScreen()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignupScreen()),
                              );
                            }
                          }, child: const Text("Create one",style: TextStyle(color: Colors.blue))),
                        ],
                      ),
                      const SizedBox(height: 5,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
