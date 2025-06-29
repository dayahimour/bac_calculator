// lib/main.dart

import 'package:flutter/material.dart';
import 'report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

void main() => runApp(const BacCalculatorApp());

class BacCalculatorApp extends StatelessWidget {
  const BacCalculatorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        title: 'حساب معدل البكالوريا',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Roboto'),
        home: const BacHomePage(),
      ),
    );
  }
}

class Subject {
  String name;
  int coefficient;
  double grade;
  TextEditingController controller;
  Subject({
    required this.name,
    required this.coefficient,
    this.grade = 0,
  }) : controller = TextEditingController();
}

class FieldInfo {
  final IconData icon;
  final Color color;
  final List<Subject> subjects;
  const FieldInfo({
    required this.icon,
    required this.color,
    required this.subjects,
  });
}

final Map<String, FieldInfo> fields = {
  'علوم تجريبية': FieldInfo(
    icon: Icons.science,
    color: Color(0xFF3b82f6),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 3),
      Subject(name: 'اللغة الفرنسية', coefficient: 2),
      Subject(name: 'اللغة الإنجليزية', coefficient: 2),
      Subject(name: 'الرياضيات', coefficient: 5),
      Subject(name: 'العلوم الفيزيائية', coefficient: 5),
      Subject(name: 'علوم الطبيعة و الحياة', coefficient: 6),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 2),
      Subject(name: 'الفلسفة', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
  'رياضيات': FieldInfo(
    icon: Icons.calculate,
    color: Color(0xFF6366f1),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 3),
      Subject(name: 'اللغة الفرنسية', coefficient: 2),
      Subject(name: 'اللغة الإنجليزية', coefficient: 2),
      Subject(name: 'الرياضيات', coefficient: 7),
      Subject(name: 'العلوم الفيزيائية', coefficient: 6),
      Subject(name: 'العلوم الطبيعية', coefficient: 2),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 2),
      Subject(name: 'الفلسفة', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
  'تقني رياضي': FieldInfo(
    icon: Icons.settings,
    color: Color(0xFF10b981),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 2),
      Subject(name: 'اللغة الفرنسية', coefficient: 2),
      Subject(name: 'اللغة الإنجليزية', coefficient: 2),
      Subject(name: 'الرياضيات', coefficient: 6),
      Subject(name: 'العلوم الفيزيائية', coefficient: 6),
      Subject(name: 'التكنولوجيا', coefficient: 7),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 2),
      Subject(name: 'الفلسفة', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
  'تسيير و اقتصاد': FieldInfo(
    icon: Icons.attach_money,
    color: Color(0xFFf59e0b),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 3),
      Subject(name: 'اللغة الفرنسية', coefficient: 2),
      Subject(name: 'اللغة الإنجليزية', coefficient: 2),
      Subject(name: 'الرياضيات', coefficient: 5),
      Subject(name: 'العلوم الاقتصادية', coefficient: 5),
      Subject(name: 'المحاسبة', coefficient: 6),
      Subject(name: 'القانون', coefficient: 2),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 4),
      Subject(name: 'الفلسفة', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
  'لغات أجنبية': FieldInfo(
    icon: Icons.translate,
    color: Color(0xFFec4899),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 5),
      Subject(name: 'اللغة الفرنسية', coefficient: 5),
      Subject(name: 'اللغة الإنجليزية', coefficient: 5),
      Subject(name: 'اللغة الأجنبية الثالثة', coefficient: 4),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 3),
      Subject(name: 'الرياضيات', coefficient: 2),
      Subject(name: 'الفلسفة', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
  'آداب و فلسفة': FieldInfo(
    icon: Icons.menu_book,
    color: Color(0xFF8b5cf6),
    subjects: [
      Subject(name: 'اللغة العربية', coefficient: 6),
      Subject(name: 'اللغة الفرنسية', coefficient: 3),
      Subject(name: 'اللغة الإنجليزية', coefficient: 3),
      Subject(name: 'العلوم الإسلامية', coefficient: 2),
      Subject(name: 'التاريخ و الجغرافيا', coefficient: 4),
      Subject(name: 'الفلسفة', coefficient: 6),
      Subject(name: 'الرياضيات', coefficient: 2),
      Subject(name: 'اللغة الأمازيغية', coefficient: 0),
      Subject(name: 'التربية البدنية', coefficient: 1),
    ],
  ),
};





/// مُنسّق يُضبط القيمة القصوى إلى [max]
class MaxValueTextInputFormatter extends TextInputFormatter {
  final num max;
  MaxValueTextInputFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // جرّب تحويل النص إلى رقم
    final num? value = num.tryParse(newValue.text);
    if (value == null) {
      // إذا لم يكن رقماً صالحاً، ارجع للقيمة السابقة
      return oldValue;
    }
    if (value <= max) {
      return newValue;          // إذا أقل من الحد أو يساويه، اتركه
    }
    // إذا فوق الحد، استخدم النص الممثّل للحد
    final String maxText = max.toString();
    return TextEditingValue(
      text: maxText,
      selection: TextSelection.collapsed(offset: maxText.length),
    );
  }
}

