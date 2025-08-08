import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../stores/states.dart';

class DashboardTeachers extends StatefulWidget {
  const DashboardTeachers({super.key});

  @override
  State<DashboardTeachers> createState() => _DashboardTeachersState();
}

class _DashboardTeachersState extends State<DashboardTeachers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.grey[50],
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: TeacherDashboard(),
      ),
    );
  }
}

class TeacherDashboard extends StatelessWidget {
  const TeacherDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        // Header avec infos personnelles
        const HeaderWidget(),
        const SizedBox(height: 20),

        // Statistiques rapides
        _buildQuickStats(context),
        const SizedBox(height: 30),

        // Prochains cours
        _buildNextClasses(context),
        const SizedBox(height: 30),

        // Tâches à faire
        _buildTodoList(context),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          context,
          title: "Total Cours",
          value: "3",
          icon: Iconsax.calendar_1,
          color: Colors.blue,
        ),
        _buildStatCard(
          context,
          title: "Étudiants",
          value: "84",
          icon: Iconsax.people,
          color: Colors.green,
        ),
        _buildStatCard(
          context,
          title: "Devoirs à corriger",
          value: "12",
          icon: Iconsax.document_text,
          color: Colors.orange,
        ),
        _buildStatCard(
          context,
          title: "Moyenne classe",
          value: "14.5",
          icon: Iconsax.chart_2,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
            ],
          ),

          Divider(thickness: 1, color: Colors.grey[300], height: 20),
          const SizedBox(height: 5),
          Center(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextClasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Prochains cours",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              _buildClassItem(
                course: "Algorithmique avancée",
                time: "08:00 - 10:00",
                room: "B203",
                group: "L3 Info - Groupe A",
              ),
              const Divider(height: 1),
              _buildClassItem(
                course: "Base de données",
                time: "10:30 - 12:30",
                room: "A101",
                group: "L2 Info - Groupe B",
              ),
              const Divider(height: 1),
              _buildClassItem(
                course: "Programmation mobile",
                time: "14:00 - 16:00",
                room: "C305",
                group: "L3 Info - Groupe C",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassItem({
    required String course,
    required String time,
    required String room,
    required String group,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Iconsax.book_1, color: Colors.indigo),
      ),
      title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(group),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Iconsax.clock, size: 12, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(time),
              const SizedBox(width: 15),
              Icon(Iconsax.building_3, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(room),
            ],
          ),
        ],
      ),
      trailing: const Icon(
        Iconsax.arrow_right_3,
        size: 16,
        color: Colors.indigo,
      ),
      onTap: () {
        // Navigation vers les détails du cours
      },
    );
  }

  Widget _buildTodoList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tâches à faire",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            TextButton(onPressed: () {}, child: const Text("Voir tout")),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _buildTodoItem(
                task: "Corriger le DS Algorithmique",
                due: "Pour demain",
                urgent: true,
              ),
              const SizedBox(height: 10),
              _buildTodoItem(
                task: "Préparer le TP de BD",
                due: "3 jours restants",
                urgent: false,
              ),
              const SizedBox(height: 10),
              _buildTodoItem(
                task: "Envoyer les notes intermédiaires",
                due: "5 jours restants",
                urgent: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodoItem({
    required String task,
    required String due,
    required bool urgent,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 40,
          decoration: BoxDecoration(
            color: urgent ? Colors.red : Colors.orange,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(
                due,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        Checkbox(
          value: false,
          onChanged: (value) {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
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
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.indigo[100],
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/category/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              // "Professeur ${_user != null ? _user!['name'] : "Loading..."}",
                'Jacob Gourou',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[900],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Informatique - L2/L3",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
