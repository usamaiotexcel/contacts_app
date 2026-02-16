import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/features/contacts/Providers/contact_provider.dart';
import 'package:contacts_app/features/contacts/screens/add_edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: AppTheme.fvrtCardTextColor);

    final favorites = context.watch<ContactProvider>().favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text("No favorites yet"));
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (_, i) {
        final contact = favorites[i];

        return GestureDetector(
          onTap: (){
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddEditContactScreen(contact: contact),
              ),
            );
          },
          child: Card(
            color: Colors.black,
                     elevation: 4,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Text(contact.name.toUpperCase(),style: style,),Text(contact.phone,style: style,),
              
              ],),
            ),
           
          ),
        );
      },
    );
  }
}
