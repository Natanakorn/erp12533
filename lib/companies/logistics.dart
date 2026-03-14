import 'package:flutter/material.dart';

class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("บริษัทขนส่ง (Logistics & Cold Chain)"),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("1. บริการและโมเดลสินค้า (Detailed Services)"),
            _buildContent("ธุรกิจขนส่งไม่ได้ขายแค่การเคลื่อนย้าย แต่ขาย 'Service Level Agreement (SLA)'"),
            
            _buildSubHeader("🚚 ขนส่งธรรมดา (General Freight)"),
            _buildBullet("FTL (Full Truck Load): เหมาะกับอุตสาหกรรมหนัก หรือสินค้า FMCG ล็อตใหญ่"),
            _buildBullet("LTL/Consolidation: บริการ 'รถสาย' รวมสินค้าหลายเจ้า คิดราคาตาม CBM หรือน้ำหนัก"),
            _buildBullet("Milk Run: บริการตระเวนรับสินค้าจาก Supplier หลายเจ้าเพื่อไปส่งที่โรงงานเดียว"),
            
            _buildSubHeader("❄️ ขนส่งแบบเย็น (Cold Chain Specialist)"),
            _buildBullet("Multi-Drop Chilled: ส่งสินค้าสดเข้า 7-Eleven/Supermarket (ระบบทำความเย็นฟื้นตัวเร็ว)"),
            _buildBullet("Frozen Logistics: ขนส่งสินค้าที่ -18 ถึง -25 องศาเซลเซียส (รักษาอุณหภูมิคงที่)"),
            _buildBullet("Medical Cold Chain: ขนส่งวัคซีนหรือเลือด (ระบบ Backup และ Monitoring รายวินาที)"),

            const Divider(height: 40),

            _buildHeader("2. โครงสร้างองค์กรและอัตรากำลังคน"),
            _buildContent("กองรถ 20 คัน (ธรรมดา 10, เย็น 10) | รวมพนักงาน 32 คน"),
            const SizedBox(height: 10),
            _buildOrgTable(),

            const Divider(height: 40),

            _buildHeader("3. รายรับ รายจ่าย และต้นทุน (Monthly Simulation)"),
            _buildFinancialCard(),

            const Divider(height: 40),

            _buildHeader("4. Business Model (9 Building Blocks)"),
            _buildBullet("**Customer Segments:** โรงงาน, E-commerce, ผู้ผลิตอาหารสด, บริษัทยา"),
            _buildBullet("**Value Propositions:** On-time Delivery, Cold Chain Integrity, Real-time Tracking"),
            _buildBullet("**Revenue Streams:** Freight Charge, Fuel Surcharge, Storage Fee"),

            const Divider(height: 40),

            _buildHeader("5. ซอฟต์แวร์และระบบสารสนเทศ (ERP/TMS/POS)"),
            _buildSubHeader("ระบบหลักที่ต้องใช้"),
            _buildBullet("TMS: วางแผนเส้นทาง (Route Optimization) และ E-POD"),
            _buildBullet("Telematics: GPS Tracking และเซนเซอร์วัดอุณหภูมิ IoT"),
            _buildBullet("ERP: เชื่อมข้อมูลบัญชี, Fleet Maintenance และ Payroll"),
            _buildBullet("Mobile POS: สำหรับเก็บเงินปลายทาง (COD) และยืนยันอุณหภูมิหน้างาน"),
            
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets สำหรับตกแต่งหน้าตา ---

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildSubHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildContent(String text) {
    return Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87));
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildOrgTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.blue[50]),
        columns: const [
          DataColumn(label: Text('ฝ่าย')),
          DataColumn(label: Text('ตำแหน่ง')),
          DataColumn(label: Text('จำนวน')),
          DataColumn(label: Text('เงินเดือน')),
        ],
        rows: const [
          DataRow(cells: [DataCell(Text('บริหาร')), DataCell(Text('MD')), DataCell(Text('1')), DataCell(Text('100k+'))]),
          DataRow(cells: [DataCell(Text('ปฏิบัติการ')), DataCell(Text('Dispatcher')), DataCell(Text('3')), DataCell(Text('25k-35k'))]),
          DataRow(cells: [DataCell(Text('ขับเคลื่อน')), DataCell(Text('คนขับรถเย็น')), DataCell(Text('10')), DataCell(Text('22k-35k'))]),
        ],
      ),
    );
  }

  Widget _buildFinancialCard() {
    return Card(
      color: Colors.blue[50],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFinanceRow("รายรับทั้งหมด", "2,775,000 บาท", isBold: true),
            const Divider(),
            _buildFinanceRow("ต้นทุนผันแปร (น้ำมัน/ซ่อม)", "651,750 บาท", color: Colors.red),
            _buildFinanceRow("ต้นทุนคงที่ (เงินเดือน/งวดรถ)", "930,000 บาท", color: Colors.red),
            const Divider(),
            _buildFinanceRow("กำไรสุทธิโดยประมาณ", "1,193,250 บาท", isBold: true, color: Colors.green[700]),
            const Text("(Profit Margin ~43% ก่อนภาษี)", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceRow(String title, String amount, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(amount, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
        ],
      ),
    );
  }
}