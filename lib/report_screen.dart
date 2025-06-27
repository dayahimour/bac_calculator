// lib/report_screen.dart

import 'package:flutter/material.dart';
import 'main.dart'; // أو المسار الصحيح لتعريف Subject

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
    // صرف المواد بمعامل > 0
    final displayed = subjects.where((s) => s.coefficient > 0).toList();

    // حساب المجاميع
    final int totalCoeffs =
        displayed.fold(0, (sum, s) => sum + s.coefficient);
    final double totalScore =
        displayed.fold(0.0, (sum, s) => sum + s.grade * s.coefficient);
    final String average = totalCoeffs > 0
        ? (totalScore / totalCoeffs).toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF14b8a6),
        centerTitle: true,
        title: const Text('كشف النقاط'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // شعار التطبيق
            Center(
              child: Image.asset(
                'assets/logo.png',
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            // اسم الشعبة
            Text(
              fieldName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // جدول الكشف
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.symmetric(
                    inside: const BorderSide(color: Colors.black26, width: 1),
                    outside: const BorderSide(color: Colors.black54, width: 1),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(3), // المادة
                    1: FlexColumnWidth(1), // المعامل
                    2: FlexColumnWidth(1), // العلامة
                    3: FlexColumnWidth(1), // المجموع
                  },
                  children: [
                    // رأس الجدول
                    const TableRow(
                      decoration: BoxDecoration(color: Color(0xFFe2e8f0)),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('المادة',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('المعامل',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('العلامة / 20',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('المجموع',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),

                    // بيانات المواد
                    for (var s in displayed)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(s.name,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(s.coefficient.toString(),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(s.grade.toStringAsFixed(2),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                (s.grade * s.coefficient)
                                    .toStringAsFixed(2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),

                    // صف المجموع الكلي مع مجموع المعاملات
                    TableRow(
                      decoration:
                          const BoxDecoration(color: Color(0xFFf1f5f9)),
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('المجموع الكلي',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(totalCoeffs.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(totalScore.toStringAsFixed(2),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),

                    // صف المعدل العام (مميز)
                    TableRow(
                      decoration:
                          const BoxDecoration(color: Color(0xFFc6f6d5)),
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text('المعدل العام',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF22543d))),
                          ),
                        ),
                        const SizedBox(),
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text('$average / 20',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xFF22543d))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
