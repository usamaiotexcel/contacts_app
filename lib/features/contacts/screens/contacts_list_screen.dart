import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/features/contacts/Providers/contact_provider.dart';
import 'package:contacts_app/features/contacts/screens/add_edit_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactProvider>();

    if (provider.contacts.isEmpty) {
      return const Center(child: Text("No contacts added"));
    }

    const TextStyle style = TextStyle(color: AppTheme.cardTextColor)
;
    return ListView.builder(
      itemCount: provider.contacts.length,
      itemBuilder: (_, i) {
        final contact = provider.contacts[i];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5)),
            tileColor: Colors.blueGrey,
            title: Text(contact.name.toUpperCase(),style: TextStyle(color: AppTheme.background),),
            subtitle: Text(contact.phone,
              style: TextStyle(color: AppTheme.background),
            ),
          
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditContactScreen(contact: contact),
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
          
          
                IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("Delete Contact"),
                content: const Text("Are you sure?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ContactProvider>().deleteContact(contact.id);
                      Navigator.pop(context);
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            );
          },
                ),
              ],
            ),
          ),
        );

        // return Card(
        //   color: Colors.grey.shade200,
        //   elevation: 2,
        //   shadowColor: Colors.white,
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //       Column(
        //         children: [
        //            Text(contact.name,style: style,),Text(contact.phone,style: style,),
        //         ],
        //       ),
        //      IconButton(
        //       icon: Icon(
        //         contact.isFavorite ? Icons.star : Icons.star_border,
        //         color: contact.isFavorite ? Colors.amber : null,
        //       ),
        //       onPressed: () =>
        //           context.read<ContactProvider>().toggleFavorite(contact.id),
        //     ),
        //     ],),
        //   ),
        // );
        
        
      
      },
    );
  }
}
