import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {

  final List<Map<String, String>> listOfColumns = [
    {"S.No.": "1", "Vehicle": "RJ27TH1010", "Driver name": "Kamal Kumar", "Km Driven": "5680", "Avg mileage": "30", "Damage": "Head light"},
    {"S.No.": "2", "Vehicle": "RJ27TH1011", "Driver name": "Rajesh Verma", "Km Driven": "5890", "Avg mileage": "28", "Damage": "Windshield"},
    {"S.No.": "3", "Vehicle": "RJ27TH1012", "Driver name": "Amit Sharma", "Km Driven": "6100", "Avg mileage": "32", "Damage": "Side mirror"},
    {"S.No.": "4", "Vehicle": "RJ27TH1013", "Driver name": "Sunil Kumar", "Km Driven": "6300", "Avg mileage": "29", "Damage": "Head light"},
    {"S.No.": "5", "Vehicle": "RJ27TH1014", "Driver name": "Manoj Singh", "Km Driven": "6520", "Avg mileage": "31", "Damage": "Windshield"},
    {"S.No.": "6", "Vehicle": "RJ27TH1015", "Driver name": "Rohit Gupta", "Km Driven": "6740", "Avg mileage": "30", "Damage": "Side mirror"},
    {"S.No.": "7", "Vehicle": "RJ27TH1016", "Driver name": "Suresh Meena", "Km Driven": "6950", "Avg mileage": "27", "Damage": "Head light"},
    {"S.No.": "8", "Vehicle": "RJ27TH1017", "Driver name": "Anil Yadav", "Km Driven": "7200", "Avg mileage": "33", "Damage": "Windshield"},
    {"S.No.": "9", "Vehicle": "RJ27TH1018", "Driver name": "Deepak Singh", "Km Driven": "7430", "Avg mileage": "26", "Damage": "Side mirror"},
    {"S.No.": "10", "Vehicle": "RJ27TH1019", "Driver name": "Naveen Kumar", "Km Driven": "7650", "Avg mileage": "28", "Damage": "Head light"},
    {"S.No.": "11", "Vehicle": "RJ27TH1020", "Driver name": "Ajay Chauhan", "Km Driven": "7880", "Avg mileage": "29", "Damage": "Windshield"},
    {"S.No.": "12", "Vehicle": "RJ27TH1021", "Driver name": "Vinod Rathore", "Km Driven": "8100", "Avg mileage": "30", "Damage": "Side mirror"},
    {"S.No.": "13", "Vehicle": "RJ27TH1022", "Driver name": "Mahesh Patil", "Km Driven": "8320", "Avg mileage": "32", "Damage": "Head light"},
    {"S.No.": "14", "Vehicle": "RJ27TH1023", "Driver name": "Vikram Sharma", "Km Driven": "8540", "Avg mileage": "31", "Damage": "Windshield"},
    {"S.No.": "15", "Vehicle": "RJ27TH1024", "Driver name": "Kishan Pal", "Km Driven": "8760", "Avg mileage": "29", "Damage": "Side mirror"},
    {"S.No.": "16", "Vehicle": "RJ27TH1025", "Driver name": "Pradeep Kumar", "Km Driven": "8980", "Avg mileage": "30", "Damage": "Head light"},
    {"S.No.": "17", "Vehicle": "RJ27TH1026", "Driver name": "Tarun Verma", "Km Driven": "9200", "Avg mileage": "28", "Damage": "Windshield"},
    {"S.No.": "18", "Vehicle": "RJ27TH1027", "Driver name": "Ravi Sharma", "Km Driven": "9420", "Avg mileage": "27", "Damage": "Side mirror"},
    {"S.No.": "19", "Vehicle": "RJ27TH1028", "Driver name": "Rakesh Yadav", "Km Driven": "9640", "Avg mileage": "31", "Damage": "Head light"},
    {"S.No.": "20", "Vehicle": "RJ27TH1029", "Driver name": "Mohit Singh", "Km Driven": "9860", "Avg mileage": "33", "Damage": "Windshield"},
    {"S.No.": "21", "Vehicle": "RJ27TH1030", "Driver name": "Ashok Kumar", "Km Driven": "10080", "Avg mileage": "30", "Damage": "Side mirror"},
    {"S.No.": "22", "Vehicle": "RJ27TH1031", "Driver name": "Suraj Pal", "Km Driven": "10300", "Avg mileage": "28", "Damage": "Head light"},
    {"S.No.": "23", "Vehicle": "RJ27TH1032", "Driver name": "Dinesh Sharma", "Km Driven": "10520", "Avg mileage": "27", "Damage": "Windshield"},
    {"S.No.": "24", "Vehicle": "RJ27TH1033", "Driver name": "Rohan Gupta", "Km Driven": "10740", "Avg mileage": "32", "Damage": "Side mirror"},
    {"S.No.": "25", "Vehicle": "RJ27TH1034", "Driver name": "Shyam Kumar", "Km Driven": "10960", "Avg mileage": "30", "Damage": "Head light"},
    {"S.No.": "26", "Vehicle": "RJ27TH1035", "Driver name": "Pawan Verma", "Km Driven": "11180", "Avg mileage": "29", "Damage": "Windshield"},
    {"S.No.": "27", "Vehicle": "RJ27TH1036", "Driver name": "Vikas Sharma", "Km Driven": "11400", "Avg mileage": "28", "Damage": "Side mirror"},
    {"S.No.": "28", "Vehicle": "RJ27TH1037", "Driver name": "Rahul Singh", "Km Driven": "11620", "Avg mileage": "32", "Damage": "Head light"},
    {"S.No.": "29", "Vehicle": "RJ27TH1038", "Driver name": "Gopal Yadav", "Km Driven": "11840", "Avg mileage": "31", "Damage": "Windshield"},
    {"S.No.": "30", "Vehicle": "RJ27TH1039", "Driver name": "Nitin Kumar", "Km Driven": "12060", "Avg mileage": "30", "Damage": "Side mirror"},
  ];
  final TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Table"),
        elevation: 5,
        shadowColor: Colors.grey,
        centerTitle: true,
      ),
      body: TwoDimensionalScrollWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
            border: TableBorder.all(color: Colors.black),
            columns: [
              DataColumn(label: Text('S.No.', style: textStyle,)),
              DataColumn(label: Text('Vehicle', style: textStyle,)),
              DataColumn(label: Text('Driver name', style: textStyle,)),
              DataColumn(label: Text('Km Driven', style: textStyle,)),
              DataColumn(label: Text('Avg mileage', style: textStyle,)),
              DataColumn(label: Text('Damage', style: textStyle,)),
            ],
            rows:
            listOfColumns // Loops through dataColumnText, each iteration assigning the value to element
                .map(
              ((element) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(element["S.No."]!)), //Extracting from Map element the value
                  DataCell(Text(element["Vehicle"]!)),
                  DataCell(Text(element["Driver name"]!)),
                  DataCell(Text(element["Km Driven"]!)), //Extracting from Map element the value
                  DataCell(Text(element["Avg mileage"]!)),
                  DataCell(Text(element["Damage"]!)),
                ],
              )),
            )
                .toList(),
          )
        ),
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