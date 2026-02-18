import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/features/contacts/data/contact_provider.dart';
import 'package:contacts_app/features/contacts/screens/add_edit_contact_screen.dart';
import 'package:contacts_app/features/contacts/screens/contact_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactProvider>();

    

if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
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
          
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
          icon: Icon(
            contact.isFavorite ? Icons.star : Icons.star_border,
            color: contact.isFavorite ? Colors.amber : null,
          ),
          onPressed: () =>
              context.read<ContactProvider>().toggleFavorite(contact.id),
                ),
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: () async {
                    final Uri url = Uri.parse("tel:${contact.phone}");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
              ],
            ),
          ),
        );

      
      
      },
    );
  }
}
