import 'package:contact_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> deleteContact(String id) async {
    await FirebaseFirestore.instance
        .collection("contact")
        .doc(id)
        .delete();
  }

  Future<void> addContact() async {
    await Navigator.pushNamed(
      context,
      AppRoutes.newcontact,
    );
  }

  Future<void> editContact(
    String id,
    String name,
    String phone,
  ) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.newcontact,
      arguments: {
        "id": id,
        "name": name,
        "phone": phone,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          "Ahmed Eid",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.black,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("contact")
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          final contacts = snapshot.data!.docs;

          return ListView.builder(
            itemBuilder: (context, index) {

              final contact = contacts[index];

              return CardPerson(
                title: contact["name"],
                subtitle: contact["phone"],

                onEdit: () {
                  editContact(
                    contact.id,
                    contact["name"],
                    contact["phone"],
                  );
                },

                onDelete: () {
                  deleteContact(contact.id);
                },
              );
            },

            itemCount: contacts.length,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        child: const Text(
          "Add +",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class CardPerson extends StatelessWidget {
  const CardPerson({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onDelete,
    required this.onEdit,
  });

  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),

      child: ListTile(
        onTap: onEdit,

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),

        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

