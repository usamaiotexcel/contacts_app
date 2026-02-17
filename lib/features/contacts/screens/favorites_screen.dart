import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/features/contacts/Providers/contact_provider.dart';
import 'package:contacts_app/features/contacts/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: AppTheme.fvrtCardTextColor, fontWeight: FontWeight.bold);

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
                builder: (_) => ContactDetailsScreen(contact: contact),
              ),
            );
          },
          child: Card(
            color: Colors.black,
                     elevation: 4,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
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
