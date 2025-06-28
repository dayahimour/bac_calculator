// lib/report_screen.dart

import 'package:flutter/material.dart';
import 'main.dart';           // لتعريف Subject
import 'majors_screen.dart'; // إن كنت تحتاج زر التخصصات

class ReportScreen extends StatelessWidget {
  final String fieldName;
  final List<Subject> subjects;

  const ReportScreen({
    Key? key,
    required this.fieldName,
    required this.subjects,
  }) : super(key: key);

  Widget _cell(String text,
      {bool bold = false, Color? color, double fontSize = 12}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color ?? Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayed = subjects.where((s) => s.coefficient > 0).toList();
    final totalCoeffs = displayed.fold(0, (sum, s) => sum + s.coefficient);
    final totalScore =
        displayed.fold(0.0, (sum, s) => sum + s.grade * s.coefficient);
    final averageStr = totalCoeffs > 0
        ? (totalScore / totalCoeffs).toStringAsFixed(2)
        : '0.00';
    final avgValue = double.tryParse(averageStr) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('كشف النقاط'),
        centerTitle: true,
        backgroundColor: const Color(0xFF14b8a6),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // الشعار واسم الشعبة
              Image.asset('assets/logo.png', width: 50, height: 50),
              const SizedBox(height: 8),
              Text(fieldName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // ===== جدول مصغَّر أفقيًّا + تمرير عمودي =====
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    // يجعل الجدول دائماً على الأقل بعرض الشاشة
                    constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width),
                    child: SingleChildScrollView(
                      // للتمرير عمودي إذا زادت الصفوف
                      scrollDirection: Axis.vertical,
                      child: Table(
                        border:
                            TableBorder.all(color: Colors.black26, width: 1),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                          3: FlexColumnWidth(1),
                        },
                        children: [
                          // رأس الجدول
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xFFe2e8f0)),
                            children: [
                              _cell('المادة', bold: true),
                              _cell('المعامل', bold: true),
                              _cell('العلامة/20', bold: true),
                              _cell('المجموع', bold: true),
                            ],
                          ),
                          // بيانات المواد
                          for (var s in displayed)
                            TableRow(children: [
                              _cell(s.name),
                              _cell('${s.coefficient}'),
                              _cell(s.grade.toStringAsFixed(2)),
                              _cell((s.grade * s.coefficient)
                                  .toStringAsFixed(2)),
                            ]),
                          // المجموع الكلي
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xFFf1f5f9)),
                            children: [
                              _cell('المجموع الكلي', bold: true),
                              _cell('$totalCoeffs', bold: true),
                              const SizedBox(),
                              _cell(totalScore.toStringAsFixed(2),
                                  bold: true),
                            ],
                          ),
                          // المعدل العام
                          TableRow(
                            decoration: const BoxDecoration(
                                color: Color(0xFFc6f6d5)),
                            children: [
                              _cell('المعدل العام',
                                  bold: true,
                                  color: const Color(0xFF22543d)),
                              const SizedBox(),
                              const SizedBox(),
                              _cell('$averageStr',
                                  bold: true,
                                  color: const Color(0xFF22543d)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              // زر التخصصات (إن أردت)
              ElevatedButton.icon(
                onPressed: () {
                  if (avgValue < 10.0) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('تنبيه'),
                        content: const Text(
                            'المعدل أقل من 10، لا توجد تخصصات متاحة.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('حسناً'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MajorsScreen(
                          fieldName: fieldName,
                          average: avgValue,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.school, color: Colors.white),
                label: const Text(
                  'التخصصات المتاحة',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16a34a),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
