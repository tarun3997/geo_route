import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/screens/AuthScreens/SignIn.dart';
import 'package:geo_route/server/api/authenticationApi.dart';

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
                      const SizedBox(height: 10,),
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
                              const SizedBox(height: 20,),
                              MaterialButton(
                                color: Colors.black,
                                height: 40,
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  if(_formKey.currentState?.saveAndValidate() ?? false){
                                    final name = _formKey.currentState?.fields['username']?.value;
                                    final email = _formKey.currentState?.fields['email']?.value;
                                    final password = _formKey.currentState?.fields['password']?.value;

                                    Authentication().handelUserRegistration(name, email, password, context);

                                  }
                                },
                                child: const Text('Sign Up',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have a account?"),
                          const SizedBox(width: 5,),
                          GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                          }, child: const Text("Log In",style: TextStyle(color: Colors.blue))),
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
