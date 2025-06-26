import 'package:flutter/material.dart';

import '../../models/QC/SPK.dart';
import '../SPK/spk_checklist_screen.dart';

class GroupedSPKList extends StatelessWidget {
  final List<SPKGroupedByClusterHome> groupedSPK;

  const GroupedSPKList({Key? key, required this.groupedSPK}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: groupedSPK.length,
      itemBuilder: (context, index) {
        final group = groupedSPK[index];
        return Card(
          color: Colors.white,
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.clusterName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  group.houseName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            children:
                group.spks.map((spk) {
                  return ListTile(
                    title: Text(spk.spkLabel),
                    onTap: () => _navigateToChecklist(context, spk.qcTransId),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _navigateToChecklist(BuildContext context, String qcTransId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewSpkChecklistScreen(qcTransId: qcTransId),
      ),
    );
  }
}
