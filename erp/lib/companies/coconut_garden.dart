import 'package:flutter/material.dart';

class CoconutGardenScreen extends StatefulWidget {
  const CoconutGardenScreen({super.key});

  @override
  State<CoconutGardenScreen> createState() => _CoconutGardenScreenState();
}

class _CoconutGardenScreenState extends State<CoconutGardenScreen> {
  // ================= COLORS & THEME =================
  static const Color primaryGreen = Color(0xFF206A37); // สีเขียวพรีเมียมเข้มขึ้น
  static const Color accentGreen = Color(0xFF43A047);
  static const Color lightGreen = Color(0xFFE8F5E9);
  static const Color pastelBg = Color(0xFFF4F7F6); // พื้นหลังสว่างสบายตา
  static const Color textDark = Color(0xFF1E293B); // สีข้อความหลักที่นุ่มกว่าดำสนิท
  static const Color textLight = Color(0xFF64748B);

  // ================= STATE VARIABLES =================
  
  // --- Finance State ---
  int totalRevenue = 1450000;     // รายรับเริ่มต้น
  int variableCosts = 350000;     // ต้นทุนผันแปร
  int basePayroll = 564000;       // ต้นทุนคงที่ (เงินเดือนรวม)
  
  // คำนวณกำไรสุทธิ (รายรับ - ต้นทุนผันแปร - เงินเดือน)
  int get netProfit => totalRevenue - variableCosts - basePayroll;

  // ฟังก์ชันแปลงตัวเลขให้มีลูกน้ำ (เช่น 1,000,000)
  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  // --- POS State ---
  List<Map<String, dynamic>> posItems = [
    {"name": "มะพร้าวน้ำหอม", "price": 20, "stock": 520, "qty": 0, "emoji": "🥥"},
    {"name": "มะพร้าวปอก", "price": 25, "stock": 85, "qty": 0, "emoji": "🔪"},
    {"name": "มะพร้าวกะทิ", "price": 25, "stock": 1200, "qty": 0, "emoji": "🌴"},
    {"name": "มะพร้าวไซส์ขนาดเล็ก", "price": 20, "stock": 2100, "qty": 0, "emoji": "🟢"},
    {"name": "มะพร้าวไซส์ขนาดใหญ่", "price": 30, "stock": 45, "qty": 0, "emoji": "🟢"},
  ];

  int get totalCartPrice {
    return posItems.fold(0, (sum, item) => sum + ((item['price'] as int) * (item['qty'] as int)));
  }

  // --- CRM State ---
  final TextEditingController phoneController = TextEditingController();

  // --- Payroll Form State ---
  final TextEditingController _empNameController = TextEditingController();
  final TextEditingController _otController = TextEditingController();
  final TextEditingController _bonusController = TextEditingController();
  
  String _selectedDept = 'ฝ่ายผลิต';
  final Map<String, int> _departmentSalaries = {
    'ผู้จัดการฟาร์ม': 45000,
    'หัวหน้าสวน': 22000,
    'พนักงานดูแลสวน': 14000,
    'ฝ่ายเก็บเกี่ยว': 16000,
    'ฝ่ายคัดแยก/บรรจุ': 15000,
    'ฝ่ายคลังสินค้า': 15000,
    'ฝ่ายขาย': 17000,
    'ฝ่ายบัญชี/ธุรการ': 20000,
    'ฝ่ายผลิต': 15000, // เพิ่มเข้ามาให้ตรงตัวอย่าง
  };

