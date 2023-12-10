import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:devseeker_app/models/response/jobs/jobs_response.dart';
import 'package:devseeker_app/services/helpers/jobs_helper.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/loader.dart';
import 'package:devseeker_app/views/common/pages_loader.dart';
import 'package:devseeker_app/views/ui/jobs/widgets/job_tile.dart';
import 'package:devseeker_app/views/ui/search/widgets/custom_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Color(kLight.value)),
        title: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: CustomField(
            hintText: " Search For Jobs",
            controller: search,
            onEditingComplete: () {
              setState(() {});
            },
          ),
        ),
        elevation: 0,
      ),
      body: search.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
              child: FutureBuilder<List<JobsResponse>>(
                future: JobsHelper.searchJobs(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const PageLoader();
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return const NoSearchResults(text: "Job not found");
                  } else {
                    final jobs = snapshot.data;
                    return ListView.builder(
                        itemCount: jobs!.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return VerticalTileWidget(job: job);
                        });
                  }
                },
              ),
            )
          : const NoSearchResults(
              text: "Start Searching For Jobs",
            ),
    );
  }
}
