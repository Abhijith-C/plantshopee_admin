import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/controller/order_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesReportScreen extends StatelessWidget {
  SalesReportScreen({Key? key}) : super(key: key);
  final OrderController _controller = Get.find();
  DateTime last24Hours = DateTime.now().subtract(const Duration(days: 1));
  DateTime lastWeek = DateTime.now().subtract(const Duration(days: 7));
  DateTime lastMonth = DateTime.now().subtract(const Duration(days: 30));

  @override
  Widget build(BuildContext context) {
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
                            items: [
                              const DropdownMenuItem(
                                child: Text("All"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: const Text("Today"),
                                value: last24Hours,
                              ),
                              DropdownMenuItem(
                                child: const Text("This Week"),
                                value: lastWeek,
                              ),
                              DropdownMenuItem(
                                child: const Text("This Month"),
                                value: lastMonth,
                              )
                            ],
                            onChanged: (date) {
                              if (date == 1) {
                                _controller.getAllOrder();
                              } else {
                                _controller.sortOrderCustom(date as DateTime);
                              }
                            }),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: ()  {
                       pickDateRange(context);
                      },
                      icon: const Icon(Icons.calendar_month)),
                ],
              ),
             const Divider(thickness: 1,),
              Expanded(
                child: GetBuilder<OrderController>(
                  builder: (controller) {
                    if (controller.isLoading == false) {
                      if (controller.allOrder.isEmpty) {
                      return const Center(
                        child: Text('No Orders Found'),
                      );
                    } else {
                      return DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 900,
                        smRatio: 0.5,
                        lmRatio: 3,
                        columns: const [
                          DataColumn2(
                            label: Center(child: Text('Sl No')),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Center(child: Text('Order Id')),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Center(child: Text('User Id')),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Center(child: Text('Payment')),size: ColumnSize.M
                          ),
                          DataColumn2(
                            label: Center(child: Text('Amount')),
                            size: ColumnSize.M,
                            // numeric: true,
                          ),
                          DataColumn2(
                            label: Center(child: Text('Date')),
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
                    }
                    } else {
                      return const Center(
                    child: CircularProgressIndicator(),
                  );
                    }
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
    _controller.sortOrder(date!.start, date.end);
    return date;
  }
}
