import 'package:flutter/material.dart';

class CafeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("บริษัทคาเฟ่")),
      body: Center(child: Text("รายละเอียด: คาเฟ่มะพร้าวน้ำหอมและเบเกอรี่")),
    );
  }
}