class BacHomePage extends StatefulWidget {
  const BacHomePage({super.key});
  @override
  State<BacHomePage> createState() => _BacHomePageState();
}

class _BacHomePageState extends State<BacHomePage> {
  String? selectedField;
  List<Subject> subjects = [];

  // عند اختيار الشعبة: اضبط معامل الأمازيغية إلى 0 والبدنية إلى 1
  void selectField(String field) {
    selectedField = field;
    subjects = List.from(fields[field]!.subjects);
    for (var s in subjects) {
      if (s.name == 'اللغة الأمازيغية')    s.coefficient = 0;
      if (s.name == 'التربية البدنية')    s.coefficient = 1;
    }
    setState(() {});
  }

  // عند تغيير العلامة: حدّها ≤ 20
  void updateGrade(int index, String value) {
    final double? g = double.tryParse(value);
    if (g != null) {
      subjects[index].grade = g; // نقّح القيمة لاحقاً بحقل المنسّق
      setState(() {});
    }
  }

  // تحديث معامل المادة
  void updateCoefficient(int index, String value) {
    final int? c = int.tryParse(value);
    if (c != null) {
      subjects[index].coefficient = c;
      setState(() {});
    }
  }

  void resetGrades() {
    for (var s in subjects) {
      s.grade = 0;
      s.controller.clear();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // حساب المجموع والمعدل
    final total = subjects.fold<double>(
        0, (sum, s) => sum + s.grade * s.coefficient);
    final coeffSum = subjects.fold<int>(
        0, (sum, s) => sum + s.coefficient);
    final average = coeffSum > 0
        ? (total / coeffSum).toStringAsFixed(2)
        : '0.00';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: selectedField == null
              ? _buildFieldSelection()
              : _buildGradeEntry(average),
        ),
      ),
    );
  }

  Widget _buildFieldSelection() {
    // واجهة اختيار الشعبة
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF4f46e5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, color: Colors.white, size: 28),
              SizedBox(width: 8),
              Text(
                'اختر شعبة البكالوريا',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 35),
        Expanded(
          child: ListView(
            children: fields.entries.map((entry) {
              return GestureDetector(
                onTap: () => selectField(entry.key),
                child: Container(
                  height: 70,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 22),
                  decoration: BoxDecoration(
                    color: entry.value.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(entry.value.icon,
                          color: Colors.white, size: 36),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGradeEntry(String average) {
    // شاشة إدخال العلامات
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // رأس الصفحة
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () =>
                      setState(() => selectedField = null),
                ),
              ),
              Text(
                'المعدل - $selectedField',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1f2937),
                ),
              ),
            ],
          ),
        ),

        const Divider(
            thickness: 1.5, height: 1.5, color: Color(0xFFcbd5e1)),
        const SizedBox(height: 12),

        // رؤوس الأعمدة
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: const Color(0xFFcbd5e1),
          child: const Row(
            children: [
              Expanded(child: Center(child: Text('المادة', style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(child: Center(child: Text('المعامل', style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(child: Center(child: Text('العلامة', style: TextStyle(fontWeight: FontWeight.bold)))),
              Expanded(child: Center(child: Text('المجموع', style: TextStyle(fontWeight: FontWeight.bold)))),
            ],
          ),
        ),
        const SizedBox(height: 6),

        // قائمة المواد
        Expanded(
          child: ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, i) {
              final s = subjects[i];
              final editableCoeff = s.name == 'اللغة الأمازيغية' ||
                  s.name == 'التربية البدنية';

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    // اسم المادة
                    Expanded(
                      child: Text(s.name, textAlign: TextAlign.center),
                    ),

                    // حقل تعديل المعامل للأمازيغية والبدنية
                    Expanded(
                      child: editableCoeff
                          ? TextField(
                              controller: TextEditingController(
                                  text: s.coefficient > 0
                                      ? s.coefficient.toString()
                                      : ''),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (val) =>
                                  updateCoefficient(i, val),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFe0f2fe),
                                isDense: true,
                                border: OutlineInputBorder(),
                              ),
                            )
                          : Text('${s.coefficient}',
                              textAlign: TextAlign.center),
                    ),

                    // خانة العلامة مع المحددات
                    Expanded(
                      child: TextField(
                        controller: s.controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                          MaxValueTextInputFormatter(20),
                        ],
                        onChanged: (val) => updateGrade(i, val),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFfefce8),
                          isDense: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    // عمود المجموع
                    Expanded(
                      child: Text(
                        (s.grade * s.coefficient).toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // شريط الأزرار السفلي + المعدل الكلّي
        Container(
          margin: const EdgeInsets.only(top: 12, bottom: 24),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF14b8a6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.refresh, color: Colors.white),
                    onPressed: resetGrades,
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.save, color: Colors.white),
                    onPressed: () {
                      if (selectedField != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportScreen(
                              fieldName: selectedField!,
                              subjects: subjects,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Text(
                'المعدل: $average',
                style:
                    const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
