import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import '../../home/presentation/ui/widgets/common_page_appbar.dart';

class PoDetailsScreen extends StatefulWidget {
  const PoDetailsScreen({super.key});

  @override
  State<PoDetailsScreen> createState() => _PoDetailsScreenState();
}

class _PoDetailsScreenState extends State<PoDetailsScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonPageAppBar(
        title: "PO Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCompanyDetails(),
              const SizedBox(height: 20),
              _buildPoDetails(),
              const SizedBox(height: 20),
              _buildAddressSlider(),
              const SizedBox(height: 20),
              _buildItemsList(),
              const SizedBox(height: 20),
              _buildTotalAmounts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTotalAmounts() {
    final totalAmounts = {
      'Basic Amount': '87770.00',
      'SGST Amount': '386777.60',
      'CGST Amount': '386777.60',
      'IGST Amount': '0.00',
      'Total Amount': '111943.60',
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black)),
          const SizedBox(height: 8),
          ...totalAmounts.entries.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                Text(entry.value, style: const TextStyle(color: Colors.black),),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildCompanyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ASAT LOGISTICS PRIVATE LIMITED - RAJASTHAN',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.black),
        ),
        const Text(
          'Address: NH-8, GRAM GIDANI, JAIPUR-303008',
          style: TextStyle(color: Colors.black),
        ),
        const Text('Ph No: 9079186165', style: TextStyle(color: Colors.black)),
        const Text('GST No: 08ABICS2783C1Z8',
            style: TextStyle(color: Colors.black)),
        const Text('Email Id: asatlogisticspvtltd@gmail.com',
            style: TextStyle(color: Colors.black)),
        const Text('CIN No: U65990DL2022PTC396661',
            style: TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildPoDetails() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PURCHASE ORDER',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black)),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PO No: PO/2324/0042',
                  style: TextStyle(color: Colors.black)),
              Text('PO Date: 03-01-2024',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSlider() {
    final addressData = [
      {
        'title': 'Vendor',
        'details': {
          'Name': 'Sharda Motors',
          'Address': 'A-3, Sethi Colony, Transport Nagar, Jaipur',
          'Email Id': 'ashish93es@gmail.com',
          'GST No': '08AAGFS8242L1ZP',
        },
      },
      {
        'title': 'Billed To',
        'details': {
          'Name': 'ASAT LOGISTICS PRIVATE LIMITED - RAJASTHAN',
          'Address': 'NH-8, GRAM GIDANI, JAIPUR',
          'Ph No': '9079186165',
          'Contact Person': 'lalit kesnani',
          'Email Id': 'asatlogisticspvtltd@gmail.com',
          'GST No': '08ABICS2783C1Z8',
        },
      },
      {
        'title': 'Shipped To',
        'details': {
          'Name': 'ASAT LOGISTICS PRIVATE LIMITED - RAJASTHAN',
          'Address': 'NH-8, GRAM GIDANI, JAIPUR',
          'Ph No': '9079186165',
          'Contact Person': 'lalit kesnani',
          'Email Id': 'asatlogisticspvtltd@gmail.com',
          'GST No': '08ABICS2783C1Z8',
        },
      },
    ];

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          addressData.length,
          (index) {
            return Container(
              width: 350,
              padding: const EdgeInsets.only(right: 16),
              child: _buildAddressCard(
                addressData[index]['title'] as String,
                addressData[index]['details'] as Map<String, String>,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddressCard(String title, Map<String, String> details) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black)),
            const SizedBox(height: 8),
            ...details.entries.map((e) => Text(
                  '${e.key}: ${e.value}',
                  style: const TextStyle(color: Colors.black),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Items',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.black)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                  label: Text(
                'Sr No.',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Item Name',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Brand Name',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Qty',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'UOM',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Rate',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Basic',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'SGST',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'CGST',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'IGST',
                style: TextStyle(color: Colors.black),
              )),
              DataColumn(
                  label: Text(
                'Gross Amount',
                style: TextStyle(color: Colors.black),
              )),
            ],
            rows: List.generate(5, (index) => _buildDataRow(index + 1)),
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(
          index.toString(),
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          'Self Assy. /Starter Assay. (FH000500/FZT03900)',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          'Remould',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '10.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          'NOS',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '7800.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '78000.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '10920.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '10920.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '0.00',
          style: TextStyle(color: Colors.black),
        )),
        DataCell(Text(
          '99840.00',
          style: TextStyle(color: Colors.black),
        )),
      ],
    );
  }
}
