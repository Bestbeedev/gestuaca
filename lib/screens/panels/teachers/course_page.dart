import 'package:flutter/material.dart';


class CoursePageTeachers extends StatelessWidget {
  const CoursePageTeachers({super.key});

  @override
  Widget build(BuildContext context) {
    return TeacherCoursesPage();
  }
}


class TeacherCoursesPage extends StatelessWidget {
   TeacherCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // En-tête
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mes Cours',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter),
                  color: Colors.indigo[900],
                ),
              ],
            ),
          ),

          // Liste des cours
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return _buildCourseCard(context, course);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // En-tête de la carte
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getCourseColor(course['subject']).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getCourseColor(course['subject']),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.book, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['subject'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course['level'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Détails du cours
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCourseDetail(
                  icon: Icons.people,
                  value: '${course['studentCount']}',
                  label: 'Étudiants',
                ),
                _buildCourseDetail(
                  icon: Icons.lock_clock,
                  value: course['schedule'],
                  label: 'Horaire',
                ),
                _buildCourseDetail(
                  icon: Icons.calendar_month,
                  value: course['room'],
                  label: 'Salle',
                ),
              ],
            ),
          ),

          // Bouton d'action
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _viewCourseDetails(course),
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('Voir détails'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.indigo.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDetail({required IconData icon, required String value, required String label}) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Color _getCourseColor(String subject) {
    final colors = {
      'Mathématiques': Colors.blue,
      'Physique': Colors.green,
      'Informatique': Colors.indigo,
      'Français': Colors.orange,
      'Histoire': Colors.purple,
    };
    return colors[subject] ?? Colors.teal;
  }

  void _viewCourseDetails(Map<String, dynamic> course) {
    // Navigation vers la page de détails du cours
    // À implémenter selon votre système de navigation
  }

  // Données de démonstration
  final List<Map<String, dynamic>> _courses = [
    {
      'subject': 'Mathématiques',
      'level': 'L1 Informatique',
      'studentCount': 32,
      'schedule': 'Lun 10h-12h',
      'room': 'B203',
    },
    {
      'subject': 'Algorithmique',
      'level': 'L2 Informatique',
      'studentCount': 28,
      'schedule': 'Mar 14h-16h',
      'room': 'A101',
    },
    {
      'subject': 'Base de données',
      'level': 'L3 Informatique',
      'studentCount': 24,
      'schedule': 'Mer 8h-10h',
      'room': 'B305',
    },
  ];
}