import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/views/ui/jobs/job_page.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatelessWidget {
  const PopularJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobNotifier, child) {
        jobNotifier.getJobs();
        return SizedBox(
          height: hieght * 0.28,
          child: FutureBuilder(
            future: jobNotifier.jobList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const HorizontalShimmer();
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              } else {
                final jobs = snapshot.data;
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                  child: ListView.builder(
                      itemCount: jobs!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return JobHorizontalTile(
                          onTap: () {
                            Get.to(() => JobPage(
                                title: job.company,
                                id: job.id,
                                agentName: job.agentName));
                          },
                          job: job,
                        );
                      }),
                );
              }
            },
          ),
        );
      },
    );
  }
}
