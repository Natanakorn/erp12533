import 'package:flutter/material.dart';
import 'home_screen.dart'; // import หน้าแรกเข้ามา

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Company Group Web',
      debugShowCheckedModeBanner: false, // ปิดแถบคำว่า Debug มุมขวาบน
      
      // ตั้งค่า Theme สีรวมของแอป (เน้นสีเขียวให้เข้ากับสวนมะพร้าว)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true, // ใช้ดีไซน์แบบใหม่ล่าสุด
        fontFamily: 'Kanit', // ถ้าคุณมี Font ภาษาไทย สามารถใส่ชื่อตรงนี้ได้
      ),

      // กำหนดว่าหน้าแรกที่เปิดมาคือหน้าไหน
      home: const HomeScreen(), 
    );
  }
}