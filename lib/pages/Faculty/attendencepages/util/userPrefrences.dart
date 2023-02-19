// ignore_for_file: file_names, non_constant_identifier_names

import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';

class Faculty {
  final String imagePath;
  final String facultyId;
  final String facultyName;
  final String email;
  final String phoneNo;
  //final NumberInputElement phoneNo;
  final String DOB;
  final String subject;

  bool isActive;

  Faculty({
    required this.imagePath,
    required this.facultyName,
    required this.facultyId,
    required this.email,
    required this.phoneNo,
    required this.subject,
    required this.DOB,
    this.isActive = true,
  });
}

class Student {
  final String studentEnrollmentNo;
  final String studentName;
  final String studentemail;
  final String semester;
  // final String program;
  final String batch;
  // final String branch;
  final String studingInYear;
  bool isActive;

  Student({
    required this.studentEnrollmentNo,
    required this.studentName,
    required this.studentemail,
    required this.semester,
    required this.batch,
    // required this.branch,
    required this.studingInYear,
    // required this.program,
    this.isActive = true,
  });
}

class UserPrefrences {
  static List<Faculty> FacultyList = [
    Faculty(
      imagePath:
          "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png"
      // "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      //"https://source.unsplash.com/featured/?profile"
      ,
      facultyName: "Faculty Name",
      email: "faculty.email@suas.ac.in",
      DOB: '12/12/12',
      phoneNo: '9876987697',
      facultyId: "123",
      subject: "Subject Name",
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[1],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[2],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[3],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[4],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[5],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[6],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[7],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
    Faculty(
      imagePath: "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
      // "https://source.unsplash.com/featured/?profile"
      ,
      facultyName: Faculties[8],
      email: FacultiesEmailID[0],
      DOB: FacultyDOB[0],
      phoneNo: PhoneNo[0],
      facultyId: FacultiesID[0],
      subject: Subject[0],
    ),
  ];

  // UserPrefrences(){

  // for (int i=0 ; i<Faculties.length;i++) {

  // sample = Faculty(
  //   imagePath:
  //   "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg",
  //   //"https://source.unsplash.com/featured/?profile",
  //   facultyName: Faculties[i],
  //   email:"faculty.email@suas.ac.in",
  //   DOB: '12/12/12',
  //   phoneNo: '9876987697',
  //   facultyId: "123",
  //   subject: "Subject Name",
  // ) as List<Faculty>;
  // }
  // }
  static var myUser = Faculty(
    imagePath: "https://www.pavilionweb.com/wp-content/uploads/2017/03/man.png"
    // "https://miro.medium.com/max/1400/0*qfJWOn_IjKoc305B.jpg"
    //"https://source.unsplash.com/featured/?profile"
    ,
    facultyName: "Faculty Name",
    email: "faculty.email@suas.ac.in",
    DOB: '12/12/12',
    phoneNo: '9876987697',
    facultyId: "123",
    subject: "Subject Name",
  );
  static var student = Student(
    studentEnrollmentNo: "2019btcs002",
    studentName: "Raj",
    studentemail: "2019btcs002@@Student.com",
    semester: "V",
    batch: "B1",
    // branch: "C.S.I.T.",
    studingInYear: "3rd",
    // program: "Btech"
  );
  static List<Student> studentlist = [
    Student(
      studentEnrollmentNo: "2019btcs002",
      studentName: "Raj",
      studentemail: "2019btcs002@@Student.com",
      semester: "V",
      batch: "B1",
      // branch: "C.S.I.T.",
      studingInYear: "3rd",
      // program: "Btech"
    ),
    Student(
      studentEnrollmentNo: Enrollment[0],
      studentName: Students[0],
      studentemail: StudentEmail[0],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[1],
      studentName: Students[1],
      studentemail: StudentEmail[1],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[2],
      studentName: Students[2],
      studentemail: StudentEmail[2],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[3],
      studentName: Students[3],
      studentemail: StudentEmail[3],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[4],
      studentName: Students[4],
      studentemail: StudentEmail[4],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[5],
      studentName: Students[5],
      studentemail: StudentEmail[5],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[6],
      studentName: Students[6],
      studentemail: StudentEmail[6],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[7],
      studentName: Students[7],
      studentemail: StudentEmail[7],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[8],
      studentName: Students[8],
      studentemail: StudentEmail[8],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[9],
      studentName: Students[9],
      studentemail: StudentEmail[9],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[10],
      studentName: Students[10],
      studentemail: StudentEmail[10],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[11],
      studentName: Students[11],
      studentemail: StudentEmail[11],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[12],
      studentName: Students[12],
      studentemail: StudentEmail[12],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[13],
      studentName: Students[13],
      studentemail: StudentEmail[13],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
    Student(
      studentEnrollmentNo: Enrollment[14],
      studentName: Students[14],
      studentemail: StudentEmail[14],
      semester: Semester[4],
      batch: Batch[0],
      // branch: Branch[0],
      studingInYear: CollegeYear[0],
      // program: Program[0]
    ),
  ];
}
