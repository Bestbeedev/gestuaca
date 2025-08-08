import 'package:flutter/material.dart';
import 'package:gestuaca/widgets/auth/custom_form_fields.dart';

// ici c'est la page ou l'etudiant va s'incrire dans son universite nomme GestuAcad dans une
// filiere et niveau exactemen en renseignant toutes les informations possible sur lui. Pour les inputformfield utilise mon CustomTextFormField contenu dans /widgets/auth/custom_form_fiels.dart
class InscriptionsPage extends StatefulWidget {
  const InscriptionsPage({super.key});

  @override
  State<InscriptionsPage> createState() => _InscriptionsPageState();
}

class _InscriptionsPageState extends State<InscriptionsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final String _firstName = '';
  final String _lastName = '';
  final String _email = '';
  final String _phoneNumber = '';
  String? _selectedUniversity;
  String? _selectedFaculty;
  String? _selectedDepartment;
  String? _selectedLevel;

  // Dummy data - replace with actual data fetching logic
  final List<String> _universities = [
    'Université de Yaoundé I',
    'Université de Douala',
    'Université de Dschang',
  ];
  final List<String> _faculties = [
    'Faculté des Sciences',
    'Faculté des Arts, Lettres et Sciences Humaines',
    'Faculté de Médecine',
  ];
  final List<String> _departments = [
    'Informatique',
    'Mathématiques',
    'Physique',
    'Chimie',
    'Histoire',
    'Géographie',
  ];
  final List<String> _levels = [
    'Licence 1',
    'Licence 2',
    'Licence 3',
    'Master 1',
    'Master 2',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Process the data (e.g., send it to a server)
      print('Inscription Details:');
      print('Prénom: $_firstName');
      print('Nom: $_lastName');
      print('Email: $_email');
      print('Téléphone: $_phoneNumber');
      print('Université: $_selectedUniversity');
      print('Faculté: $_selectedFaculty');
      print('Filière: $_selectedDepartment');
      print('Niveau: $_selectedLevel');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Inscription soumise avec succès!')),
      );
    }
  }

  Widget _buildDropdown(
    String label,
    String? currentValue,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      // Allow the dropdown to expand to fill available width
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      value: currentValue,
      items:
          items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
              ), // Handle long text
            );
          }).toList(),
      onChanged: onChanged,
      validator:
          (value) => value == null ? 'Veuillez sélectionner une option' : null,
      // Consider adding a hintText for when no value is selected
      // hint: Text('Sélectionner...'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Formulaire d\'Inscription GestuAcad',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Veuillez remplir tous les champs ci-dessous pour finaliser votre inscription.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: _firstNameController,
              hintText: 'Prénom',
              //onSaved: (value) => _firstName = value!,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Veuillez entrer votre prénom'
                          : null,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _lastNameController,
              hintText: 'Nom',
              //onSaved: (value) => _lastName = value!,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Veuillez entrer votre nom'
                          : null,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _emailController,
              hintText: 'Email',
              //onSaved: (value) => _email = value!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre email';
                }

                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
              //keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _phoneNumberController,
              hintText: 'Numéro de Téléphone',
              //onSaved: (value) => _phoneNumber = value!,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? 'Veuillez entrer votre numéro de téléphone'
                          : null,
              //keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              'Université',
              _selectedUniversity,
              _universities,
              (value) => setState(() => _selectedUniversity = value),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              'Faculté',
              _selectedFaculty,
              _faculties,
              (value) => setState(() => _selectedFaculty = value),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              'Filière',
              _selectedDepartment,
              _departments,
              (value) => setState(() => _selectedDepartment = value),
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              'Niveau',
              _selectedLevel,
              _levels,
              (value) => setState(() => _selectedLevel = value),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text(
                'Soumettre l\'Inscription',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
