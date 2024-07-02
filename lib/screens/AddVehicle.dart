import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/widget/Snackbar.dart';


class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        title: const Text("Add Vehicle",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            textFieldDecor("nameOfDriver", "Name of driver"),
                            const SizedBox(height: 10),
                            textFieldDecor("vehicleNumber", "Vehicle number"),
                            const SizedBox(height: 10),
                            textFieldDecor("vehicleType", "Vehicle type"),
                            const SizedBox(height: 10),
                            textFieldDecor("parkingSlotNumber", "Parking slot number"),
                            const SizedBox(height: 40,),
                            MaterialButton(
                              elevation: 4,
                              height: 45,
                              minWidth: MediaQuery.of(context).size.width,
                              color: Colors.black,
                              onPressed: () {
                                showSnackBar(context, Colors.green, "Vehicle add successfully");
                                Navigator.pop(context);
                              },
                              child: const Text('Submit',style:TextStyle(color:Colors.white,fontWeight:FontWeight.w600,fontSize: 16)),
                            )
                          ],
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget textFieldDecor(String name, String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Material(
          elevation: 3,
          shadowColor: Colors.grey,
          child: FormBuilderTextField(
            name: name,
            decoration: InputDecoration(
              hintText: text,
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
      ],
    );
  }
}

