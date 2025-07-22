import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardStudents extends StatefulWidget {
  const DashboardStudents({super.key});

  @override
  State<DashboardStudents> createState() => _DashboardStudentsState();
}

class _DashboardStudentsState extends State<DashboardStudents> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Salut, Joshua',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 8),
              Text(
                'Bienvenue dans votre tableau de bord Etudiant',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 150,
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 280,
                          maxHeight: 150,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigoAccent),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo[600]?.withValues(alpha: 0.5),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 35,
                      left: 10,
                      child: CircleAvatar(child:
                      Image(
                        image: AssetImage
                          ('assets/images/category/gestuacaLogo.png'),
                        width: 180,
                        height: 180,
                      ),
                      ),
                    ),
                  ],
                ),
              ),



              Card(
                child: Column(
                  children: [
                    Text("Année scolaire : 2024 - 2025"),
                    Text("Niveau : L2 Informatique"),
                    Text("Statut inscription : ✅ Validée"),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
