import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Barre de recherche et bouton d'ajout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un utilisateur...',
                        prefixIcon: const Icon(Icons.search, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _showAddUserDialog(),
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person_add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Onglets
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              //labelPadding: EdgeInsets.symmetric(horizontal: 10,vertical:
              // 1),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.indigo,
              ),

              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minWidth: 30,maxWidth:
                    100),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Étudiants',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minWidth: 100,maxWidth:
                    140),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Enseignants',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(minWidth: 140,maxWidth:
                    180),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Membres Administratifs',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filtres
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                _buildFilterChip('Toutes filières', Icons.build),
                _buildFilterChip('L1', Icons.calendar_today),
                _buildFilterChip('L2', Icons.calendar_today),
                _buildFilterChip('L3', Icons.calendar_today),
                _buildFilterChip('Informatique', Icons.code),
                _buildFilterChip('Gestion', Icons.graphic_eq),
              ],
            ),
          ),

          // Liste des utilisateurs
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUserList(isStudent: true),
                _buildUserList(isTeacher: true),
                _buildUserList(isAdmin: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        selected: false,
        onSelected: (bool value) {},
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 5),
            Text(label),
          ],
        ),
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.indigo[100],
        labelStyle: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildUserList({
    bool isStudent = false,
    bool isTeacher = false,
    bool isAdmin = false,
  }) {
    final List<Map<String, dynamic>> users = [
      {
        'name': 'Jean Dupont',
        'email': 'jean.dupont@email.com',
        'role':
            isStudent
                ? 'L2 Informatique'
                : (isTeacher ? 'Professeur Maths' : 'Admin System'),
        'active': true,
        'avatar': 'JD',
      },
      {
        'name': 'Marie Lambert',
        'email': 'marie.lambert@email.com',
        'role':
            isStudent
                ? 'L1 Gestion'
                : (isTeacher ? 'Professeur Eco' : 'Admin RH'),
        'active': true,
        'avatar': 'ML',
      },
      {
        'name': 'Paul Martin',
        'email': 'paul.martin@email.com',
        'role':
            isStudent
                ? 'L3 Droit'
                : (isTeacher ? 'Professeur Droit' : 'Admin Finances'),
        'active': false,
        'avatar': 'PM',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  user['active'] ? Colors.indigo[100] : Colors.grey[300],
              child: Text(
                user['avatar'],
                style: TextStyle(
                  color: user['active'] ? Colors.indigo : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              user['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: user['active'] ? null : Colors.grey,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['email']),
                const SizedBox(height: 2),
                Text(
                  user['role'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      child: const Text('Modifier'),
                      onTap: () => _showEditUserDialog(user),
                    ),
                    PopupMenuItem(
                      child: Text(user['active'] ? 'Désactiver' : 'Activer'),
                      onTap: () => _toggleUserStatus(user),
                    ),
                  ],
            ),
          ),
        );
      },
    );
  }

  void _showAddUserDialog() {
    // Implémentez la logique d'ajout d'utilisateur
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    // Implémentez la logique de modification d'utilisateur
  }

  void _toggleUserStatus(Map<String, dynamic> user) {
    // Implémentez la logique de changement de statut
  }
}
