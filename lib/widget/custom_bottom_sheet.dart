import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geo_route/server/api/vehicle_repairing_api.dart';
import 'package:geo_route/utils/error_handler.dart';
import 'package:geo_route/widget/custom_button.dart';

class CustomBottomSheet {
  static Future repairBottomSheet({required BuildContext context, required String id}) {
    final repairFormKey = GlobalKey<FormBuilderState>();

    return showModalBottomSheet(
      clipBehavior: Clip.hardEdge,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Submit for Repair",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: const Color(0xff363333),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    FormBuilder(
                      key: repairFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            FormBuilderDropdown<String>(
                              name: 'reason',
                              decoration: const InputDecoration(
                                labelText: 'Reason for Repair',
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'R1',
                                  child: Text('R1'),
                                ),
                                DropdownMenuItem(
                                  value: 'R2',
                                  child: Text('R2'),
                                ),
                                DropdownMenuItem(
                                  value: 'R3',
                                  child: Text('R3'),
                                ),
                                DropdownMenuItem(
                                  value: 'Other',
                                  child: Text('Other'),
                                ),
                              ],
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'damagePart',
                              decoration: const InputDecoration(
                                hintText: "Enter Damage Part",
                                label: Text("Enter Damage Part"),
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
                              name: 'description',
                              decoration: const InputDecoration(
                                hintText: "Enter detail for repair",
                                label: Text("Enter detail for repair"),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              title: "Submit",
                              onTap: () {
                                if (repairFormKey.currentState?.saveAndValidate() ?? false) {
                                  final formData = repairFormKey.currentState?.value;

                                  final String vehicleReason = formData?['reason'];
                                  final String damagePart = formData?['damagePart'];
                                  final String description = formData?['description'];

                                  VehicleRepairingApi().addRepairingData(
                                    vehicleId: id,
                                    vehicleReason: vehicleReason,
                                    description: description,
                                    damagePart: damagePart,
                                    context: context,
                                  );
                                } else {
                                  ErrorHandler().showError(context, "Form is invalid!");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
