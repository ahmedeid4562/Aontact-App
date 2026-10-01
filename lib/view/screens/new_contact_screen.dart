import 'package:contact_app/view/widgwts/custom_text_form_field.dart';
import 'package:contact_app/view/widgwts/custom_material_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String? contactId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null) {
      final data = arguments as Map<String, dynamic>;

      contactId = data["id"];

      nameController.text = data["name"];
      phoneController.text = data["phone"];
    }
  }

  Future<void> saveContact() async {
    if (contactId == null) {
      // Add Contact
      await FirebaseFirestore.instance
          .collection("contact")
          .add({
        "name": nameController.text,
        "phone": phoneController.text,
      });
    } else {
      // Update Contact
      await FirebaseFirestore.instance
          .collection("contact")
          .doc(contactId)
          .update({
        "name": nameController.text,
        "phone": phoneController.text,
      });
    }

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = contactId != null;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF5F7FB),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),

        title: Row(
          children: [
            Icon(
              isEdit ? Icons.edit : Icons.person_add_alt_1,
              color: Colors.black,
            ),

            const SizedBox(width: 10),

            Text(
              isEdit ? "Edit Contact" : "Add Contact",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              // Header
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Icon(
                    isEdit
                        ? Icons.edit
                        : Icons.person_add_alt_1,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  isEdit
                      ? "Update your contact information"
                      : "Create a new contact",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  isEdit
                      ? "Change the information below and save"
                      : "Enter the contact information below",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Contact Information Card
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: "Name",
                        hint: "Enter Name",
                        controller: nameController,
                      ),

                      const SizedBox(height: 18),

                      CustomTextFormField(
                        label: "Phone Number",
                        hint: "Enter Phone Number",
                        controller: phoneController,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: CustomMaterialButton(
                  onPressed: saveContact,
                  text: isEdit ? "Update Contact" : "Save Contact",
                ),
              ),

              const SizedBox(height: 15),

              if (isEdit)
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

