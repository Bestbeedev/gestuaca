import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  // Appel des méthodes getToken et getUser de la classe Stores

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: SingleChildScrollView(child: ModernDashboard()),
      ),
    );
  }
}

class ModernDashboard extends StatelessWidget {
  const ModernDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tableau de Bord",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Statistiques Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
            children: [
              _buildStatCard(
                context,
                title: "Étudiants",
                titleSuite: "inscrits",
                value: "24",
                //subtitle: "Aujourd'hui",
                icon: CupertinoIcons.person_2,
                color: Colors.blue,
              ),
              _buildStatCard(
                context,
                title: "Paiements",
                titleSuite: "du mois",
                value: "125450 F",
                //subtitle: "+15% vs mois dernier",
                icon: CupertinoIcons.money_dollar_circle,
                color: Colors.green,
              ),
              _buildStatCard(
                context,
                title: "Profs",
                titleSuite: "enregistrés",
                value: "18",
                //subtitle: "En ligne maintenant",
                icon: CupertinoIcons.person_3,
                color: Colors.orange,
              ),
              _buildStatCard(
                context,
                title: "Taux",
                titleSuite: "Occupation",
                value: "78%",
                //subtitle: "Salles de classe",
                icon: CupertinoIcons.chart_bar_alt_fill,
                color: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Inscriptions en attente
          _buildSectionHeader(
            context,
            title: "Inscriptions en attente",
            action: "Voir tout",
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              children: [
                _buildPendingItem(
                  name: "Jean Dupont",
                  program: "Informatique - L2",
                  date: "12/05/2023",
                  statusColor: Colors.orange,
                ),
                const Divider(height: 20),
                _buildPendingItem(
                  name: "Marie Lambert",
                  program: "Gestion - L1",
                  date: "11/05/2023",
                  statusColor: Colors.orange,
                ),
                const Divider(height: 20),
                _buildPendingItem(
                  name: "Paul Martin",
                  program: "Droit - L3",
                  date: "10/05/2023",
                  statusColor: Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Filières et niveaux
          _buildSectionHeader(
            context,
            title: "Vue sur les filières",
            action: "Détails",
          ),
          Container(
            padding: EdgeInsets.all(1),
            child: SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProgramCard(
                    context,
                    title: "Informatique",
                    students: 120,
                    levels: 3,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 15),
                  _buildProgramCard(
                    context,
                    title: "Gestion",
                    students: 85,
                    levels: 3,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 15),
                  _buildProgramCard(
                    context,
                    title: "Droit",
                    students: 64,
                    levels: 4,
                    color: Colors.purple,
                  ),
                  const SizedBox(width: 15),
                  _buildProgramCard(
                    context,
                    title: "Médecine",
                    students: 42,
                    levels: 5,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    //required String subtitle,
    required IconData icon,
    required Color color,
    required String titleSuite,
  }) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: const EdgeInsets.all(10),
        constraints: const BoxConstraints(minHeight: 300),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // 🔥 très important pour éviter que ça prenne toute la hauteur
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 5,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[900],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      titleSuite,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[900],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 3),
            Divider(color: Colors.grey[300], thickness: 1),
            Center(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Subtitle with green color
            // Text(
            //   subtitle,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //     color: Colors.green,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String action,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
            fontSize: 20,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(action, style: TextStyle(color: Colors.indigo[400])),
        ),
      ],
    );
  }

  Widget _buildPendingItem({
    required String name,
    required String program,
    required String date,
    required Color statusColor,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person, color: Colors.indigo[400]),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                program,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(date, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "En attente",
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgramCard(
    BuildContext context, {
    required String title,
    required int students,
    required int levels,
    required Color color,
  }) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.book, color: color),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(
                "$students étudiants",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.leaderboard, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(
                "$levels niveaux",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
