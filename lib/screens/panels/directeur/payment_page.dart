import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPageDirector extends StatelessWidget {
  const PaymentPageDirector({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: SingleChildScrollView(child: PaymentsPage()),
    );
  }
}



class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Tous';
  DateTimeRange? _dateRange;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // En-tête avec recherche et bouton d'ajout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un paiement...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _showAddPaymentDialog,
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Filtres
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildFilterButton('Tous'),
                _buildFilterButton('Espèces'),
                _buildFilterButton('Carte'),
                _buildFilterButton('Virement'),
                _buildDateFilterButton(),
              ],
            ),
          ),

          // Vue des soldes
          _buildBalanceSummary(),

          // Liste des paiements
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredPayments().length,
              itemBuilder: (context, index) {
                final payment = _filteredPayments()[index];
                return _buildPaymentCard(payment);
              },
            ),
          ),
          //SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: _selectedFilter == label,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'Tous';
          });
        },
        selectedColor: Colors.indigo[100],
        labelStyle: TextStyle(
          color: _selectedFilter == label ? Colors.indigo : Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDateFilterButton() {
    final dateText = _dateRange == null
        ? 'Dates'
        : '${DateFormat('dd/MM').format(_dateRange!.start)}-${DateFormat('dd/MM').format(_dateRange!.end)}';

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        avatar: const Icon(Icons.calendar_month, size: 16),
        label: Text(dateText),
        onPressed: _selectDateRange,
        backgroundColor: _dateRange == null ? Colors.grey[100] : Colors.indigo[50],
        labelStyle: TextStyle(
          color: _dateRange == null ? Colors.grey[800] : Colors.indigo,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildBalanceSummary() {
    final totalBalance = 12500.0;
    final paidAmount = 9850.0;
    final remainingAmount = totalBalance - paidAmount;
    final progress = paidAmount / totalBalance;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Soldes des étudiants',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: Colors.indigo,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payé',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${paidAmount.toStringAsFixed(2)} FCFA',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Restant',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${remainingAmount.toStringAsFixed(2)} FCFA',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getPaymentMethodColor(payment['method']).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _getPaymentMethodColor(payment['method']).withValues
                (alpha: 0.2),
            ),
          ),
          child: Icon(
            _getPaymentMethodIcon(payment['method']),
            color: _getPaymentMethodColor(payment['method']),
            size: 20,
          ),
        ),
        title: Text(
          payment['student'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(payment['date']),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              payment['method'],
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${payment['amount'].toStringAsFixed(2)} FCFA',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            Text(
              payment['status'],
              style: TextStyle(
                color: payment['status'] == 'Complet' ? Colors.green : Colors.orange,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPaymentMethodColor(String method) {
    switch (method) {
      case 'Espèces':
        return Colors.green;
      case 'Carte':
        return Colors.blue;
      case 'Virement':
        return Colors.purple;
      default:
        return Colors.indigo;
    }
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case 'Espèces':
        return Icons.money;
      case 'Carte':
        return Icons.card_giftcard;
      case 'Virement':
        return Icons.comment_bank;
      default:
        return Icons.wallet;
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.indigo,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _showAddPaymentDialog() {
    // Implémentez la logique d'ajout de paiement
  }

  List<Map<String, dynamic>> _filteredPayments() {
    List<Map<String, dynamic>> payments = [
      {
        'student': 'Jean Dupont',
        'amount': 50000.0,
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'method': 'Espèces',
        'status': 'Complet',
      },
      {
        'student': 'Marie Lambert',
        'amount': 75000.0,
        'date': DateTime.now().subtract(const Duration(days: 5)),
        'method': 'Virement',
        'status': 'Complet',
      },
      {
        'student': 'Paul Martin',
        'amount': 60000.0,
        'date': DateTime.now().subtract(const Duration(days: 10)),
        'method': 'Carte',
        'status': 'Partiel',
      },
      {
        'student': 'Sophie Bernard',
        'amount': 45000.0,
        'date': DateTime.now().subtract(const Duration(days: 15)),
        'method': 'Espèces',
        'status': 'Complet',
      },
    ];

    return payments.where((payment) {
      final matchesSearch = payment['student']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      final matchesFilter =
          _selectedFilter == 'Tous' || payment['method'] == _selectedFilter;
      final matchesDate = _dateRange == null ||
          (payment['date'].isAfter(_dateRange!.start) &&
              payment['date'].isBefore(_dateRange!.end));

      return matchesSearch && matchesFilter && matchesDate;
    }).toList();
  }
}