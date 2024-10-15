import 'package:flutter/material.dart';
import 'package:geo_route/model/vehicle_table_data.dart';
import 'package:geo_route/server/api/vehicle_repairing_api.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final VehicleRepairingApi vehicleTableApi = VehicleRepairingApi();
  late Future<List<VehicleTableData>> vehicleTableData;

  @override
  void initState() {
    super.initState();
    vehicleTableData = vehicleTableApi.handelVehicleTableData();
  }

  final TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table"),
        elevation: 5,
        shadowColor: Colors.grey,
        centerTitle: true,
      ),
      body: FutureBuilder<List<VehicleTableData>>(
        future: vehicleTableData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          List<VehicleTableData> vehicles = snapshot.data!;

          return TwoDimensionalScrollWidget(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DataTable(
                border: TableBorder.all(color: Colors.black),
                columns: [
                  DataColumn(label: Text('S.No.', style: textStyle)),
                  DataColumn(label: Text('Vehicle', style: textStyle)),
                  DataColumn(label: Text('Driver name', style: textStyle)),
                  DataColumn(label: Text('Km Driven', style: textStyle)),
                  DataColumn(label: Text('Km Limit', style: textStyle)),
                  DataColumn(label: Text('Avg Speed', style: textStyle)),
                  DataColumn(label: Text('Damage', style: textStyle)),
                ],
                rows: List.generate(vehicles.length, (index) {
                  VehicleTableData vehicle = vehicles[index];
                  return DataRow(cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text(vehicle.vehicleNumber)),
                    DataCell(Text(vehicle.vehicleDriverName)),
                    DataCell(Text('${vehicle.vehicleRunKM} KM')),
                    DataCell(Text('${vehicle.vehicleKMLimit} KM')),
                    DataCell(Text('${vehicle.averageSpeed} km/h')),
                    DataCell(Text(vehicle.isVehicleUnderRepairing ? 'Yes' : 'No')),
                  ]);
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TwoDimensionalScrollWidget extends StatelessWidget {
  final Widget child;

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  TwoDimensionalScrollWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 12.0,
      trackVisibility: true,
      interactive: true,
      controller: _verticalController,
      scrollbarOrientation: ScrollbarOrientation.right,
      thumbVisibility: true,
      child: Scrollbar(
        thickness: 12.0,
        trackVisibility: true,
        interactive: true,
        controller: _horizontalController,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        thumbVisibility: true,
        notificationPredicate: (ScrollNotification notif) => notif.depth == 1,
        child: SingleChildScrollView(
          controller: _verticalController,
          child: SingleChildScrollView(
            primary: false,
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: child,
          ),
        ),
      ),
    );
  }
}
