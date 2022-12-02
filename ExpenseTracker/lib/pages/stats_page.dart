import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:budget_tracker_ui/widget/chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fl_chart/fl_chart.dart';

import '../json/budget_json.dart';
import '../json/daily_json.dart';

class StatsPage extends StatefulWidget {
  StatsPage(RootApp rootApp){
  }

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int activeDay = 3;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": "Income",
        "cost": "\$"+getTotalIncome().toString(),
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": "Expense",
        "cost": "\$"+getTotalAmount().toString(),
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stats",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Icon(AntDesign.search1)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: List.generate(months.length, (index) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             activeDay = index;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: (MediaQuery.of(context).size.width - 40) / 6,
                  //           child: Column(
                  //             children: [
                  //               Text(
                  //                 months[index]['label'],
                  //                 style: TextStyle(fontSize: 10),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Container(
                  //                 decoration: BoxDecoration(
                  //                     color: activeDay == index
                  //                         ? primary
                  //                         : black.withOpacity(0.02),
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     border: Border.all(
                  //                         color: activeDay == index
                  //                             ? primary
                  //                             : black.withOpacity(0.1))),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                       left: 12, right: 12, top: 7, bottom: 7),
                  //                   child: Text(
                  //                     months[index]['day'],
                  //                     style: TextStyle(
                  //                         fontSize: 10,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: activeDay == index
                  //                             ? white
                  //                             : black),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net balance",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$"+getNetBalance().toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    //for marking
                    // Positioned(
                    //   bottom: 0,
                    //   child: Container(
                    //     width: (size.width - 20),
                    //     height: 150,
                    //     child: LineChart(
                    //       mainData(),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: expenses[index]['color']),
                          child: Center(
                              child: Icon(
                            expenses[index]['icon'],
                            color: white,
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              expenses[index]['cost'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }

 double getTotalAmount() {

    double total=0;
    for(int i=0;i<daily.length;i++){
      var amount=daily[i]['price'].toString().substring(1,daily[i]['price'].toString().length-1);
      total=total+double.parse(amount);
      print(total);
    }
    // print(total.toString());
    return total;
  }

  double getTotalIncome() {
    double total=0;
    for(int i=0;i<budget_json.length;i++){
      var amount=budget_json[i]['price'].toString().substring(1,budget_json[i]['price'].toString().length-1);
      total=total+double.parse(amount);
      print(total);
    }
    // print(total.toString());
    return total;
  }

  double getNetBalance() {
    var expense=getTotalAmount();
    var income=getTotalIncome();
    return income-expense;
  }
}