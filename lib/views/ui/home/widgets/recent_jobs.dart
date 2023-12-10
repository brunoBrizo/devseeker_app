import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/views/common/vertical_shimmer.dart';
import 'package:devseeker_app/views/common/vertical_tile.dart';
import 'package:devseeker_app/views/ui/jobs/job_page.dart';
import 'package:provider/provider.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobNotifier, child) {
        jobNotifier.getRecent();
        return FutureBuilder(
          future: jobNotifier.recent,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const VerticalShimmer();
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              final jobs = snapshot.data;
              return VerticalTile(
                onTap: () {
                  Get.to(
                    () => JobPage(
                        title: jobs!.company,
                        id: jobs.id,
                        agentName: jobs.agentName),
                  );
                },
                job: jobs,
              );
            }
          },
        );
      },
    );
  }
}
