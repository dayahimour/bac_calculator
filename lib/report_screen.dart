// lib/report_screen.dart

import 'package:flutter/material.dart';
import 'main.dart'; // مسار Subject و fields

class ReportScreen extends StatelessWidget {
  final String fieldName;
  final List<Subject> subjects;

  const ReportScreen({
    Key? key,
    required this.fieldName,
    required this.subjects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayed = subjects.where((s) => s.coefficient > 0).toList();
    final int totalCoeffs =
        displayed.fold(0, (sum, s) => sum + s.coefficient);
    final double totalScore =
        displayed.fold(0.0, (sum, s) => sum + s.grade * s.coefficient);
    final String average = totalCoeffs > 0
        ? (totalScore / totalCoeffs).toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      appBar: AppBar(
        title: const Text('كشف النقاط'),
        centerTitle: true,
        backgroundColor: const Color(0xFF14b8a6),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Image.asset('assets/logo.png', width: 60, height: 60),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              fieldName,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          // ↕ تمرير عمودي  ↔ تمرير أفقي + تمديد الجدول لعرض الشاشة
          LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                      const Color(0xFFe2e8f0)),
                  columns: const [
                    DataColumn(
                        label: Center(
                            child: Text('المادة',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text('المعامل',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text('العلامة / 20',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                    DataColumn(
                        label: Center(
                            child: Text('المجموع',
                                style:
                                    TextStyle(fontWeight: FontWeight.bold)))),
                  ],
                  rows: [
                    // مواد
                    ...displayed.map((s) {
                      return DataRow(cells: [
                        DataCell(Center(child: Text(s.name))),
                        DataCell(Center(
                            child: Text(s.coefficient.toString()))),
                        DataCell(Center(
                            child: Text(s.grade.toStringAsFixed(2)))),
                        DataCell(Center(
                            child: Text(
                                (s.grade * s.coefficient)
                                    .toStringAsFixed(2)))),
                      ]);
                    }).toList(),

                    // المجموع الكلي
                    DataRow(
                      color: MaterialStateProperty.all(
                          const Color(0xFFf1f5f9)),
                      cells: [
                        const DataCell(Center(
                            child: Text('المجموع الكلي',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)))),
                        DataCell(Center(
                            child: Text('$totalCoeffs',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)))),
                        const DataCell(Text('')),
                        DataCell(Center(
                            child: Text(totalScore.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)))),
                      ],
                    ),

                    // المعدل العام
                    DataRow(
                      color: MaterialStateProperty.all(
                          const Color(0xFFc6f6d5)),
                      cells: [
                        const DataCell(Center(
                            child: Text('المعدل العام',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF22543d))))),
                        const DataCell(Text('')),
                        const DataCell(Text('')),
                        DataCell(Center(
                            child: Text('$average / 20',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF22543d))))),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
