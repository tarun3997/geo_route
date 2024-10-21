import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/server/api/vehicle_api.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> vehicleOption = [
    'Motorcycle',
    'Gypsy',
    'Tom25',
    'ALS',
    'TATRA',
    'WB',
    'BUS',
    'Safari',
    'Scorpio'
  ];
  final List<String> fuelOption = ['Diesel', 'Petrol'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        title: const Text(
          "Add Vehicle",
          style: TextStyle(fontWeight: FontWeight.bold),
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
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Gps Sim Number",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    Material(
                                      elevation: 1,
                                      shadowColor: Colors.grey,
                                      child: FormBuilderTextField(

                                        keyboardType: TextInputType.number,
                                        name: "simNumber",
                                        textCapitalization: TextCapitalization.characters,
                                        inputFormatters: [LengthLimitingTextInputFormatter(10)],

                                        decoration: const InputDecoration(

                                            hintText: "Enter Sim Number",
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: InputBorder.none),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(10,errorText: 'Enter full number')

                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              textFieldDecor(
                                  name: "driverName",
                                  hint: "Enter Driver Name",
                                  text: "Driver Name",
                                  keyboardType: TextInputType.text),
                              textFieldDecor(
                                  name: "vehicleNumber",
                                  hint: "Enter Vehicle Number",
                                  text: "Vehicle Number",
                                  keyboardType: TextInputType.text),
                              textFieldDecor(
                                  name: "vehicleKm",
                                  hint: "Enter Current Vehicle Km",
                                  text: "Vehicle Km",
                                  keyboardType: TextInputType.number),
                              Row(
                                children: [
                                  Expanded(
                                    child: dropDownDecor(
                                        name: "vehicleType",
                                        hint: "Select Vehicle Type",
                                        text: "Vehicle type",
                                        listOption: vehicleOption),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      child: dropDownDecor(
                                          name: "fuelType",
                                          hint: "Fuel Type",
                                          text: "Fuel Type",
                                          listOption: fuelOption)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: textFieldDecor(
                                          name: "setLimit",
                                          hint: "Limit",
                                          text: "Vehicle Limit",
                                          keyboardType: TextInputType.number)),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      child: textFieldDecor(
                                          name: "fuelAmount",
                                          hint: "liter",
                                          text: "Fuel Filled",
                                          keyboardType: TextInputType.number)),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              MaterialButton(
                                elevation: 4,
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                                color: Colors.black,
                                onPressed: () {
                                  if (_formKey.currentState
                                          ?.saveAndValidate() ??
                                      false) {
                                    final form = _formKey.currentState?.fields;
                                    final driverName =
                                        form?['driverName']?.value;
                                    final id = form?['simNumber']?.value;
                                    final vehicleNumber =
                                        form?["vehicleNumber"]?.value;
                                    final vehicleKm = int.parse(form?["vehicleKm"]?.value ?? '0');
                                    final vehicleType =
                                        form?["vehicleType"]?.value;
                                    final fuelType = form?["fuelType"]?.value;
                                    final setLimit = int.parse(form?["setLimit"]?.value ?? '0');
                                    final fuelAmount = double.parse(form?["fuelAmount"]?.value ?? '0');
                                    VehicleApi().handleAddVehicleApi(
                                        context: context,
                                        id: id,
                                        driverName: driverName,
                                        vehicleNumber: vehicleNumber,
                                        vehicleKm: vehicleKm,
                                        vehicleType: vehicleType,
                                        fuelType: fuelType,
                                        setLimit: setLimit,
                                        fuelAmount: fuelAmount
                                    );
                                  }
                                },
                                child: const Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownDecor(
      {required String name,
      required String hint,
      required String text,
      required List<String> listOption}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Material(
          elevation: 3,
          shadowColor: Colors.grey,
          child: FormBuilderDropdown(
            name: name,
            decoration: InputDecoration(
                hintText: hint,
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none),
            items: listOption
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
      ],
    );
  }

  Widget textFieldDecor(
      {required String name,
      required String hint,
      required String text,
      required TextInputType keyboardType}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Material(
            elevation: 1,
            shadowColor: Colors.grey,
            child: FormBuilderTextField(

              keyboardType: keyboardType,
              name: name,
              textCapitalization: TextCapitalization.characters,

              decoration: InputDecoration(

                  hintText: hint,
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
