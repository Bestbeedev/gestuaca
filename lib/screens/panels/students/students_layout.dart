import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestuaca/screens/panels/students/payments_page.dart';
import 'package:iconsax/iconsax.dart';
import '../../../stores/data.dart';
import '../../../widgets/navigation/navigation_bar_custom.dart';
import 'dashboard.dart';
import 'course_page.dart';
import 'inscriptions_page.dart';

class StudentsLayout extends StatefulWidget {
  const StudentsLayout({super.key});

  @override
  State<StudentsLayout> createState() => _StudentsLayoutState();
}

class _StudentsLayoutState extends State<StudentsLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardStudents(),
    CoursesPage(),
    PaymentsPage(),
  ];

  final List<String> titlePages = [
    'Accueil',
    'Matières',
    'Paiements',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        title: Text(
          titlePages[_currentIndex],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Badge(
              label: Text('0'),
              offset: Offset(-4, 4),
              child: IconButton(
                icon: Icon(Iconsax.notification,size: 23,),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Icon(Iconsax.profile_circle,size: 23,),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(onPageSelected: (index) { setState(() { _currentIndex = index; }); },),
      body: SingleChildScrollView(child: _pages[_currentIndex]),
      bottomNavigationBar: NavigationBarCustom(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        icons: iconsStudents,
        activeIcons: activeIconsStudents,
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  final List<String> _listPages = [
    'Accueil',
    'Matières',
    'Inscriptions',
    'Paiements',
  ];

  final Function(int) onPageSelected;

   DrawerWidget({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo[700]),
            child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/category/gestuacaLogo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
          ),
          ...List.generate(_listPages.length, (index) {
            return ListTile(
              leading: Icon(iconsStudents[index]),
              title: Text(_listPages[index]),
              onTap: () {
                onPageSelected(index);
                Navigator.pop(context);
              },
            );
          }),
        ],
      ),
    );
  }
}

