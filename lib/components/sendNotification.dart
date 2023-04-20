// ignore_for_file: file_names, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class notification {
  Future<void> sendNotificationToAllUsers(String message) async {
    // bool hasCustomSounds = await FlutterRingtonePlayer.canCustomize;

    // Check if the user has provided privacy consent
    bool userProvidedPrivacyConsent =
        await OneSignal.shared.userProvidedPrivacyConsent();
    if (!userProvidedPrivacyConsent) {
      print(
          "User has not provided privacy consent yet. Cannot send notification.");
      return;
    }

    // Retrieve all users from the 'users' collection in Firestore
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        // .where('refferalcode', isEqualTo: refferalcode)
        .get();

    List<String> playerIds = [];
    for (var doc in userSnapshot.docs) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      String? playerId = userData['notification_tokens'] as String?;
      if (playerId != null) {
        playerIds.add(playerId);
      }
    }

    // Send the notification to all users using OneSignal
    await OneSignal.shared.postNotification(
      OSCreateNotification(
        playerIds: playerIds,
        content: message,
        androidSmallIcon: '@mipmap/notification_icon',
      ),
    );
  }
}
