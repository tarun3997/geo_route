import 'package:flutter/material.dart';

class RepairFormScreen extends StatefulWidget {

  final String id;
  const RepairFormScreen({super.key, required this.id});

  @override
  State<RepairFormScreen> createState() => _RepairFormScreenState();
}

class _RepairFormScreenState extends State<RepairFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit for Repair"),
        centerTitle: true,
        elevation: 5,
      ),
      body: Text("Hello"),
    );
  }
}
