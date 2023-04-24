// import 'package:flutter/material.dart';

// class StudentDashboard extends StatelessWidget {
//   const StudentDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Dashboard'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             _buildHeader(context),
//             const SizedBox(height: 20),
//             _buildCourses(context),
//             const SizedBox(height: 20),
//             _buildGrades(context),
//             const SizedBox(height: 20),
//             _buildAttendance(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             backgroundImage: AssetImage('assets/images/profile.jpg'),
//             radius: 40,
//           ),
//           const SizedBox(width: 20),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'John Doe',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               Text(
//                 'Computer Science',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCourses(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Courses',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 10),
//           _buildCourseCard(context, 'Programming I', 'A', Colors.green),
//           const SizedBox(height: 10),
//           _buildCourseCard(context, 'Database Systems', 'B', Colors.orange),
//           const SizedBox(height: 10),
//           _buildCourseCard(context, 'Operating Systems', 'B+', Colors.blue),
//         ],
//       ),
//     );
//   }

//   Widget _buildCourseCard(
//       BuildContext context, String name, String grade, Color color) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               name,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             CircleAvatar(
//               backgroundColor: color,
//               child: Text(
//                 grade,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGrades(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Grades',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 10),
//           _buildGradeRow(context, 'Exam 1', 'A'),
//           const SizedBox(height: 10),
//           _buildGradeRow(context, 'Exam 2', 'B+'),
//           const SizedBox(height: 10),
//           _buildGradeRow(context, 'Final Exam', 'A-'),
//         ],
//       ),
//     );
//   }

//   Widget _buildGradeRow(BuildContext context, String name, String grade) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           name,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         Text(
//           grade,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ],
//     );
//   }

//   Widget _buildAttendance(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Attendance',
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           const SizedBox(height: 10),
//           _buildAttendanceRow(context, 'Class 1', 'Present'),
//           const SizedBox(height: 10),
//           _buildAttendanceRow(context, 'Class 2', 'Absent'),
//           const SizedBox(height: 10),
//           _buildAttendanceRow(context, 'Class 3', 'Present'),
//         ],
//       ),
//     );
//   }

//   Widget _buildAttendanceRow(BuildContext context, String name, String status) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           name,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         Text(
//           status,
//           style: TextStyle(
//             color: status == 'Present' ? Colors.green : Colors.red,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }











import 'package:flutter/material.dart';

class FacultyDashboard extends StatelessWidget {
  const FacultyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildCourseList(context),
            const SizedBox(height: 20),
            _buildAssignmentList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile_pic.png'),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. John Doe',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Computer Science Department',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCourseList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Courses',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        _buildCourseCard(context, 'Mobile App Development', 'CSC 410'),
        const SizedBox(height: 10),
        _buildCourseCard(context, 'Database Systems', 'CSC 320'),
        const SizedBox(height: 10),
        _buildCourseCard(context, 'Artificial Intelligence', 'CSC 510'),
      ],
    );
  }

  Widget _buildCourseCard(
      BuildContext context, String courseName, String courseCode) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(courseName),
        subtitle: Text(courseCode),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to course details page
        },
      ),
    );
  }

  Widget _buildAssignmentList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assignments',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        _buildAssignmentRow(context, 'Mobile App Development', 'Project Proposal',
            'Due 4/30/2023'),
        const SizedBox(height: 10),
        _buildAssignmentRow(context, 'Database Systems', 'Normalization Exercises',
            'Due 5/5/2023'),
        const SizedBox(height: 10),
        _buildAssignmentRow(context, 'Artificial Intelligence', 'Neural Networks',
            'Due 5/12/2023'),
      ],
    );
  }

  Widget _buildAssignmentRow(BuildContext context, String courseName,
      String assignmentName, String dueDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              assignmentName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Text(
          dueDate,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
