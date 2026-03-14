import 'package:flutter/material.dart';
import 'companies/coconut_garden.dart';
import 'companies/processing_plant.dart';
import 'companies/logistics.dart';
import 'companies/cafe.dart';

class CompanyListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รวมบริษัทในเครือ")),
      body: ListView(
        children: [
          // เรียกใช้งาน Widget ที่แยกไฟล์ไว้
          _buildCompanyTile(context, "บริษัทสวนมะพร้าว",CoconutGardenScreen()),
          _buildCompanyTile(context, "บริษัทแปรรูป", ProcessingPlantScreen()),
          _buildCompanyTile(context, "บริษัทขนส่ง", LogisticsScreen()),
          _buildCompanyTile(context, "บริษัทคาเฟ่", CafeScreen()),
        ],
      ),
    );
  }

  // ส่วนนี้คุณเขียนไว้ในรูปแล้ว ดูเหมือนจะถูกต้องครับ
  Widget _buildCompanyTile(BuildContext context, String title, Widget targetPage) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => targetPage)
        );
      },
    );
  }
}