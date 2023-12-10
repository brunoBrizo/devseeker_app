import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/agents_provider.dart';
import 'package:devseeker_app/models/response/applied/applied.dart';
import 'package:devseeker_app/views/common/pages_loader.dart';
import 'package:devseeker_app/views/common/styled_container.dart';
import 'package:devseeker_app/views/ui/applicatons/widgets/applied_job_tile.dart';
import 'package:provider/provider.dart';

class AppliedJob extends StatelessWidget {
  const AppliedJob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AgentsNotifier>(
      builder: (context, agentNotifier, child) {
        agentNotifier.getAppliedList();

        return buildStyleContainer(
          context,
          FutureBuilder<List<Applied>>(
              future: agentNotifier.appliedList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return SizedBox.fromSize();
                } else {
                  final job = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.builder(
                        itemCount: job!.length,
                        itemBuilder: (context, index) {
                          final jobs = job[index].job;
                          return AppliedTile(
                            text: 'agent',
                            job: jobs,
                          );
                        }),
                  );
                }
              }),
        );
      },
    );
  }
}
