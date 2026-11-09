import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AttendanceDashboard(),
  ));
}

class AttendanceDashboard extends StatefulWidget {
  @override
  State<AttendanceDashboard> createState() =>
      _AttendanceDashboardState();
}

class _AttendanceDashboardState extends State<AttendanceDashboard> {
  List<String> subjects = [
    "Mathematics",
    "Computer Science",
    "English",
    "Database"
  ];

  List<int> total = [20, 25, 20, 15];
  List<int> attended = [18, 20, 16, 12];

  void updateAttendance(int index, bool present) {
    setState(() {
      total[index]++;
      if (present) {
        attended[index]++;
      }
    });
  }

  void clearData() {
    setState(() {
      total = [0, 0, 0, 0];
      attended = [0, 0, 0, 0];
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalClasses = total.reduce((a, b) => a + b);
    int attendedClasses = attended.reduce((a, b) => a + b);

    double percentage = totalClasses == 0
        ? 0
        : attendedClasses / totalClasses * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Overall Attendance",
                        style: TextStyle(fontSize: 20)),

                    SizedBox(height: 10),

                    Text(
                      "${percentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: percentage >= 75
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),

                    LinearProgressIndicator(
                      value: percentage / 100,
                    ),

                    SizedBox(height: 10),

                    Text("Total Classes: $totalClasses"),
                    Text("Classes Attended: $attendedClasses"),

                    Text(
                      percentage >= 75
                          ? "Attendance Eligible"
                          : "Attendance Shortage",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: clearData,
              icon: Icon(Icons.delete),
              label: Text("Clear Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),

            SizedBox(height: 15),

            Text(
              "Subject Wise Attendance",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,

                itemBuilder: (context, index) {
                  double p = total[index] == 0
                      ? 0
                      : attended[index] / total[index] * 100;

                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            subjects[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "${attended[index]} / ${total[index]} Classes",
                          ),

                          LinearProgressIndicator(
                            value: p / 100,
                            color: p >= 75
                                ? Colors.green
                                : Colors.red,
                          ),

                          Text("${p.toStringAsFixed(1)}%"),

                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    updateAttendance(index, true),
                                child: Text("Present"),
                              ),

                              SizedBox(width: 10),

                              ElevatedButton(
                                onPressed: () =>
                                    updateAttendance(index, false),
                                child: Text("Absent"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}