
import 'package:flutter/material.dart';
class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionsPage();
  }
}



class Transaction {
  final String id;
  final DateTime date;
  final String description;
  final double amount;
  final TransactionStatus status;
  final String paymentMethod;
  final String reference;
  final String studentName;
  final String academicPeriod;

  Transaction({
    required this.id,
    required this.date,
    required this.description,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.reference,
    required this.studentName,
    required this.academicPeriod,
  });
}

enum TransactionStatus { completed, pending, failed }

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  // Données d'exemple
  List<Transaction> get sampleTransactions => [
    Transaction(
      id: '1',
      date: DateTime(2024, 4, 15),
      description: 'Paiement Frais de Scolarité',
      amount: -195.00,
      status: TransactionStatus.completed,
      paymentMethod: 'Carte bancaire',
      reference: 'TXN-2024-001',
      studentName: 'Jean Dupont',
      academicPeriod: 'Semestre 2 - 2024',
    ),
    Transaction(
      id: '2',
      date: DateTime(2024, 4, 3),
      description: 'Paiement Frais de Scolarité',
      amount: 300.00,
      status: TransactionStatus.pending,
      paymentMethod: 'Virement bancaire',
      reference: 'TXN-2024-002',
      studentName: 'Jean Dupont',
      academicPeriod: 'Semestre 2 - 2024',
    ),
    Transaction(
      id: '3',
      date: DateTime(2024, 3, 21),
      description: 'Paiement Frais de Scolarité',
      amount: -200.00,
      status: TransactionStatus.failed,
      paymentMethod: 'Carte bancaire',
      reference: 'TXN-2024-003',
      studentName: 'Jean Dupont',
      academicPeriod: 'Semestre 1 - 2024',
    ),
    Transaction(
      id: '4',
      date: DateTime(2024, 3, 9),
      description: 'Paiement Frais de Scolarité',
      amount: -150.00,
      status: TransactionStatus.completed,
      paymentMethod: 'Carte bancaire',
      reference: 'TXN-2024-004',
      studentName: 'Jean Dupont',
      academicPeriod: 'Semestre 1 - 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Historique des Transactions',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black54),
            onPressed: () {
              // Action de filtrage
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: sampleTransactions.length,
        itemBuilder: (context, index) {
          final transaction = sampleTransactions[index];
          return TransactionCard(
            transaction: transaction,
            onTap: () => _showTransactionDetails(context, transaction),
          );
        },
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailsModal(transaction: transaction),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onTap;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(transaction.date),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${transaction.amount > 0 ? '+' : ''}${transaction.amount.toStringAsFixed(2)} €',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: transaction.amount > 0 ? Colors.green[600] : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    transaction.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
                _buildStatusChip(transaction.status),
              ],
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Voir les détails',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(TransactionStatus status) {
    Color color;
    String text;

    switch (status) {
      case TransactionStatus.completed:
        color = Colors.green;
        text = 'Terminé';
        break;
      case TransactionStatus.pending:
        color = Colors.orange;
        text = 'En attente';
        break;
      case TransactionStatus.failed:
        color = Colors.red;
        text = 'Échoué';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun',
      'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}. ${date.year}';
  }
}

class TransactionDetailsModal extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsModal({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Détails de la Transaction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow('Date et heure', _formatDateTime(transaction.date)),
                  _buildDetailRow('Description', transaction.description),
                  _buildDetailRow('Montant', '${transaction.amount > 0 ? '+' : ''}${transaction.amount.toStringAsFixed(2)} €'),
                  _buildDetailRow('Statut', _getStatusText(transaction.status)),
                  _buildDetailRow('Méthode de paiement', transaction.paymentMethod),
                  _buildDetailRow('Référence', transaction.reference),
                  _buildDetailRow('Nom de l\'étudiant', transaction.studentName),
                  _buildDetailRow('Période académique', transaction.academicPeriod),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Fermer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    const months = [
      'janvier', 'février', 'mars', 'avril', 'mai', 'juin',
      'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'Terminé';
      case TransactionStatus.pending:
        return 'En attente';
      case TransactionStatus.failed:
        return 'Échoué';
    }
  }
}

