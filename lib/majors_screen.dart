import 'package:flutter/material.dart';
import 'available_majors.dart';

class MajorsScreen extends StatelessWidget {
  final String fieldName;
  final double average;

  const MajorsScreen({
    super.key,
    required this.fieldName,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    final majorsByField = availableMajors[fieldName];

    // تأكد من وجود تخصصات للشعبة
    if (majorsByField == null || majorsByField.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('التخصصات المحتملة لمعدل $average - شعبة $fieldName'),
          centerTitle: true,
          backgroundColor: const Color(0xFF16a34a),
        ),
        body: const Center(
          child: Text(
            'لا توجد تخصصات متاحة لهذه الشعبة.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // ترتيب المفاتيح (المعدلات) من الأكبر إلى الأصغر
    final sortedKeys = majorsByField.keys
        .where((key) => average >= key)
        .toList()
      ..sort((a, b) => b.compareTo(a)); // ترتيب تنازلي

    // جمع كل التخصصات بدءًا من أعلى معدل ممكن
    final allMajors = <String>[];
    for (final key in sortedKeys) {
      final majors = majorsByField[key];
      if (majors != null) {
        for (final major in majors) {
          if (!allMajors.contains(major)) {
            allMajors.add(major);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('التخصصات المحتملة لمعدل $average - شعبة $fieldName'),
        centerTitle: true,
        backgroundColor: const Color(0xFF16a34a),
      ),
      body: allMajors.isEmpty
          ? const Center(
              child: Text(
                'لا توجد تخصصات متاحة لهذا المعدل.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: allMajors.length,
                itemBuilder: (context, index) {
                  final major = allMajors[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: const Color(0xFFecfdf5),
                    child: ListTile(
                      leading: const Icon(Icons.school, color: Color(0xFF047857)),
                      title: Text(
                        major,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF065f46),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
