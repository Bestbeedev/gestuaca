import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            DrawerHeader(
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Cart"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.store),
              title: Text("Store"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Categories',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tout voir',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 10),
                    children: const [
                      CategoryCard(
                        categoryIcon: 'fruit',
                        categoryName: 'Fruits',
                      ),
                      CategoryCard(
                        categoryIcon: 'vegetable',
                        categoryName: 'Vegetables',
                      ),
                      CategoryCard(categoryIcon: 'food', categoryName: 'Food'),
                      CategoryCard(
                        categoryIcon: 'chicken',
                        categoryName: 'Chicken',
                      ),
                      CategoryCard(categoryIcon: 'cake', categoryName: 'Cakes'),
                      CategoryCard(
                        categoryIcon: 'drink',
                        categoryName: 'Drinks',
                      ),
                    ],
                  ),
                ),
                //Fresh Products
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 3,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Offers',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Fresh Products',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'Tout voir',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 10),
                    children: const [
                      FreshProduceCard(
                        categoryImage: 'avocado',
                        categoryName: 'Organic Natural Avocados',
                        price: '\$23.99',
                      ),
                      FreshProduceCard(
                        categoryImage: 'banana',
                        categoryName: 'Organic Bananas (each)',
                        price: '\$15.00',
                      ),
                      FreshProduceCard(
                        categoryImage: 'carotte',
                        categoryName: 'Natural Carotte (each)',
                        price: '\$17.08',
                      ),
                      FreshProduceCard(
                        categoryImage: 'orange',
                        categoryName: 'Organic Natural Orange',
                        price: '\$67.80',
                      ),
                    ],
                  ),
                ),

                //Snacks
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Snacks',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tout voir',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 280,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 10),
                    children: const [
                      FreshProduceCard(
                        categoryImage: 'cake',
                        categoryName: 'Organic Natural Avocados',
                        price: '\$23.99',
                      ),
                      FreshProduceCard(
                        categoryImage: 'drink',
                        categoryName: 'Organic Bananas (each)',
                        price: '\$15',
                      ),
                      FreshProduceCard(
                        categoryImage: 'cake',
                        categoryName: 'Natural Carotte (each)',
                        price: '\$17',
                      ),
                      FreshProduceCard(
                        categoryImage: 'orange',
                        categoryName: 'Organic Natural Orange',
                        price: '\$67',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 12,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 28),
                activeIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.home, color: Colors.green, size: 32),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined, size: 28),
                activeIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                    size: 32,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront_outlined, size: 28),
                activeIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.storefront, color: Colors.green, size: 32),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, size: 28),
                activeIcon: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.person, color: Colors.green, size: 32),
                ),
                label: '',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.green[900],
            unselectedItemColor: Colors.black54,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryIcon;
  final String? categoryName;

  const CategoryCard({
    super.key,
    required this.categoryIcon,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 100,
          height: 100,

          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            boxShadow: ([
              BoxShadow(
                color: Colors.white24,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ]),
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20),
          child: Image.asset(
            'assets/images/category/$categoryIcon.png',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),

        Container(
          margin: EdgeInsets.only(right: 15),
          child: Text(
            categoryName ?? 'Category',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class FreshProduceCard extends StatefulWidget {
  final String? categoryName;
  final String categoryImage; // Default icon for fresh produce
  final String? price;
  final bool? isFavorite;

  const FreshProduceCard({
    super.key,
    required this.categoryName,
    required this.price,
    required this.categoryImage,
    this.isFavorite,
  });

  @override
  State<FreshProduceCard> createState() => _FreshProduceCardState();
}

class _FreshProduceCardState extends State<FreshProduceCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10),
          width: 155,
          height: 250,

          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            boxShadow: ([
              BoxShadow(
                color: Colors.white24,
                blurRadius: 1,
                offset: Offset(0, 2),
              ),
            ]),
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.only(right: 16, left: 16, top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite ? Colors.red : Colors.black12,
                    size: 22,
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/category/${widget.categoryImage}.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.categoryName ?? 'Fresh Produce',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                widget.price ?? '\$0.00',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