  @override
  void dispose() {
    phoneController.dispose();
    _empNameController.dispose();
    _otController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: pastelBg,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryGreen, accentGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "บริษัทแปรรูปมะพร้าวครบวงจร",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22, letterSpacing: 0.5),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            indicatorPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            labelColor: primaryGreen,
            unselectedLabelColor: Colors.white.withOpacity(0.8),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
            tabs: const [
              Tab(text: "Overview"),
              Tab(text: "Organization"),
              Tab(text: "Business Model"),
              Tab(text: "ERP"),
              Tab(text: "POS"),
              Tab(text: "CRM"),
              Tab(text: "Payroll"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(),
            _buildOrganizationTab(),
            _buildBusinessModelTab(),
            _buildERPTab(),
            _buildPOSTab(),
            _buildCRMTab(),
            _buildPayrollTab(),
          ],
        ),
      ),
    );
  }

  // ================= 1. OVERVIEW TAB =================
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("ลักษณะธุรกิจ"),
          _buildModernCard(
            child: const Text(
              "ธุรกิจเกษตรกรรมออร์แกนิก เน้นการปลูกและจำหน่าย มะพร้าวออร์แกนิก โดยไม่ใช้สารเคมี ควบคุมกระบวนการผลิตตั้งแต่การปลูก จนถึงการจำหน่าย เพื่อให้ได้สินค้าที่มีคุณภาพและปลอดภัยต่อผู้บริโภค",
              style: TextStyle(height: 1.6, fontSize: 15, color: textDark),
            ),
          ),
          const SizedBox(height: 24),
          
          _sectionTitle("สินค้าและบริการหลัก"),
          _buildInfoTile("สินค้า (Products)", Icons.inventory_2, "• มะพร้าวออร์แกนิกสด (ขายเป็นลูก)\n• มะพร้าวปอกพร้อมบริโภค\n• มะพร้าวแปรรูป เช่น น้ำมะพร้าวขวด"),
          _buildInfoTile("บริการ (Services)", Icons.local_shipping, "• จำหน่ายให้ตลาดค้าส่งและพ่อค้าคนกลาง\n• ส่งตรงให้ร้านอาหาร คาเฟ่ และโรงแรม"),
          const SizedBox(height: 30),

          _sectionTitle("สรุปรายรับ-รายจ่าย (Monthly)"),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [primaryGreen, accentGreen], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [BoxShadow(color: accentGreen.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.account_balance_wallet, color: Colors.white)),
                    const SizedBox(width: 12),
                    const Text("กำไรสุทธิ (Net Profit)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                Text("฿${formatCurrency(netProfit)}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 36, letterSpacing: 1)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _miniFinanceCard("รายรับรวม", "฿${formatCurrency(totalRevenue)}", Colors.green.shade600, Icons.arrow_upward)),
              const SizedBox(width: 12),
              Expanded(child: _miniFinanceCard("ต้นทุนผันแปร", "฿${formatCurrency(variableCosts)}", Colors.orange.shade600, Icons.arrow_downward)),
            ],
          ),
          const SizedBox(height: 12),
          _financeCard("ต้นทุนคงที่ (เงินเดือนพนักงานรวม)", "฿${formatCurrency(basePayroll)}", Colors.red.shade500, Icons.people_alt),
        ],
      ),
    );
  }

  // ================= 2. ORGANIZATION TAB =================
  Widget _buildOrganizationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("โครงสร้างองค์กร (รวม 34 คน)"),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: primaryGreen.withOpacity(0.2), width: 2), boxShadow: [BoxShadow(color: primaryGreen.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 8))]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("รวมฐานเงินเดือนทั้งหมด", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: textLight)),
                    SizedBox(height: 4),
                    Text("รายจ่ายประจำเดือน", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Text("฿${formatCurrency(basePayroll)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: primaryGreen)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildModernCard(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(lightGreen),
                  dataRowMinHeight: 65,
                  dataRowMaxHeight: 65,
                  dividerThickness: 0.5,
                  columns: const [
                    DataColumn(label: Text('ตำแหน่ง', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen))),
                    DataColumn(label: Text('จำนวน', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen))),
                    DataColumn(label: Text('เงินเดือน (฿)', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen))),
                    DataColumn(label: Text('ความรับผิดชอบ', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen))),
                  ],
                  rows: const [
                    DataRow(cells: [DataCell(Text('ผู้จัดการฟาร์ม', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('1')), DataCell(Text('45,000')), DataCell(Text('วางแผนและควบคุมภาพรวม'))]),
                    DataRow(cells: [DataCell(Text('หัวหน้าสวน', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('2')), DataCell(Text('22,000')), DataCell(Text('ควบคุมแรงงานและพื้นที่'))]),
                    DataRow(cells: [DataCell(Text('พนักงานดูแลสวน', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('12')), DataCell(Text('14,000')), DataCell(Text('ดูแลต้นมะพร้าว'))]),
                    DataRow(cells: [DataCell(Text('ฝ่ายเก็บเกี่ยว', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('6')), DataCell(Text('16,000')), DataCell(Text('เก็บและคัดแยกผลผลิต'))]),
                    DataRow(cells: [DataCell(Text('ฝ่ายคัดแยก/บรรจุ', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('5')), DataCell(Text('15,000')), DataCell(Text('ตรวจคุณภาพและแพ็คสินค้า'))]),
                    DataRow(cells: [DataCell(Text('ฝ่ายคลังสินค้า', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('3')), DataCell(Text('15,000')), DataCell(Text('ควบคุมสต๊อก'))]),
                    DataRow(cells: [DataCell(Text('ฝ่ายขาย', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('3')), DataCell(Text('17,000')), DataCell(Text('จัดส่งสินค้า'))]),
                    DataRow(cells: [DataCell(Text('ฝ่ายบัญชี/ธุรการ', style: TextStyle(fontWeight: FontWeight.w600))), DataCell(Text('2')), DataCell(Text('20,000')), DataCell(Text('ดูแลรายรับรายจ่าย'))]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= 3. BUSINESS MODEL TAB =================
  Widget _buildBusinessModelTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _sectionTitle("สวนมะพร้าวออร์แกนิกแบบผสมผสาน"),
        const SizedBox(height: 10),
        _buildInfoTile("1. กลุ่มลูกค้า (Customer Segments)", Icons.groups, "• ผู้บริโภคสายสุขภาพ / ออร์แกนิก\n• ร้านน้ำมะพร้าวสด / คาเฟ่สุขภาพ\n• โรงแรม รีสอร์ท และร้านอาหาร\n• โรงงานแปรรูป และผู้ค้าส่งตลาดกลาง"),
        _buildInfoTile("2. คุณค่าเสนอ (Value Propositions)", Icons.star_rounded, "• มะพร้าวออร์แกนิก 100% ไม่ใช้สารเคมี\n• เก็บสดใหม่ ส่งตรงถึงลูกค้า\n• มีมาตรฐาน GAP / เกษตรอินทรีย์\n• รองรับออเดอร์จำนวนมาก"),
        _buildInfoTile("3. ความสัมพันธ์กับลูกค้า (Relationships)", Icons.handshake, "• ระบบสั่งจองล่วงหน้า (Pre-order)\n• บริการจัดส่งประจำรายสัปดาห์\n• ดูแลลูกค้าแบบ B2B ระยะยาว"),
        _buildInfoTile("4. ช่องทางจัดจำหน่าย (Channels)", Icons.storefront, "• ขายหน้าสวนโดยตรง\n• Facebook / Line OA\n• ส่งตลาดค้าส่งและตลาดสด"),
        _buildInfoTile("5. กระแสรายได้ (Revenue Streams)", Icons.payments, "• มะพร้าวสดทั้งลูก / ปอกพร้อมดื่ม\n• กะทิสด / น้ำมะพร้าวสด\n• รายได้จากเศษวัสดุ (กาบ/กะลา)"),
        _buildInfoTile("6. พันธมิตรหลัก (Key Partners)", Icons.link, "• เกษตรกรเครือข่ายสวนใกล้เคียง\n• บริษัทขนส่งท้องถิ่น\n• ร้านค้าอุปกรณ์การเกษตร"),
        _buildInfoTile("7. กิจกรรมหลัก (Key Activities)", Icons.engineering, "• ปลูกดูแลสวน และเก็บเกี่ยว\n• บรรจุและจัดส่งสินค้า\n• วางแผนการผลิตตามฤดูกาล"),
        _buildInfoTile("8. ทรัพยากรหลัก (Key Resources)", Icons.inventory, "• พื้นที่สวน 40 ไร่\n• ระบบน้ำและเครื่องมือเกษตร\n• แรงงานประจำและตามฤดูกาล"),
        _buildInfoTile("9. โครงสร้างต้นทุน (Cost Structure)", Icons.account_balance_wallet, "• ค่าแรงงาน / ปุ๋ยอินทรีย์\n• ค่าน้ำ / ค่าไฟ / ค่าขนส่ง\n• ค่าอุปกรณ์และซ่อมบำรุง"),
      ],
    );
  }

  // ================= 4. ERP TAB =================
  Widget _buildERPTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _sectionTitle("ระบบ Enterprise Resource Planning"),
        const SizedBox(height: 10),
        _buildERPExpansion("1. การจัดการขนส่ง (Transportation)", Icons.local_shipping, ["วางแผนเส้นทางส่งสินค้าแบบอัจฉริยะ", "ติดตามสถานะการขนส่งแบบ Real-time"]),
        _buildERPExpansion("2. การเงินและบัญชี (Financial)", Icons.account_balance, ["บันทึกรายรับ–รายจ่ายจาก POS อัตโนมัติ", "คำนวณต้นทุนต่อผลผลิตแบบละเอียด", "สรุปกำไร-ขาดทุนรายเดือน"]),
        _buildERPExpansion("3. บริหารบุคคล (HR & Payroll)", Icons.people, ["บันทึกเวลาเข้าออกงาน", "คำนวณเงินเดือน ล่วงเวลาอัตโนมัติ", "จัดตารางเวรพนักงาน"]),
        _buildERPExpansion("4. วิเคราะห์ข้อมูล (BI Dashboard)", Icons.analytics, ["สรุปยอดขายรายวัน / เดือน", "วิเคราะห์ต้นทุนเชิงลึก", "ระบบคาดการณ์ผลผลิตล่วงหน้า"]),
      ],
    );
  }

  // ================= 5. POS DASHBOARD TAB (Interactive) =================
  Widget _buildPOSTab() {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 120), // เผื่อพื้นที่ให้ Bottom Bar
          itemCount: posItems.length,
          itemBuilder: (context, index) {
            final item = posItems[index];
            return _posItemCard(index, item['name'], item['price'], item['stock'], item['qty'], item['emoji']);
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("ราคารวมทั้งหมด", style: TextStyle(color: textLight, fontSize: 13, fontWeight: FontWeight.w600)),
                      Text("฿${formatCurrency(totalCartPrice)}", style: const TextStyle(color: textDark, fontSize: 26, fontWeight: FontWeight.w800)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: totalCartPrice > 0 ? primaryGreen : Colors.grey.shade300,
                      foregroundColor: totalCartPrice > 0 ? Colors.white : Colors.grey.shade500,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      elevation: totalCartPrice > 0 ? 5 : 0,
                      shadowColor: primaryGreen.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: totalCartPrice > 0 ? () {
                      setState(() {
                        totalRevenue += totalCartPrice; 
                        for (var item in posItems) { item['qty'] = 0; }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('✅ ทำรายการชำระเงินสำเร็จ รายได้ถูกบันทึกแล้ว!'), backgroundColor: accentGreen, behavior: SnackBarBehavior.floating),
                      );
                    } : null,
                    child: const Row(
                      children: [
                        Icon(Icons.point_of_sale, size: 20),
                        SizedBox(width: 8),
                        Text("ชำระเงิน", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // ================= 6. CRM TAB (Interactive) =================
  Widget _buildCRMTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
            child: const Icon(Icons.card_membership, size: 60, color: primaryGreen),
          ),
          const SizedBox(height: 20),
          const Text("สมัครสมาชิกใหม่", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: textDark)),
          const SizedBox(height: 8),
          const Text("สะสมแต้มและรับสิทธิพิเศษสำหรับลูกค้าประจำ", style: TextStyle(color: textLight, fontSize: 14)),
          const SizedBox(height: 30),
          _buildModernCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("เบอร์โทรศัพท์", style: TextStyle(fontWeight: FontWeight.w600, color: textDark, fontSize: 14)),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 2),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: pastelBg,
                    hintText: "08X-XXX-XXXX",
                    hintStyle: TextStyle(color: Colors.grey.shade400, letterSpacing: 1),
                    prefixIcon: const Icon(Icons.phone_iphone, color: primaryGreen),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    counterText: "",
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: primaryGreen.withOpacity(0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      if (phoneController.text.length < 9) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('⚠️ กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง'), backgroundColor: Colors.orange, behavior: SnackBarBehavior.floating));
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('🎉 ลงทะเบียนเบอร์ ${phoneController.text} สำเร็จ!'), backgroundColor: accentGreen, behavior: SnackBarBehavior.floating));
                      phoneController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text("ลงทะเบียนสมาชิก", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= 7. PAYROLL TAB (อัปเดตแบบฟอร์มออกสลิป) =================
  Widget _buildPayrollTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            "ระบบคำนวณเงินเดือนพนักงาน",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: primaryGreen),
          ),
          const SizedBox(height: 8),
          const Text("จัดการข้อมูลและออกสลิปเงินเดือนให้พนักงานรายบุคคล", style: TextStyle(color: textLight, fontSize: 14)),
          const SizedBox(height: 24),

          _buildModernCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. ชื่อพนักงาน
                const Text("ชื่อพนักงาน", style: TextStyle(fontWeight: FontWeight.w600, color: textDark, fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  controller: _empNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: pastelBg,
                    hintText: "เช่น นายสมชาย ใจดี",
                    prefixIcon: const Icon(Icons.person, color: primaryGreen),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryGreen, width: 1.5)),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. ฝ่ายงาน
                const Text("ฝ่ายงาน", style: TextStyle(fontWeight: FontWeight.w600, color: textDark, fontSize: 14)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedDept,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: pastelBg,
                    prefixIcon: const Icon(Icons.work, color: primaryGreen),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryGreen, width: 1.5)),
                  ),
                  items: _departmentSalaries.keys.map((String dept) {
                    return DropdownMenuItem<String>(
                      value: dept,
                      child: Text(dept, style: const TextStyle(fontWeight: FontWeight.w500)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() { _selectedDept = newValue!; });
                  },
                ),
                const SizedBox(height: 16),

                // 3. OT
                const Text("OT (ชม.ละ 100 บาท)", style: TextStyle(fontWeight: FontWeight.w600, color: textDark, fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  controller: _otController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: pastelBg,
                    hintText: "จำนวนชั่วโมง",
                    prefixIcon: const Icon(Icons.access_time, color: primaryGreen),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryGreen, width: 1.5)),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. โบนัส
                const Text("โบนัสพิเศษ (บาท)", style: TextStyle(fontWeight: FontWeight.w600, color: textDark, fontSize: 14)),
                const SizedBox(height: 8),
                TextField(
                  controller: _bonusController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: pastelBg,
                    hintText: "ระบุจำนวนเงิน",
                    prefixIcon: const Icon(Icons.card_giftcard, color: primaryGreen),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryGreen, width: 1.5)),
                  ),
                ),
                const SizedBox(height: 32),

                // ปุ่มออกสลิป
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.receipt_long),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: primaryGreen.withOpacity(0.4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: _generateIndividualSlip,
                    label: const Text("ออกสลิปเงินเดือน", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Logic การคำนวณและแสดงสลิป
  void _generateIndividualSlip() {
    if (_empNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ กรุณากรอกชื่อพนักงาน'), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
      );
      return;
    }

    int baseSalary = _departmentSalaries[_selectedDept] ?? 0;
    int otHours = int.tryParse(_otController.text) ?? 0;
    int otTotal = otHours * 100;
    int bonus = int.tryParse(_bonusController.text) ?? 0;
    int netTotal = baseSalary + otTotal + bonus;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: primaryGreen, size: 36),
            ),
            const SizedBox(height: 12),
            const Text("สลิปเงินเดือน", style: TextStyle(color: primaryGreen, fontWeight: FontWeight.w800, fontSize: 20)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 8),
            _slipRow("ชื่อพนักงาน:", _empNameController.text),
            _slipRow("ฝ่ายงาน:", _selectedDept),
            const SizedBox(height: 16),
            _slipRow("เงินเดือนพื้นฐาน:", "฿${formatCurrency(baseSalary)}"),
            _slipRow("ค่าล่วงเวลา (OT):", "฿${formatCurrency(otTotal)}"),
            _slipRow("โบนัส:", "฿${formatCurrency(bonus)}"),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 8),
            _slipRow("รายรับสุทธิ:", "฿${formatCurrency(netTotal)}", isBold: true, color: primaryGreen, size: 20),
          ],
        ),
        actionsPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _empNameController.clear();
                  _otController.clear();
                  _bonusController.clear();
                  _selectedDept = 'ฝ่ายผลิต';
                });
                FocusScope.of(context).unfocus();
              },
              child: const Text("ปิดและพิมพ์สลิป", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  Widget _slipRow(String label, String value, {bool isBold = false, Color? color, double size = 15}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: textLight, fontSize: 14)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.w800 : FontWeight.w600, color: color ?? textDark, fontSize: size)),
        ],
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 4),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: textDark)),
    );
  }

  Widget _buildModernCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      child: child,
    );
  }

  Widget _financeCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(color: textLight, fontWeight: FontWeight.w600, fontSize: 14))),
          Text(value, style: TextStyle(color: textDark, fontWeight: FontWeight.w800, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _miniFinanceCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: textLight, fontWeight: FontWeight.w600, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: textDark, fontWeight: FontWeight.w800, fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, IconData icon, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 5))]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
                  child: Icon(icon, color: primaryGreen, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: textDark))),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(content, style: const TextStyle(height: 1.6, color: textLight, fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildERPExpansion(String title, IconData icon, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 5))]),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.only(bottom: 16),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: lightGreen, shape: BoxShape.circle),
            child: Icon(icon, color: primaryGreen, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: textDark, fontSize: 15)),
          children: items.map((e) => Padding(
            padding: const EdgeInsets.only(left: 72, right: 20, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 6, color: primaryGreen)),
                const SizedBox(width: 12),
                Expanded(child: Text(e, style: const TextStyle(color: textLight, height: 1.5, fontWeight: FontWeight.w500))),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }

  Widget _posItemCard(int index, String name, int price, int stock, int qty, String emoji) {
    bool isLowStock = stock < 100;
    Color stockColor = isLowStock ? Colors.red.shade500 : Colors.orange.shade500;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Container(
            width: 70, height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: pastelBg, borderRadius: BorderRadius.circular(20)),
            child: Text(emoji, style: const TextStyle(fontSize: 36)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: textDark), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text("฿$price", style: const TextStyle(color: primaryGreen, fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: stockColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text("คงเหลือ: $stock", style: TextStyle(color: stockColor, fontWeight: FontWeight.bold, fontSize: 11)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: pastelBg, borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                _stepperBtn(Icons.remove, qty > 0 ? Colors.red.shade400 : Colors.grey.shade400, qty > 0 ? () {
                  setState(() { posItems[index]['qty']--; posItems[index]['stock']++; });
                } : null),
                Container(
                  width: 32, alignment: Alignment.center,
                  child: Text("$qty", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textDark)),
                ),
                _stepperBtn(Icons.add, stock > 0 ? primaryGreen : Colors.grey.shade400, stock > 0 ? () {
                  setState(() { posItems[index]['qty']++; posItems[index]['stock']--; });
                } : null),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _stepperBtn(IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}