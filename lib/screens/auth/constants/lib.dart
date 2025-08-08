import '../../../stores/states.dart';

class AuthConstants {
  // Vérifie si l'utilisateur a payé la scolarité
static bool isHasPaid= false;
  AuthConstants() {
    Store.hasPaidScolarite().then((value) {
      isHasPaid = value;
    });
  }
  static String? redirectRole(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez sélectionner un type d\'utilisateur';
    } else {
      // Vérification de la validité du type d'utilisateur
      final validRoles = ['membre_administratifs'];
      if (validRoles.contains(value.toLowerCase())) {
        return '/panels/directeur/dashboard';
      }
      final validRolesAdmins = ['admin'];
      if (validRolesAdmins.contains(value.toLowerCase())) {
        return '/panels/directeur/dashboard';
      }
      final validRolesTeachers = ['enseignant'];
      if (validRolesTeachers.contains(value.toLowerCase())) {
        return '/panels/teachers/dashboard';
      }
      final validRolesStudents = ['etudiant'];
      print('value: $value, isHasPaid: $isHasPaid');
      if (validRolesStudents.contains(value.toLowerCase()) &&
          isHasPaid == true) {
        return '/panels/students/dashboard';
      } else if (validRolesStudents.contains(value.toLowerCase()) &&
          isHasPaid == false) {
        return '/payments';
      }
    }
    return 'Type d\'utilisateur non valide';
  }
}
