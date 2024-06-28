import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


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
              height: MediaQuery.of(context).size.height/4.2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      const Text("Create your account",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Sign In to continue"),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'username',
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "username",
                                    label: Text("Username"),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
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
                                    label: Text("Password"),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'conform password',
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "conform password",
                                    label: Text("Conform Password"),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              ),
                              SizedBox(height: 20,),
                              MaterialButton(
                                color: Colors.black,
                                height: 40,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  // Validate and save the form values
                                  _formKey.currentState?.saveAndValidate();
                                  debugPrint(_formKey.currentState?.value.toString());

                                  // On another side, can access all field values without saving form with instantValues
                                  _formKey.currentState?.validate();
                                  debugPrint(_formKey.currentState?.instantValue.toString());
                                },
                                child: const Text('Login',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have a account?"),
                          SizedBox(width: 5,),
                          GestureDetector(onTap: (){
                            Navigator.pop(context);
                          }, child: const Text("Login",style: TextStyle(color: Colors.blue))),
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
