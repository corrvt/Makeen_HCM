import 'package:flutter/material.dart';

class FinancialRequestScreen extends StatelessWidget {
  const FinancialRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F8),
      appBar: AppBar(
        title: const Text('المالية'),
        backgroundColor: const Color(0xFF1A5F7A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5F7A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الرصيد المتاح', style: TextStyle(color: Colors.white70, fontSize: 15)),
                SizedBox(height: 8),
                Text('12,450 ر.ي', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('آخر تحديث: اليوم، 09:30 ص', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _FinancialMetric(title: 'سلفتي', value: '3,200 ر.ي', icon: Icons.account_balance_wallet_outlined, color: const Color(0xFF22A39F)),
              const SizedBox(width: 12),
              _FinancialMetric(title: 'العهدة', value: '850 ر.ي', icon: Icons.receipt_long_outlined, color: const Color(0xFFE09F3E)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('آخر العمليات', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1A5F7A))),
              TextButton(onPressed: () {}, child: const Text('عرض الكل')),
            ],
          ),
          const _FinancialTransaction(title: 'بدل مواصلات', date: '18 أغسطس 2026', amount: '+ 450 ر.ي', icon: Icons.directions_car_outlined, isPositive: true),
          const _FinancialTransaction(title: 'تسوية عهدة ميدانية', date: '15 أغسطس 2026', amount: '- 200 ر.ي', icon: Icons.assignment_turned_in_outlined, isPositive: false),
          const _FinancialTransaction(title: 'سلفة شهر أغسطس', date: '01 أغسطس 2026', amount: '+ 2,000 ر.ي', icon: Icons.payments_outlined, isPositive: true),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showFinancialRequestDialog(context),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('تقديم طلب مالي', style: TextStyle(fontSize: 17, color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22A39F),
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 22),
          const Text('طلبات قيد المراجعة', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF1A5F7A))),
          const SizedBox(height: 10),
          const _PendingRequest(title: 'سلفة طارئة', amount: '1,500 ر.ي', date: '20 أغسطس 2026'),
        ],
      ),
    );
  }

  void _showFinancialRequestDialog(BuildContext context) {
    final amountController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('طلب مالي جديد'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'نوع الطلب', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'advance', child: Text('سلفة')),
                DropdownMenuItem(value: 'custody', child: Text('عهدة مالية')),
                DropdownMenuItem(value: 'expense', child: Text('مصروفات')),
              ],
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'المبلغ', suffixText: 'ر.ي', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            const TextField(maxLines: 2, decoration: InputDecoration(labelText: 'سبب الطلب', border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('إلغاء')),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال الطلب للمراجعة')));
            },
            child: const Text('إرسال الطلب'),
          ),
        ],
      ),
    );
  }
}
