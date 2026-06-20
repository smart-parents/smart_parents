const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore, FieldValue } = require('firebase-admin/firestore');
const { getAuth } = require('firebase-admin/auth');
const fs = require('fs');
const path = require('path');
// 1. Check for the Firebase service account private key file
const serviceAccountPath = path.join(__dirname, 'serviceAccountKey.json');
if (!fs.existsSync(serviceAccountPath)) {
  console.error('\n======================================================================');
  console.error('Error: "serviceAccountKey.json" was not found in the project root.');
  console.error('======================================================================');
  console.error('To run this script, you must generate a Firebase Service Account key:');
  console.error('  1. Open the Firebase Console (https://console.firebase.google.com).');
  console.error('  2. Go to Project Settings -> Service Accounts.');
  console.error('  3. Click "Generate new private key".');
  console.error('  4. Save the downloaded JSON file as "serviceAccountKey.json" in:');
  console.error(`     ${__dirname}`);
  console.error('  5. Install dependencies: npm install firebase-admin');
  console.error('  6. Run this script again: node sampledata.js');
  console.error('======================================================================\n');
  process.exit(1);
}
const serviceAccount = require(serviceAccountPath);
// Initialize Firebase Admin SDK
initializeApp({
  credential: cert(serviceAccount)
});
const db = getFirestore();
const auth = getAuth();
const adminEmail = 'admin@gmail.com';
const passwordCommon = '123456';
// Helper to format date/time
function formatDate(date, formatStr) {
  // Simple format implementation
  const pad = (num, size = 2) => String(num).padStart(size, '0');
  const d = date.getDate();
  const m = date.getMonth() + 1;
  const y = date.getFullYear();
  const h = date.getHours();
  const min = date.getMinutes();
  const s = date.getSeconds();
  if (formatStr === 'dd-MM-yyyy') {
    return `${pad(d)}-${pad(m)}-${y}`;
  } else if (formatStr === 'dd-MM-yyyy hh:mm:ss') {
    const ampm = h >= 12 ? 'PM' : 'AM';
    const h12 = h % 12 || 12;
    return `${pad(d)}-${pad(m)}-${y} ${pad(h12)}:${pad(min)}:${pad(s)} ${ampm}`;
  } else if (formatStr === 'HH:mm') {
    return `${pad(h)}:${pad(min)}`;
  } else if (formatStr === 'hh:mm a') {
    const ampm = h >= 12 ? 'PM' : 'AM';
    const h12 = h % 12 || 12;
    return `${pad(h12)}:${pad(min)} ${ampm}`;
  }
  return date.toISOString();
}
async function createAuthUser(email, password, uid) {
  try {
    await auth.createUser({
      uid: uid,
      email: email,
      password: password,
      emailVerified: true
    });
  } catch (error) {
    if (error.code !== 'auth/uid-already-exists' && error.code !== 'auth/email-already-in-use') {
      throw error;
    }
  }
}
async function seedData() {
  console.log('\nStarting database seeding...');
  // 1. Create Admin Account
  console.log('Seeding Admin account...');
  await createAuthUser(adminEmail, passwordCommon, adminEmail);
  await db.collection('Admin').doc(adminEmail).set({
    email: adminEmail,
    password: passwordCommon
  });
  await db.collection('Users').doc(adminEmail).set({
    id: adminEmail,
    role: 'admin',
    status: true,
    admin: adminEmail
  });
  // 2. Create Departments
  console.log('Seeding 2 Departments...');
  const departments = [
    { departmentId: '11', name: 'Computer Engineering' },
    { departmentId: '12', name: 'Information Technology' }
  ];
  for (const dept of departments) {
    await db.collection('Admin').doc(adminEmail)
      .collection('department')
      .doc(`${dept.departmentId}_${adminEmail}`)
      .set({
        name: dept.name,
        departmentId: dept.departmentId
      });
  }
  // 3. Create 20 Faculties
  console.log('Seeding 20 Faculties...');
  const faculties = [];
  for (let i = 1; i <= 20; i++) {
    const facultyId = String(1000 + i); // 1001 to 1020
    const name = `Faculty ${i}`;
    const email = `${facultyId}@spf.com`;
    // Odd faculties in CE, Even faculties in IT
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    await createAuthUser(email, passwordCommon, facultyId);
    await db.collection('Admin').doc(adminEmail)
      .collection('faculty')
      .doc(facultyId)
      .set({
        faculty: facultyId,
        name: name,
        password: passwordCommon,
        branch: branch,
        status: true
      });
    await db.collection('Users').doc(facultyId).set({
      id: facultyId,
      role: 'faculty',
      status: true,
      admin: adminEmail
    });
    faculties.push({ id: facultyId, name, branch });
  }
  // 4. Create 20 Students
  console.log('Seeding 20 Students...');
  const students = [];
  for (let i = 1; i <= 20; i++) {
    const studentId = String(123456789000 + i); // 123456789001 to 123456789020
    const name = `Student ${i}`;
    const email = `${studentId}@sps.com`;
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    const batch = '2026';
    await createAuthUser(email, passwordCommon, studentId);
    await db.collection('Admin').doc(adminEmail)
      .collection('students')
      .doc(studentId)
      .set({
        name: name,
        number: studentId,
        password: passwordCommon,
        branch: branch,
        status: true,
        batch: batch
      });
    await db.collection('Users').doc(studentId).set({
      id: studentId,
      role: 'student',
      status: true,
      admin: adminEmail
    });
    students.push({ id: studentId, name, branch, batch });
  }
  // 5. Create 20 Parents
  console.log('Seeding 20 Parents...');
  for (let i = 1; i <= 20; i++) {
    const parentMobile = String(9876543200 + i); // 9876543201 to 9876543220
    const name = `Parent ${i}`;
    const email = `${parentMobile}@spp.com`;
    const child = students[i - 1]; // Link Parent i to Student i
    await createAuthUser(email, passwordCommon, parentMobile);
    await db.collection('Admin').doc(adminEmail)
      .collection('parents')
      .doc(parentMobile)
      .set({
        name: name,
        number: parentMobile,
        password: passwordCommon,
        branch: child.branch,
        child: child.id,
        status: true,
        batch: child.batch
      });
    await db.collection('Users').doc(parentMobile).set({
      id: parentMobile,
      role: 'parents',
      status: true,
      admin: adminEmail
    });
  }
  // 6. Create 20 Subjects
  console.log('Seeding 20 Subjects...');
  const subjects = [];
  for (let i = 1; i <= 20; i++) {
    const subCode = String(1010100 + i); // 1010101 to 1010120
    const subName = `Subject ${i}`;
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    await db.collection('Admin').doc(adminEmail)
      .collection('subject')
      .doc(subCode)
      .set({
        sub_name: subName,
        sub_code: subCode,
        branch: branch
      });
    subjects.push({ code: subCode, name: subName, branch });
  }
  // 7. Create 20 Attendance records
  console.log('Seeding 20 Attendance records...');
  for (let i = 1; i <= 20; i++) {
    const dateStr = `${String(i).padStart(2, '0')}-06-2026`;
    const startStr = '09:00 AM';
    const endStr = '10:00 AM';
    const docId = `${dateStr}_${startStr}_${endStr}`;
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    const batch = '2026';
    const subject = subjects[i - 1].name;
    // Build attendance map for all students in this branch
    const attendanceMap = {};
    students.forEach((student, idx) => {
      if (student.branch === branch) {
        // Deterministic presentation: alternate Present and Absent
        attendanceMap[student.id] = idx % 2 === 0;
      }
    });
    await db.collection('Admin').doc(adminEmail)
      .collection('attendance')
      .doc(docId)
      .set({
        date: dateStr,
        start: startStr,
        end: endStr,
        branch: branch,
        batch: batch,
        subject: subject,
        attendance: attendanceMap
      });
  }
  // 8. Create 20 Fee records
  console.log('Seeding 20 Fee records...');
  for (let i = 1; i <= 20; i++) {
    const student = students[i - 1];
    const sem = String((i % 8) + 1);
    await db.collection('Admin').doc(adminEmail)
      .collection('fees')
      .add({
        number: student.id,
        amount: '5000',
        sem: sem,
        name: student.name,
        date: formatDate(new Date(), 'dd-MM-yyyy hh:mm:ss')
      });
  }
  // 9. Create 20 Exam records and 20 entries in the exam subcollection
  console.log('Seeding 10 Exams, each containing 6 exam schedule sub-documents...');
  for (let i = 1; i <= 10; i++) {
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    const examDoc = await db.collection('Admin').doc(adminEmail)
      .collection('exams')
      .add({
        name: `Exam ${i}`,
        batch: '2026',
        branch: branch,
        photoUrl: 'https://picsum.photos/800/600'
      });
    // Seed 6 schedule entries in the subcollection "exam"
    const examSubRef = examDoc.collection('exam');
    for (let j = 1; j <= 6; j++) {
      await examSubRef.add({
        subject: `Subject ${j}`,
        date: `${String(j).padStart(2, '0')}-07-2026`,
        starttime: '09:00 AM',
        endtime: '12:00 PM'
      });
    }
  }
  // 10. Create 7 days Schedule records, and seed subcollections
  console.log('Seeding 7 days Schedules (combinations of branch/batches)');
  const batches = Array.from({ length: 5 }, (_, i) => String(2022 + i)); // 2022-2026
  for (const branch of [
    'Computer Engineering',
    'Information Technology',
  ]) {
    for (const batch of batches) {
      const scheduleId = `${branch}_${batch}`;
      await db
        .collection('Admin')
        .doc(adminEmail)
        .collection('schedule')
        .doc(scheduleId)
        .set({
          branch,
          batch,
        });
      const timetableRef = db
        .collection('Admin')
        .doc(adminEmail)
        .collection('schedule')
        .doc(scheduleId)
        .collection('timetable');
      const weeklySchedule = {
        Sunday: [],
        Monday: [
          {
            startTime: '10:00 AM',
            endTime: '11:00 AM',
            start24: '10:00',
            type: 'Lecture',
          },
          {
            startTime: '11:00 AM',
            endTime: '12:00 PM',
            start24: '11:00',
            type: 'Lecture',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
          {
            startTime: '01:30 PM',
            endTime: '03:30 PM',
            start24: '13:30',
            type: 'Lab',
          },
          {
            startTime: '03:30 PM',
            endTime: '05:30 PM',
            start24: '15:30',
            type: 'Lab',
          },
        ],
        Tuesday: [
          {
            startTime: '10:00 AM',
            endTime: '11:00 AM',
            start24: '10:00',
            type: 'Lecture',
          },
          {
            startTime: '11:00 AM',
            endTime: '12:00 PM',
            start24: '11:00',
            type: 'Lecture',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
          {
            startTime: '01:30 PM',
            endTime: '03:30 PM',
            start24: '13:30',
            type: 'Lab',
          },
          {
            startTime: '03:30 PM',
            endTime: '05:30 PM',
            start24: '15:30',
            type: 'Lab',
          },
        ],
        Wednesday: [
          {
            startTime: '10:00 AM',
            endTime: '11:00 AM',
            start24: '10:00',
            type: 'Lecture',
          },
          {
            startTime: '11:00 AM',
            endTime: '12:00 PM',
            start24: '11:00',
            type: 'Lecture',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
          {
            startTime: '01:30 PM',
            endTime: '03:30 PM',
            start24: '13:30',
            type: 'Lab',
          },
          {
            startTime: '03:30 PM',
            endTime: '05:30 PM',
            start24: '15:30',
            type: 'Lab',
          },
        ],
        Thursday: [
          {
            startTime: '10:00 AM',
            endTime: '11:00 AM',
            start24: '10:00',
            type: 'Lecture',
          },
          {
            startTime: '11:00 AM',
            endTime: '12:00 PM',
            start24: '11:00',
            type: 'Lecture',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
          {
            startTime: '01:30 PM',
            endTime: '03:30 PM',
            start24: '13:30',
            type: 'Lab',
          },
          {
            startTime: '03:30 PM',
            endTime: '05:30 PM',
            start24: '15:30',
            type: 'Lab',
          },
        ],
        Friday: [
          {
            startTime: '10:00 AM',
            endTime: '11:00 AM',
            start24: '10:00',
            type: 'Lecture',
          },
          {
            startTime: '11:00 AM',
            endTime: '12:00 PM',
            start24: '11:00',
            type: 'Lecture',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
          {
            startTime: '01:30 PM',
            endTime: '03:30 PM',
            start24: '13:30',
            type: 'Lab',
          },
          {
            startTime: '03:30 PM',
            endTime: '05:30 PM',
            start24: '15:30',
            type: 'Lab',
          },
        ],
        Saturday: [
          {
            startTime: '10:00 AM',
            endTime: '12:00 PM',
            start24: '10:00',
            type: 'Lab',
          },
          {
            startTime: '12:00 PM',
            endTime: '01:00 PM',
            start24: '12:00',
            type: 'Lecture',
          },
        ],
      };
      for (const [day, periods] of Object.entries(weeklySchedule)) {
        const dayDocRef = timetableRef.doc(day);
        await dayDocRef.set({
          dayName: day,
          holiday: day === 'Sunday',
        });
        if (day === 'Sunday') continue;
        const entriesRef = dayDocRef.collection('entries');
        for (let i = 0; i < periods.length; i++) {
          const period = periods[i];
          await entriesRef.doc(`period_${i + 1}`).set({
            subject: `Subject ${((i % 20) + 1)}`,
            type: period.type,
            startTime: period.startTime,
            start24: period.start24,
            endTime: period.endTime,
          });
        }
      }
    }
  }
  // 11. Create 20 Notices
  console.log('Seeding 10 Notices...');
  for (let i = 1; i <= 10; i++) {
    const dateStr = formatDate(new Date(Date.now() - i * 3600000), 'dd-MM-yyyy hh:mm:ss');
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    await db.collection('Admin').doc(adminEmail)
      .collection('Notices')
      .doc(dateStr)
      .set({
        branch: branch,
        batch: '2026',
        subject: `Notice Topic ${i}`,
        notice: `This is notice body description number ${i}. Please follow the guidelines.`,
        date: dateStr,
        photoUrl: 'https://picsum.photos/800/600'
      });
  }
  // 12. Create 20 Results
  console.log('Seeding 10 Results...');
  for (let i = 1; i <= 10; i++) {
    const branch = i % 2 === 1 ? 'Computer Engineering' : 'Information Technology';
    const dateStr = formatDate(new Date(Date.now() - i * 86400000), 'dd-MM-yyyy hh:mm:ss');
    await db.collection('Admin').doc(adminEmail)
      .collection('Results')
      .add({
        branch: branch,
        batch: '2026',
        subject: `Result Topic ${i}`,
        date: dateStr,
        pdf: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'
      });
  }
  // 13. Create 20 Branch documents in messages and messages_parent
  console.log('Seeding 20 message rooms in messages & messages_parent...');
  // Define 20 branch names (our 2 main ones + 18 dummy ones to reach 20 docs in the collection)
  const branchesList = [
    'Computer Engineering',
    'Information Technology',
    ...Array.from({ length: 18 }, (_, i) => `Branch ${i + 3}`)
  ];
  for (const bName of branchesList) {
    // Generate 20 messages for the active batch '2026'
    const messagesArray = [];
    const parentMessagesArray = [];
    for (let m = 1; m <= 20; m++) {
      const isStudentMsg = m % 2 === 1;
      const studentId = students[0].id; // student sender
      const facultyId = faculties[0].id; // faculty sender
      const parentId = String(9876543201); // parent sender
      const sender = isStudentMsg ? studentId : facultyId;
      messagesArray.push({
        [sender]: `Message text ${m} in branch chat.`
      });
      const parentSender = isStudentMsg ? parentId : facultyId;
      parentMessagesArray.push({
        [parentSender]: `Message text ${m} in parent chat.`
      });
    }
    await db.collection('Admin').doc(adminEmail)
      .collection('messages')
      .doc(bName)
      .set({
        '2026': messagesArray
      });
    await db.collection('Admin').doc(adminEmail)
      .collection('messages_parent')
      .doc(bName)
      .set({
        '2026': parentMessagesArray
      });
  }
  // 14. Create Location subcollection under each student
  console.log('Seeding student locations (each subcollection containing 20 documents)...');
  for (const student of students) {
    const locationRef = db.collection('Admin').doc(adminEmail)
      .collection('students').doc(student.id)
      .collection('location');
    // Active student location (ID is matching student.id)
    await locationRef.doc(student.id).set({
      latitude: 23.0225 + Math.random() * 0.05,
      longitude: 72.5714 + Math.random() * 0.05,
      timestamp: FieldValue.serverTimestamp()
    });
    // 19 historical/dummy location entries to have 20 data in the subcollection
    // for (let l = 2; l <= 20; l++) {
    //   await locationRef.doc(`loc_${l}`).set({
    //     latitude: 23.0225 + Math.random() * 0.05,
    //     longitude: 72.5714 + Math.random() * 0.05,
    //     timestamp: FieldValue.serverTimestamp()
    //   });
    // }
  }
  console.log('\n======================================================');
  console.log('SUCCESS: Database successfully seeded with test data!');
  console.log('======================================================');
  console.log('Test Accounts Summary:');
  console.log(`  1. ADMIN:      Email: ${adminEmail} | Password: ${passwordCommon}`);
  console.log('  2. DEPARTMENTS: 11 - Computer Engineering, 12 - Information Technology');
  console.log(`  3. FACULTIES:   20 accounts (e.g. 1001@spf.com to 1020@spf.com) | Passwords: ${passwordCommon}`);
  console.log(`  4. STUDENTS:    20 accounts (e.g. 123456789001@sps.com to 123456789020@sps.com) | Passwords: ${passwordCommon}`);
  console.log(`  5. PARENTS:     20 accounts (e.g. 9876543201@spp.com to 9876543220@spp.com) | Passwords: ${passwordCommon}`);
  console.log('======================================================\n');
}
async function run() {
  try {
    // await cleanPreviousData();
    await seedData();
    process.exit(0);
  } catch (error) {
    console.error('Fatal Error during database seed:', error);
    process.exit(1);
  }
}
run();