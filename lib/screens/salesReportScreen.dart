import 'package:admin_plantshopee/constance/constance.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class SalesReportScreen extends StatelessWidget {
  const SalesReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: appBarColor,
          centerTitle: true,
          title: const Text('Sales Report'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          // alignment: AlignmentDirectional.centerEnd,
                          hint: const Text(
                            'All',
                            style: subHeading,
                          ),
                          items: const [
                            DropdownMenuItem(
                              child: Text("Today"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("This Week"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("This Month"),
                              value: 3,
                            )
                          ],
                          onChanged: (v) {}),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.calendar_month)),
              ],
            ),
              Expanded(
                child: DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: Text('Sl No'),
                        size: ColumnSize.S,
                      ),
                      DataColumn(
                        label: Text('Order Id'),
                      ),
                      DataColumn(
                        label: Text('User Id'),
                      ),
                      DataColumn(
                        label: Text('Payment'),
                      ),
                      DataColumn2(
                        label: Text('Amount'),
                        size: ColumnSize.S,
                        // numeric: true,
                      ),
                      DataColumn(
                        label: Text('Date'),
                        // numeric: true,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                        50,
                        (index) => const DataRow(cells: [
                              DataCell(Text('1')),
                              DataCell(Text('12345678')),
                              DataCell(Text('0987654332')),
                              DataCell(Text('RazorPay')),
                              DataCell(Text('₹ 799')),
                              DataCell(Text('30-03-2021')),
                            ]))),
              ),
            ],
          ),
        ));
  }
}
