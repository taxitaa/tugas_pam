import 'package:flutter/material.dart';

class VendorCrudScreen extends StatefulWidget {
  const VendorCrudScreen({super.key});

  @override
  State<VendorCrudScreen> createState() => _VendorCrudScreenState();
}

class _VendorCrudScreenState extends State<VendorCrudScreen> {
  final List<Map<String, String>> _vendors = [];

  void _showAddVendorDialog() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Vendor Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Vendor'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Kategori / Layanan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _vendors.add({
                    'name': nameController.text,
                    'category': categoryController.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5C88BF),
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Kelola Vendor Pernikahan'),
        backgroundColor: const Color(0xFF5C88BF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _vendors.isEmpty
          ? Center(
              child: Text(
                'Belum ada data vendor. Tekan + untuk menambah.',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _vendors.length,
              itemBuilder: (context, index) {
                final item = _vendors[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: ListTile(
                    title: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['category']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      onPressed: () {
                        setState(() => _vendors.removeAt(index));
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVendorDialog,
        backgroundColor: const Color(0xFFF472B6), // Pink Pastel Soft
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }
}