import 'package:flutter/material.dart';
import 'package:trukkertrakker/src/app.dart';

// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCYo7gqY3tezdXmfVbkypRd2eVZXPudPGc",
  authDomain: "ih12b213-4.firebaseapp.com",
  databaseURL: "https://ih12b213-4-default-rtdb.firebaseio.com",
  projectId: "ih12b213-4",
  storageBucket: "ih12b213-4.appspot.com",
  messagingSenderId: "988142203119",
  appId: "1:988142203119:web:eea1669d6d6401350e2b1a",
  measurementId: "G-C80M7XW650"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);