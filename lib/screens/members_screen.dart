import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  final List<Map<String, String>> members = const [
    {'name': 'Anggota 1', 'nim': '123210001', 'role': 'Project Manager'},
    {'name': 'Anggota 2', 'nim': '123210002', 'role': 'Frontend Developer'},
    {'name': 'Anggota 3', 'nim': '123210003', 'role': 'Backend Developer'},
    {'name': 'Anggota 4', 'nim': '123210004', 'role': 'UI/UX Designer'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Anggota Kelompok')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final m = members[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFE91E63),
                child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
              ),
              title: Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('NIM: ${m['nim']}'),
              trailing: Chip(label: Text(m['role']!), backgroundColor: Colors.pink.shade50),
            ),
          );
        },
      ),
    );
  }
}