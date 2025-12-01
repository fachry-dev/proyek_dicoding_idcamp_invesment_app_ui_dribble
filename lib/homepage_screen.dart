import 'package:flutter/material.dart';

// UserModel sederhana untuk data tampilan
class UserModel {
  final String name;
  final double totalBalance;
  final double income;
  final double spendings;

  UserModel({
    required this.name,
    required this.totalBalance,
    required this.income,
    required this.spendings,
  });
}

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  // Data dummy (State aplikasi)
  final UserModel _user = UserModel(
    name: 'Esther Howard',
    totalBalance: 5560.43,
    income: 34343.00,
    spendings: 24343.00,
  );

  // State yang akan diubah (untuk memenuhi kriteria stateful)
  bool _isBalanceHidden = false;

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceHidden = !_isBalanceHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 💡 PERBAIKAN: Definisikan variabel tema yang diperlukan
    final primaryColor = Theme.of(context).colorScheme.primary;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Menghilangkan flexibleSpace untuk mengatasi overflow
        automaticallyImplyLeading: false,
        title: Text('Welcome back', style: textTheme.titleMedium?.copyWith(color: Colors.white)),
        backgroundColor: primaryColor, // Set warna AppBar di sini
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.grid_view), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- BAGIAN PERBAIKAN UTAMA: Saldo dan Ringkasan di Body ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildBalanceAndSummary(primaryColor, textTheme), // Panggil fungsi baru
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Saving', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildSavingCards(),
            ), 
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text('Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            _buildTransactionList(),
            const SizedBox(height: 10), 
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(primaryColor),
    );
  }
  Widget _buildBalanceAndSummary(Color primaryColor, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15), 
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
              ),
              IconButton(
                icon: Icon(
                  _isBalanceHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: _toggleBalanceVisibility, 
              ),
            ],
          ),
          Text(
            _isBalanceHidden ? '******' : '\$${_user.totalBalance.toStringAsFixed(2)}',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildFinancialSummary('Income', _user.income, Colors.greenAccent),
              const SizedBox(width: 20),
              _buildFinancialSummary('Spendings', _user.spendings, Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildFinancialSummary(String title, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          title == 'Income'
              ? '+\$${amount.toStringAsFixed(2)}'
              : '-\$${(amount).abs().toStringAsFixed(2)}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
  Widget _buildSavingCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSavingCard(
            icon: Icons.home,
            title: 'Housing',
            amount: 453.00,
            percent: 50,
            color: const Color(0xFF00ACC1),
          ),
          const SizedBox(width: 10),
          _buildSavingCard(
            icon: Icons.fastfood,
            title: 'Food',
            amount: 453.00,
            percent: 30,
            color: const Color(0xFF4DB6AC),
          ),
          const SizedBox(width: 10),
          // Kartu 3: Add New
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Icon(Icons.add_circle_outline, size: 40, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSavingCard({
    required IconData icon,
    required String title,
    required double amount,
    required int percent,
    required Color color,
  }) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              Text(
                '$percent%',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildTransactionList() {
    const transactions = [
      {'title': 'Shopping', 'amount': -211.00, 'date': 'Jun 11, 12:23', 'icon': Icons.shopping_bag, 'color': Colors.red},
      {'title': 'Salary', 'amount': 1200.00, 'date': 'Jun 10, 09:00', 'icon': Icons.attach_money, 'color': Colors.green},
      {'title': 'Office Supplies', 'amount': -55.50, 'date': 'Jun 10, 01:45', 'icon': Icons.business_center, 'color': Colors.red},
    ];

    return Column(
      children: transactions.map((tx) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: tx['color'] as Color,
            child: Icon(tx['icon'] as IconData, color: Colors.white),
          ),
          title: Text(tx['title'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(tx['date'].toString()),
trailing: Text(
  // 💡 PERBAIKAN UTAMA: Cast tx['amount'] sebagai double
  (tx['amount'] as double)! > 0 
      ? '+\$${(tx['amount'] as double)!.toStringAsFixed(2)}'
      : '-\$${(tx['amount'] as double)!.abs().toStringAsFixed(2)}',
  style: TextStyle(
    color: tx['color'] as Color,
    fontWeight: FontWeight.bold,
  ),
),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavBar(Color primaryColor) {
    return BottomNavigationBar(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}