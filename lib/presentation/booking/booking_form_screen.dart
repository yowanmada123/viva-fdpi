import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _priceListController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();

  String? _selectedSite;
  String? _selectedCluster;
  String? _selectedHouseItem;
  String? _selectedPaymentTerm;
  String? _selectedBank;

  List<String> sites = ['Site A', 'Site B', 'Site C'];
  List<String> clusters = ['Cluster X', 'Cluster Y', 'Cluster Z'];
  List<String> houseItems = ['Type 1', 'Type 2', 'Type 3'];
  List<String> paymentTerms = ['Cash', 'Credit', 'Installment'];
  List<String> banks = ['BCA', 'Mandiri', 'BNI', 'BRI'];

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _teleponController.dispose();
    _priceListController.dispose();
    _expDateController.dispose();
    super.dispose();
  }

  Future<void> _selectExpDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (picked != null) {
      setState(() {
        _expDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Form'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Field
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Alamat Field
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // No HP & Telepon Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _noHpController,
                      decoration: const InputDecoration(
                        labelText: 'No HP',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No HP harus diisi';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: TextFormField(
                      controller: _teleponController,
                      decoration: const InputDecoration(
                        labelText: 'Telepon',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Site, Cluster, House Item Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSite,
                      decoration: const InputDecoration(
                        labelText: 'Site',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          sites.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSite = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih site';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCluster,
                      decoration: const InputDecoration(
                        labelText: 'Cluster',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          clusters.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCluster = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih cluster';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedHouseItem,
                      decoration: const InputDecoration(
                        labelText: 'House Item',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          houseItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedHouseItem = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih house item';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Price List Field
              TextFormField(
                controller: _priceListController,
                decoration: const InputDecoration(
                  labelText: 'Price List',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price list harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),

              // Payment Term & Bank Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPaymentTerm,
                      decoration: const InputDecoration(
                        labelText: 'Payment Term',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          paymentTerms.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentTerm = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih payment term';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedBank,
                      decoration: const InputDecoration(
                        labelText: 'Bank',
                        border: OutlineInputBorder(),
                      ),
                      items:
                          banks.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBank = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Exp Date Field
              TextFormField(
                controller: _expDateController,
                decoration: InputDecoration(
                  labelText: 'Exp Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectExpDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Exp date harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
