importScripts("https://www.gstatic.com/firebasejs/9.4.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.4.1/firebase-messaging-compat.js");

firebase.initializeApp({
  // Add your Firebase project configuration here
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log(
    "[firebase-messaging-sw.js] Received background message ",
    payload
  );

  // Customize notification here
  const notificationTitle = "Background Message Title";
  const notificationOptions = {
    body: "Background Message body.",
    icon: "/firebase-logo.png",
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
