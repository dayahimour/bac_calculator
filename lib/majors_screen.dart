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
    // إيجاد أقرب معدل متاح في القاعدة
    final majorsByField = availableMajors[fieldName];
    final availableKeys = majorsByField?.keys.toList() ?? [];
    double closestKey = 10.0;

    for (var key in availableKeys) {
      if (average >= key) {
        closestKey = key;
      }
    }

    final majors = majorsByField?[closestKey] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('التخصصات المحتملة لمعدل $average - شعبة $fieldName'),
        centerTitle: true,
        backgroundColor: const Color(0xFF16a34a), // أخضر جذاب
      ),
      body: majors.isEmpty
          ? const Center(
              child: Text(
                'لا توجد تخصصات متاحة لهذا المعدل.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: majors.length,
                itemBuilder: (context, index) {
                  final major = majors[index];
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
