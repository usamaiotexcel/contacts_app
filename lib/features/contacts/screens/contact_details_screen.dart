import 'package:contacts_app/features/contacts/Providers/contact_provider.dart';
import 'package:contacts_app/features/contacts/models/contacts.dart';
import 'package:contacts_app/features/contacts/screens/add_edit_contact_screen.dart';
import 'package:contacts_app/features/contacts/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsScreen extends StatefulWidget {
  final Contact? contact;
  const ContactDetailsScreen({this.contact});

  @override
  State<ContactDetailsScreen> createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Contact Details",style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.white,
    actions: [
      ElevatedButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditContactScreen(contact: widget.contact),
                ),
              );
      }, child: Text('Edit'))
    ],),
    body: Container(
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.white, Colors.grey , Colors.white])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Center(child: Text(widget.contact!.name[0], style: TextStyle(color: Colors.black,fontSize: 125, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),)),
        Center(
              child: Text(
                widget.contact!.name.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
             
        
        Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.black, size: 50),
                  onPressed: () async {
                    final Uri url = Uri.parse("tel:${widget.contact!.phone}");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                ),
          
          
                IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 50),
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
                      context.read<ContactProvider>().deleteContact(widget.contact!.id);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return HomeScreen();
                      }));
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
            Card(
              elevation: 5,
              child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: [
                    Center(
                      child: Text(
                        widget.contact!.phone.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Divider(),
                    
                    Center(
                      
                      child: Text(
                        widget.contact!.email,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
              ],),
            ),)
      ],),
    ),
    );
  }
}