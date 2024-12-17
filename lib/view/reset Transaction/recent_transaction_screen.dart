import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jauhari_dashbord/Helper/color_helper.dart';
import 'package:jauhari_dashbord/common/common_text_widget.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'package:universal_html/html.dart' as html;

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({Key? key}) : super(key: key);

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  // Sample data
  List<Map<String, dynamic>> allData = [
    {'date': DateTime(2024, 12, 10), 'userName': 'John Doe', 'amount': 5000},
    {'date': DateTime(2024, 12, 11), 'userName': 'Jane Smith', 'amount': 10000},
    {
      'date': DateTime(2024, 11, 10),
      'userName': 'Alice Johnson',
      'amount': 7500
    },
    {'date': DateTime(2024, 10, 15), 'userName': 'Bob Brown', 'amount': 3000},
  ];

  List<Map<String, dynamic>> filteredData = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    filteredData = List.from(allData);
  }

  // Filtering logic
  void filterData() {
    setState(() {
      filteredData = allData.where((entry) {
        if (selectedStartDate != null &&
            entry['date'].isBefore(selectedStartDate!)) {
          return false;
        }
        if (selectedEndDate != null &&
            entry['date'].isAfter(selectedEndDate!)) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // Export to Excel
  void exportToExcel() async {
    final excel.Workbook workbook = excel.Workbook();
    final excel.Worksheet sheet = workbook.worksheets[0];

    // Add headers
    sheet.getRangeByName('A1').setText('Date');
    sheet.getRangeByName('B1').setText('User Name');
    sheet.getRangeByName('C1').setText('Amount');

    // Add data
    for (int i = 0; i < filteredData.length; i++) {
      final row = filteredData[i];
      sheet
          .getRangeByIndex(i + 2, 1)
          .setText(DateFormat('dd/MM/yyyy').format(row['date']));
      sheet.getRangeByIndex(i + 2, 2).setText(row['userName']);
      sheet.getRangeByIndex(i + 2, 3).setNumber(row['amount'].toDouble());
    }

    // Save to file
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // Trigger download in Flutter web
    final blob = html.Blob([Uint8List.fromList(bytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'Data.xlsx'
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.containerBgColor,
      appBar: AppBar(
        backgroundColor: ColorHelper.containerBgColor,
        title: CommonText(
          text: "Recent Transactions",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorHelper.brownColor,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: exportToExcel,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        selectedStartDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        filterData();
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorHelper.brownColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: CommonText(
                          text: "Select Start Date",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        selectedEndDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        filterData();
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorHelper.brownColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: CommonText(
                          text: "Select End Date",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedStartDate = null;
                          selectedEndDate = null;
                          filteredData = List.from(allData);
                        });
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorHelper.brownColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: CommonText(
                          text: "Reset Filters",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Text(selectedStartDate != null
                        ? 'Start Date: ${DateFormat('dd/MM/yyyy').format(selectedStartDate!)}'
                        : 'Start Date: Not Selected'),
                    const SizedBox(width: 20),
                    Text(selectedEndDate != null
                        ? 'End Date: ${DateFormat('dd/MM/yyyy').format(selectedEndDate!)}'
                        : 'End Date: Not Selected'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DataTable2(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('Amount')),
              ],
              rows: filteredData.map((row) {
                return DataRow(cells: [
                  DataCell(Text(DateFormat('dd/MM/yyyy').format(row['date']))),
                  DataCell(Text(row['userName'])),
                  DataCell(Text(row['amount'].toString())),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
