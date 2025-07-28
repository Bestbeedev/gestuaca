import 'package:gestuaca/stores/data.dart';
import 'package:flutter/material.dart';
import 'package:gestuaca/widgets/navigation/navigation_bar_custom.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;


  // Appel des méthodes getToken et getUser de la classe Stores

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blueAccent[700],
            title: Text(
              'Dashboard',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  // Handle profile
                },
              ),
            ],
          ),
          drawer: Drawer(
            width: 250,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent[700]),
                  child: Text(
                    'Menu',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.people_alt),
                  title: Text('Etudiants'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Cours'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Calendrier'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Paramètres'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Bienvenue dans votre tableau de bord',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'Ici, vous pouvez accéder à toutes les fonctionnalités importantes de votre application.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Token and user : ',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/panels/students/dash'
                              'board',
                            );
                          },
                          child: Text('Go to students dashboard'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBarCustom(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            icons: iconsDirector,
            activeIcons: activeIconsDirector,
          ),
        ),
      ),
    );
  }
}
