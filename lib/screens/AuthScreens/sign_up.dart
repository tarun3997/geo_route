import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/screens/AuthScreens/sign_in.dart';
import 'package:geo_route/server/api/authentication_api.dart';
import 'package:geo_route/utils/navigation_utils.dart';

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
                      const Text("Create Driver account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                                  hintText: "Diver Name",
                                  label: Text("Driver Name"),
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
                                child: const Text('Create Account',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize: 16)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),

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
