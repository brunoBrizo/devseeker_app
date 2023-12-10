import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/views/common/loader.dart';
import 'package:devseeker_app/views/common/pages_loader.dart';
import 'package:devseeker_app/views/common/styled_container.dart';
import 'package:devseeker_app/views/ui/agent/widgets/uploaded_job_tile.dart';
import 'package:provider/provider.dart';

class PopularJobList extends StatelessWidget {
  const PopularJobList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        return buildStyleContainer(
          context,
          FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.jobList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return Text("Error ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const NoSearchResults(text: "No Jobs to display");
                } else {
                  final job = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListView.builder(
                        itemCount: job!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final jobs = job[index];
                          return UploadedTile(
                            text: 'pop',
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
