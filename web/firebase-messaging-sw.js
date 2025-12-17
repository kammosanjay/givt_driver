// web/firebase-messaging-sw.js

importScripts("https://www.gstatic.com/firebasejs/9.17.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.17.2/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyBCGuIXBhjXZqAV5jQcjdvY-6zzLa4BgTk",
    authDomain: "banda-uni-app.firebaseapp.com",
    projectId: "banda-uni-app",
    storageBucket: "banda-uni-app.firebasestorage.app",
    messagingSenderId: "303180080421",
    appId: "1:303180080421:web:f438f974c5132e0c52a6cc",
    measurementId: "G-KKPRBJ9NJB"
});

const messaging = firebase.messaging();
