import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../services/auth_services.dart';
import '../../stores/states.dart';
import '../../widgets/auth/custom_form_fields.dart';
import '../../widgets/forms/custom_dropdown.dart';
import '../auth/constants/lib.dart';

class UserTypeInfoScreen extends StatefulWidget {
  const UserTypeInfoScreen({super.key});

  @override
  State<UserTypeInfoScreen> createState() => _UserTypeInfoScreenState();
}

class _UserTypeInfoScreenState extends State<UserTypeInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Controllers pour les champs de saisie
  final _phoneController = TextEditingController();
  final _typeController = TextEditingController();

  final List<String> _formErrors = [];

  @override
  void dispose() {
    _phoneController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _submit() async {
    //   // 1. Réinitialise les erreurs du formulaire
    _formErrors.clear();
    // 2. Valide les champs
    if (!_formKey.currentState!.validate()) {
      setState(() {}); // Forcer le redraw si erreurs visibles
      return;
    }
    // 3. Vérification du type d'utilisateur
    //True role
    print(_typeController.text.trim());
    print('hasPaidScolarite: ${await Store.hasPaidScolarite()}');

    String findRole(String type) {
      switch (type) {
        case 'Membre Administratifs':
          return 'membre_administratifs';
        case 'Enseignant':
          return 'enseignant';
        case 'Etudiant':
          return 'etudiant';
        default:
          return '';
      }
    }

    // 4. Appel API via AuthService
    try {
      final result = await _authService.chooseRole(
        role: findRole(_typeController.text.trim()),
      );

      // 5. Gestion des erreurs serveur (par exemple credentials invalides)
      if (result['success'] == false) {
        setState(() {
          _formErrors.add(result['message'] ?? 'Une erreur est survenue.');
        });
        return;
      }



      // 6. Sauvegarde token + user
      await Store.setToken(result['token'] ?? "");
      await Store.saveUser(result['user'] ?? "");

      if (result['user']['role'] == 'etudiant') {
        await Store.setHasPaidScolarite(result['user']['has_paid_scolarite'] ?? false);
      }

      // 6. SnackBar de succès
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.green[100],
                border: Border.all(color: Colors.green[300]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                result['message'] ?? 'Enregistrement réussi',
                style: TextStyle(color: Colors.green[600]),
              ),
            ),
          ),
        );
      }

      // 7. Redirection si le widget est toujours monté
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AuthConstants.redirectRole(findRole(_typeController.text.trim()))!,
          arguments: {
            'phone': _phoneController.text.trim(),
            'type': _typeController.text.trim(),
          },
        );
      }
    } catch (e) {
      // 7. Erreur réseau ou exception
      setState(() {
        _formErrors.add('Erreur de connexion. Veuillez réessayer.');
      });
    } finally {
      setState(
        () {},
      ); // Redessiner le formulaire avec les erreurs ou après succès
    }
  }


  /// Validation du numéro de téléphone
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un numéro de téléphone';
    } else {
      // Le numéro doit commencer par +229 et être suivi de chiffres
      final phoneRegex = RegExp(r'^\+229[0-9]+$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Numéro de téléphone invalide et doit commencer par +229';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Quel type d'utilisateur êtes-vous ?",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Renseignez en premier lieu votre numéro de telephone."
                    " Ensuite, vous pourrez choisir le type "
                    "d'utilisateur que vous êtes.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /// Username Field
                      CustomTextFormField(
                        controller: _phoneController,
                        validator: _validatePhone,
                        hintText: 'Numéro de téléphone',
                        isObscure: false,
                        prefixIcon: CupertinoIcons.phone,
                      ),
                      const SizedBox(height: 20),
                      CustomDropdownExample(
                        controller: _typeController,
                        dataSource: [
                          'Etudiant',
                          'Enseignant',
                          'Membre Administratifs',
                        ],
                        hintText: "S'enregistrer en tant que",
                      ),
                      const SizedBox(height: 20),
                      /// AuthService error (non lié aux champs)
                      if (_formErrors.any(
                        (e) =>
                            !e.toLowerCase().contains('email') &&
                            !e.toLowerCase().contains('mot de passe'),
                      ))
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.red[200]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _formErrors.firstWhere(
                              (e) =>
                                  !e.toLowerCase().contains('email') &&
                                  !e.toLowerCase().contains('mot de passe'),
                            ),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: GoogleFonts.inter(fontSize: 16),
                          ),
                          child: const Text("Continuer"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
