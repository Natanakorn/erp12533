import 'package:flutter/material.dart';
import 'company_list_screen.dart'; // อย่าลืม import หน้ารวมบริษัทมาด้วย

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ส่วนหัวของหน้าเว็บ/แอป
      appBar: AppBar(
        title: const Text("หน้าหลัก"),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ส่วนแสดงโลโก้หรือไอคอนหน้าหลัก
            Icon(Icons.business_center, size: 100, color: Colors.green[800]),
            const SizedBox(height: 20),
            
            const Text(
              "ยินดีต้อนรับสู่ระบบบริหารจัดการ",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            const Text(
              "กลุ่มบริษัทในเครือของเรา",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            // ปุ่มกดเพื่อไปหน้ารวมบริษัท
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  // คำสั่งย้ายหน้าไปที่ CompanyListScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompanyListScreen()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("เข้าชมรายชื่อบริษัท ", style: TextStyle(fontSize: 18)),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}