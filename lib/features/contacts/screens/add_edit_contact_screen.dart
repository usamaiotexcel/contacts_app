import 'package:contacts_app/features/contacts/data/contact_provider.dart';
import 'package:contacts_app/features/contacts/models/contacts.dart';
import 'package:contacts_app/features/contacts/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditContactScreen extends StatefulWidget {
  final Contact? contact;

  const AddEditContactScreen({super.key, this.contact});

  @override
  State<AddEditContactScreen> createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends State<AddEditContactScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  bool get isEdit => widget.contact != null;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.contact?.name ?? "");
    phoneController = TextEditingController(text: widget.contact?.phone ?? "");
    emailController = TextEditingController(text: widget.contact?.email ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveContact() {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<ContactProvider>();

    if (isEdit) {
      provider.updateContact(
        widget.contact!.id,
        nameController.text.trim(),
        phoneController.text.trim(),
        emailController.text.trim(),
      );
    } else {
      provider.addContact(
        nameController.text.trim(),
        phoneController.text.trim(),
        emailController.text.trim(),
      );
    }

       Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Contact" : "Add Contact")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v!.isEmpty ? "Name required" : null,
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "Phone required";
                      if (v.length < 10 || v.length > 10 ) return "Invalid phone , phone no should be 10 digit";
                      return null;
                    },
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) return "Email required";
                      if (!v.contains("@")) return "Invalid email";
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: saveContact,
                      child: Text(isEdit ? "Update Contact" : "Save Contact"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
