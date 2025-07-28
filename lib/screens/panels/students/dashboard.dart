import 'package:flutter/material.dart';
import 'package:gestuaca/screens/panels/students/history_page.dart';
import '../../../stores/states.dart';

class DashboardStudents extends StatefulWidget {
  const DashboardStudents({super.key});

  @override
  State<DashboardStudents> createState() => _DashboardStudentsState();
}

class _DashboardStudentsState extends State<DashboardStudents> {
  Map<String, dynamic>? _user;

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 0)); // animation/splash delay
    final user = await Store.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Text(
                'Bienvenue dans votre ',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.indigo,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                'Dashboard Etudiant',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey[800]!.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          spacing: 15,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                'assets/images/category/profile.png',
                              ),
                            ),
                            Column(
                              spacing: 1,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _user != null
                                      ? _user!['name'] + ' '
                                          + 'Wilfred'
                                      : 'Chargement'
                                          '...',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.school,
                                      color: Colors.indigo,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Licence 2',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: Colors.indigo,
                                          size: 12,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'SSRI',
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      color: Colors.indigo,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '0122345789291230',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     color: Colors.black12,
                    //     border: Border.all(
                    //       color: Colors.white10.withValues(alpha: 0.3),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     spacing: 5,
                    //     children: [
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(Icons.info),
                    //         color: Colors.yellow,
                    //       ),
                    //       FilledButton(onPressed: () {}, child: Text("SIL")),
                    //       FilledButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //           "Licence "
                    //           "2",
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(height: 10),
                    //Divider(thickness: 0.4, color: Colors.white),
                  ],
                ),
              ),

              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paiements recents',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    spacing: 0,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Logique pour voir tous les paiements
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HistoryPage(),
                            ),
                          );
                        },
                        child: Row(
                          spacing: 3,
                          children: [
                            Text(
                              'Voir tous',
                              style: Theme.of(
                                context,
                              ).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 15),
              CardsRecentPayments(price: '30.000CFA', date: '20-10-2024'),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class CardsRecentPayments extends StatelessWidget {
  final String price;
  final String date;

  const CardsRecentPayments({
    super.key,
    required this.price,
    required this.date,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true, // Pour qu'il s'adapte au contenu
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(
                    context,
                  ).viewInsets.bottom, // évite le clavier qui cache
              top: 16,
              left: 20,
              right: 20,
            ),
            child: const BottomSheetContent(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(color: Colors.black38.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Motif',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Frais de Scolarite-T1',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.yellow),
                ),
                onPressed: () => _showBottomSheet(context),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Divider(thickness: 0.4, color: Colors.white),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),

                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.yellow,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Montant ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),

                  Text(
                    price,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.yellow,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // Wrap pour gérer la hauteur automatiquement
      children: [
        Center(
          child: Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Détails de la Transaction',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildDetailRow(context, 'Date de la transaction:', '20-10-2024'),
        _buildDetailRow(context, 'Heure:', '14:35:12'),
        _buildDetailRow(
          context,
          'Type de transaction:',
          'Contribution Scolaire',
        ),
        _buildDetailRow(context, 'Montant:', '30.000 CFA', isAmount: true),
        _buildDetailRow(
          context,
          'Statut:',
          'Succès',
          isStatus: true,
          statusColor: Colors.green,
        ),
        _buildDetailRow(context, 'Référence:', 'TRX123456789XYZ'),
        _buildDetailRow(context, 'Payé par:', 'Joshua StankLock'),
        _buildDetailRow(context, 'Motif:', 'Frais de scolarité - Tranche 1'),
        const SizedBox(height: 60),
        Row(
          children: [
            Expanded(
              child:
              ElevatedButton.icon(
                onPressed: () {
                  // Logique pour télécharger le reçu
                  Navigator.pop(context); // Ferme le bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Téléchargement du reçu...')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Reçu'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // Logique pour partager
                  Navigator.pop(context); // Ferme le bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Partage en cours...')),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Partager'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 80), // Espace en bas
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isAmount = false,
    bool isStatus = false,
    Color? statusColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight:
                  isAmount || isStatus ? FontWeight.bold : FontWeight.normal,
              color:
                  isStatus
                      ? statusColor
                      : (isAmount ? Colors.blueAccent : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
