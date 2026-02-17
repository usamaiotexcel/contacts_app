import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/features/contacts/Providers/contact_provider.dart';
import 'package:contacts_app/features/contacts/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactProvider>();

    if (provider.contacts.isEmpty) {
      return const Center(child: Text("No contacts added"));
    }

    return ListView.builder(
      itemCount: provider.contacts.length,
      itemBuilder: (_, i) {
        final contact = provider.contacts[i];

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5)),
            tileColor: Colors.grey.shade400,
            title: Text(contact.name.toUpperCase(),style: TextStyle(color: AppTheme.cardTextColor, fontWeight: FontWeight.bold),),
            subtitle: Text(contact.phone,
              style: TextStyle(color: AppTheme.background, fontWeight: FontWeight.bold),
            ),
          
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactDetailsScreen(contact: contact),
                ),
              );
            },         
            leading: CircleAvatar(
              child: Text(contact.name[0].toUpperCase()),
            ),
          ),
        );
      },
    );
  }
}
