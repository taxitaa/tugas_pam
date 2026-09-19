import 'package:flutter/material.dart';
import '../models/vendor_model.dart';
import '../services/db_helper.dart';

class VendorCrudScreen extends StatefulWidget {
  const VendorCrudScreen({super.key});

  @override
  State<VendorCrudScreen> createState() => _VendorCrudScreenState();
}

class _VendorCrudScreenState extends State<VendorCrudScreen> {
  List<Vendor> _vendors = [];

  @override
  void initState() {
    super.initState();
    _refreshVendors();
  }

  void _refreshVendors() async {
    final data = await DBHelper.getVendors();
    setState(() {
      _vendors = data;
    });
  }

  void _showFormDialog({Vendor? vendor}) {
    final nameCtrl = TextEditingController(text: vendor?.name ?? '');
    final categoryCtrl = TextEditingController(text: vendor?.category ?? '');
    final priceCtrl = TextEditingController(text: vendor != null ? vendor.price.toString() : '');
    final contactCtrl = TextEditingController(text: vendor?.contact ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(vendor == null ? 'Tambah Vendor' : 'Edit Vendor'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama Vendor')),
              TextField(controller: categoryCtrl, decoration: const InputDecoration(labelText: 'Kategori (Dekor/Katering/dll)')),
              TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga (Rp)')),
              TextField(controller: contactCtrl, decoration: const InputDecoration(labelText: 'Kontak HP')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.isEmpty) return;
              Vendor v = Vendor(
                id: vendor?.id,
                name: nameCtrl.text,
                category: categoryCtrl.text,
                price: double.tryParse(priceCtrl.text) ?? 0,
                contact: contactCtrl.text,
              );
              if (vendor == null) {
                await DBHelper.insertVendor(v);
              } else {
                await DBHelper.updateVendor(v);
              }
              if (mounted) {
                // ignore: use_build_context_synchronously
                Navigator.pop(ctx);
                _refreshVendors();
              }
            },
            child: const Text('Simpan'),
          )
        ],
      ),
    );
  }

  void _deleteVendor(int id) async {
    await DBHelper.deleteVendor(id);
    _refreshVendors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Vendor Pernikahan')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE91E63),
        onPressed: () => _showFormDialog(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _vendors.isEmpty
          ? const Center(child: Text('Belum ada data vendor. Tekan + untuk menambah.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _vendors.length,
              itemBuilder: (ctx, index) {
                final v = _vendors[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text(v.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${v.category} • Rp ${v.price.toStringAsFixed(0)}\nHp: ${v.contact}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _showFormDialog(vendor: v)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteVendor(v.id!)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}