import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesReportScreen extends StatelessWidget {
  SalesReportScreen({Key? key}) : super(key: key);
  final OrderController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    DateTimeRange? date;
    _controller.getAllOrder();
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
                                child: Text("All"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Today"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("This Week"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                child: Text("This Month"),
                                value: 4,
                              )
                            ],
                            onChanged: (v) {
                              print(v);
                            }),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        date = await pickDateRange(context);
                        print(date);
                      },
                      icon: const Icon(Icons.calendar_month)),
                ],
              ),
              Expanded(
                child: GetBuilder<OrderController>(
                  builder: (controller) {
                    return DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        columns: const [
                          DataColumn2(
                            label: Text('Sl No'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('Order Id'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Text('User Id'),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: Text('Payment'),
                          ),
                          DataColumn2(
                            label: Text('Amount'),
                            size: ColumnSize.M,
                            // numeric: true,
                          ),
                          DataColumn2(
                            label: Text('Date'),
                            size: ColumnSize.M,
                            // numeric: true,
                          ),
                        ],
                        rows: List<DataRow>.generate(controller.allOrder.length,
                            (index) {
                          final order = controller.allOrder[index];
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(
                              order.orderId!,
                              overflow: TextOverflow.ellipsis,
                            )),
                            DataCell(Text(
                              order.userId!,
                              overflow: TextOverflow.ellipsis,
                            )),
                            DataCell(Text(order.payment)),
                            DataCell(Text('₹ ${order.totalPrice}')),
                            DataCell(Text(
                              order.createdDate.toString(),
                              overflow: TextOverflow.ellipsis,
                            )),
                          ]);
                        }));
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future<DateTimeRange?> pickDateRange(BuildContext context) async {
    DateTimeRange? date = await showDateRangePicker(
        context: context, firstDate: DateTime(2022), lastDate: DateTime(2050));
    return date;
  }
}
