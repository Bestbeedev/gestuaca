import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:cupertino_icons/cupertino_icons.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Text(
              'Historique des actifs',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.indigo,
                fontSize: 20,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey[800]!.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1),
                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 3,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            'Frais de scolarité',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      //FilledButton(onPressed: (){}, child: Text("SIL-2")),
                    ],
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '300.000 FCFA',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ), //
                  // Exemple de solde
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 95,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[900]!.withValues(alpha: 0.9),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 3,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.money_dollar_circle,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              'Solde',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 0.4,
                          color: Colors.white, // Couleur de la ligne
                        ),

                        Text(
                          '200.000CFA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ), //
                        // Exemple de solde
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espace entre les deux conteneurs
                Expanded(
                  child: Container(
                    height: 95,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red[900]!.withValues(alpha: 0.9),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          spacing: 3,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              CupertinoIcons.arrow_down,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              'Reste',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 0.4,
                          color: Colors.white, // Couleur de la ligne
                        ),
                        Text(
                          '100.000CFA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ), //
                        // Exemple de solde
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  // Permet au contenu de défiler si nécessaire
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: SingleChildScrollView(
                        // Pour éviter les problèmes de débordement de contenu
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // S'adapte à la hauteur du contenu
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 26),
                            const Text(
                              'Payer les frais de scolarité',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Motif du paiement',
                                border: OutlineInputBorder(),
                                hintText: 'Ex: Première tranche',
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Montant (FCFA)',
                                border: OutlineInputBorder(),
                                hintText: 'Entrez le montant à payer',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Numéro de téléphone (Mobile Money)',
                                border: OutlineInputBorder(),
                                hintText: 'Ex: +225 XX XX XX XX XX',
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Opérateur Mobile Money',
                                border: OutlineInputBorder(),
                              ),
                              items:
                                  <String>[
                                    'Orange Money',
                                    'MTN Mobile Money',
                                    'Moov Money',
                                    'Wave',
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              onChanged: (_) {},
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                // Logique de paiement ici
                                Navigator.pop(
                                  context,
                                ); // Fermer le bottom sheet après l'action
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Confirmer le paiement'),
                            ),
                            const SizedBox(height: 26), // Espace en bas pour
                            // une meilleure apparence
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.paid),
              label: const Text('Payer maintenant'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
