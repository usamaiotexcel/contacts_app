import 'package:contacts_app/features/contacts/screens/add_edit_contact_screen.dart';
import 'package:contacts_app/features/contacts/screens/contacts_list_screen.dart';
import 'package:contacts_app/features/contacts/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final pages = const [
 ContactsListScreen(),
 FavoritesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: Padding(
        padding: Responsive.horizontalPadding(context),
        child: pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
setState((){ currentIndex = i;});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: "Contacts",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return AddEditContactScreen();
          }));
         
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
