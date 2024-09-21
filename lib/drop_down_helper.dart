import 'package:flutter/material.dart';

class DropDownHelper extends StatefulWidget {
  const DropDownHelper({Key? key}) : super(key: key);

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  List dropDownListCourse = [
    {"title": "Diploma", "value": "de"},
    {"title": "Bachelor's in Engineering", "value": "be"},
  ];

  Map<String, List<Map<String, String>>> branchesByCourse = {
    'de': [
      {"title": "Computer Engineering", "value": "computer"},
      {"title": "Civil Engineering", "value": "civil"},
    ],
    'be': [
      {"title": "Mechanical Engineering", "value": "mechanical"},
      {"title": "Chemical Engineering", "value": "chemical"},
    ],
  };

  String selectedCourseValue = "";
  String selectedBranchValue = "";

  Map<String, Map<String, List<String>>> branchSubjects = {
    'computer': {
      'sem1': ['Math', 'Physics', 'Programming', 'English', 'Mechanics', 'Electrical', 'Workshop', 'Chemistry'],
      'sem2': ['Math II', 'Data Structures', 'Digital Logic', 'Electronics', 'OOP', 'Ethics', 'Software Tools', 'Engineering Drawing'],
    },
    'civil': {
      'sem1': ['Math', 'Physics', 'Mechanics', 'Chemistry', 'Drawing', 'Surveying', 'Materials', 'Geology'],
      'sem2': ['Math II', 'Fluid Mechanics', 'Structural Analysis', 'Geotechnical Engineering', 'Transportation', 'Concrete Technology', 'Hydraulics', 'Surveying II'],
    },
    'mechanical': {
      'sem1': ['Math', 'Physics', 'Chemistry', 'Engineering Mechanics', 'Workshop', 'Thermodynamics', 'Machine Drawing', 'Mechanics of Materials'],
      'sem2': ['Math II', 'Fluid Mechanics', 'Engineering Materials', 'Production Engineering', 'Kinematics', 'Thermal Engineering', 'Metrology', 'Vibrations'],
    },
    'chemical': {
      'sem1': ['Math', 'Physics', 'Chemistry', 'Engineering Drawing', 'Thermodynamics', 'Process Calculations', 'Fluid Mechanics', 'Organic Chemistry'],
      'sem2': ['Physical Chemistry', 'Reaction Engineering', 'Material Science', 'Chemical Process Principles', 'Mass Transfer', 'Instrumentation', 'Heat Transfer', 'Industrial Safety'],
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pariksha Madad Kendra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            DropdownButton<String>(
              value: selectedCourseValue,
              isDense: true,
              isExpanded: true,
              items: [
                const DropdownMenuItem(
                  child: Text("Select your course"),
                  value: "",
                ),
                ...dropDownListCourse.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                    child: Text(e['title']),
                    value: e['value'],
                  );
                }).toList(),
              ],
              onChanged: (newValue) {
                setState(() {
                  selectedCourseValue = newValue!;
                  selectedBranchValue = ""; // Reset branch selection
                });
              },
            ),
            const SizedBox(height: 20),
            if (selectedCourseValue.isNotEmpty)
              DropdownButton<String>(
                value: selectedBranchValue,
                isDense: true,
                isExpanded: true,
                items: [
                  const DropdownMenuItem(
                    child: Text("Select your branch"),
                    value: "",
                  ),
                  ...branchesByCourse[selectedCourseValue]!.map<DropdownMenuItem<String>>((e) {
                    return DropdownMenuItem(
                      child: Text(e['title']!),
                      value: e['value'],
                    );
                  }).toList(),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedBranchValue = newValue!;
                  });
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("Submit"),
            ),
            const SizedBox(height: 20),
            if (selectedBranchValue.isNotEmpty)
              ...List.generate(8, (index) {
                String sem = 'sem${index + 1}';
                List<String>? subjects = branchSubjects[selectedBranchValue]?[sem];

                // Create a display list ensuring 8 items
                List<String> displaySubjects = subjects != null
                    ? List.from(subjects)
                    : List.filled(8, ''); // Ensure 8 slots

                // Fill with empty strings if needed
                while (displaySubjects.length < 8) {
                  displaySubjects.add(''); // Fill with empty strings to make up to 8
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center( // Center the semester title
                        child: Text(
                          'Semester ${index + 1}',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center( // Center the table
                        child: Table(
                          border: TableBorder.all(
                            color: Colors.blueAccent,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(40),  // Sr No column width
                            1: FixedColumnWidth(180), // Subject Name column width
                            2: FixedColumnWidth(100),  // Content column width
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors.blue[100]), // Header color
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('Sr No', style: const TextStyle(fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('Subject Name', style: const TextStyle(fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: Text('Content', style: const TextStyle(fontWeight: FontWeight.bold))),
                                ),
                              ],
                            ),
                            ...List.generate(displaySubjects.length, (subjectIndex) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('${subjectIndex + 1}')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text(displaySubjects[subjectIndex].isEmpty ? 'N/A' : displaySubjects[subjectIndex])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(child: Text('N/A')), // Placeholder for content
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
