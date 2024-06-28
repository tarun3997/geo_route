import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/screens/AuthScreens/SignIn.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

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
                      SizedBox(height: 10,),
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
                              SizedBox(height: 10,),
                              GestureDetector(onTap: (){}, child: Text("Forgot Password",style: TextStyle(color: Colors.blue),)),
                              SizedBox(height: 20,),
                              MaterialButton(
                                elevation: 4,
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                onPressed: () {
                                  // Validate and save the form values
                                  _formKey.currentState?.saveAndValidate();
                                  debugPrint(_formKey.currentState?.value.toString());

                                  // On another side, can access all field values without saving form with instantValues
                                  _formKey.currentState?.validate();
                                  debugPrint(_formKey.currentState?.instantValue.toString());
                                },
                                child: const Text('Login',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600,fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have account?"),
                          SizedBox(width: 5,),
                          GestureDetector(onTap: (){
                            if (Theme.of(context).platform == TargetPlatform.iOS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context) => const SignInScreen()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignInScreen()),
                              );
                            }
                          }, child: const Text("Create one",style: TextStyle(color: Colors.blue))),
                        ],
                      )
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