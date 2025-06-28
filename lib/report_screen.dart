import 'package:flutter/material.dart';
import 'majors_screen.dart';
import 'main.dart'; // غيّر المسار حسب مكان تعريف Subject

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
    final totalCoeffs = displayed.fold<int>(0, (sum, s) => sum + s.coefficient);
    final totalScore = displayed.fold<double>(
      0.0,
      (sum, s) => sum + s.grade * s.coefficient,
    );
    final average = totalCoeffs > 0
        ? (totalScore / totalCoeffs).toStringAsFixed(2)
        : '0.00';

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
              Image.asset('assets/logo.png', width: 60, height: 60),
              const SizedBox(height: 8),
              Text(
                fieldName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Center(
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          const Color(0xFFe2e8f0),
                        ),
                        columns: const [
                          DataColumn(label: Text('المادة')),
                          DataColumn(label: Text('المعامل')),
                          DataColumn(label: Text('العلامة / 20')),
                          DataColumn(label: Text('المجموع')),
                        ],
                        rows: [
                          ...displayed.map((s) => DataRow(cells: [
                                DataCell(Text(s.name)),
                                DataCell(Text('${s.coefficient}')),
                                DataCell(Text(s.grade.toStringAsFixed(2))),
                                DataCell(Text(
                                    (s.grade * s.coefficient).toStringAsFixed(2))),
                              ])),
                          DataRow(
                            color: MaterialStateProperty.all(
                              const Color(0xFFf1f5f9),
                            ),
                            cells: [
                              const DataCell(Text(
                                'المجموع الكلي',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataCell(Text(
                                '$totalCoeffs',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )),
                              const DataCell(Text('')),
                              DataCell(Text(
                                totalScore.toStringAsFixed(2),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.all(
                              const Color(0xFFc6f6d5),
                            ),
                            cells: [
                              const DataCell(Text(
                                'المعدل العام',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF22543d),
                                ),
                              )),
                              const DataCell(Text('')),
                              const DataCell(Text('')),
                              DataCell(Text(
                                '$average / 20',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF22543d),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // زر التخصصات المتاحة
              ElevatedButton.icon(
                onPressed: () {
                  final avg = double.tryParse(average) ?? 0.0;

                  if (avg < 10.0) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('تنبيه'),
                        content:
                            const Text('المعدل أقل من 10، لا توجد تخصصات متاحة.'),
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
                          average: avg,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.school, color: Colors.white),
                label: const Text(
                  'التخصصات المتاحة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16a34a),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
