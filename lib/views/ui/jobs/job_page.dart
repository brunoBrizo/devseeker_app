import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/models/request/applied/applied.dart';
import 'package:devseeker_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:devseeker_app/models/response/jobs/get_job.dart';
import 'package:devseeker_app/services/firebase_services.dart';
import 'package:devseeker_app/services/helpers/applied_helper.dart';
import 'package:devseeker_app/services/helpers/jobs_helper.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/app_bar.dart';
import 'package:devseeker_app/views/common/custom_outline_btn.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/height_spacer.dart';
import 'package:devseeker_app/views/common/pages_loader.dart';
import 'package:devseeker_app/views/common/styled_container.dart';
import 'package:devseeker_app/views/ui/jobs/edit_jobs.dart';
import 'package:devseeker_app/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPage extends StatefulWidget {
  const JobPage(
      {super.key,
      required this.title,
      required this.id,
      required this.agentName});

  final String title;
  final String id;
  final String agentName;

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late Future<GetJobRes>? _job;
  String userUid = '';
  String username = '';

  String sender = '';

  @override
  void initState() {
    _job = JobsHelper.getJob(widget.id);
    getUserUid();
    super.initState();
  }

  getUserUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userUid = prefs.getString('uid') ?? '';
    username = prefs.getString('username') ?? 'Andre';
    sender = prefs.getString('profile') ?? '';
  }

  FirebaseServices services = FirebaseServices();

  createChatRoom(Map<String, dynamic> jobDetails, List<String> users,
      String chatRoomId, messageType, String imageUrl) async {
    Map<String, dynamic> chatData = {
      'users': users,
      'chatRoomId': chatRoomId,
      'read': false,
      'job': jobDetails,
      'profile': imageUrl,
      'sender': sender,
      'name': username,
      'agentName': widget.agentName,
      'messageType': messageType,
      'lastChat':
          "Good Morning! Sir. I'm interested in this job. Please let me know if you have any questions. Thank you!",
      'lastChatTime': DateTime.now()
    };
    services.createChatRoom(
      chatData: chatData,
    );
  }

  @override
  Widget build(BuildContext context) {
    var loggedIn = Provider.of<LoginNotifier>(context).loggedIn;
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        if (loggedIn == true) {
          jobsNotifier.getBookmark(widget.id);
        }

        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: CustomAppBar(
                  text: widget.title,
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (jobsNotifier.isBookmark == false) {
                          BookmarkReqResModel model =
                              BookmarkReqResModel(job: widget.id);
                          jobsNotifier.addBookMark(model);
                          // jobsNotifier.getBookmark(widget.id);
                        } else {
                          jobsNotifier.deleteBookMark(jobsNotifier.bookMarkId);
                          jobsNotifier.getBookmark(widget.id);
                        }
                      },
                      child: loggedIn == false
                          ? SizedBox.fromSize()
                          : Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: jobsNotifier.isBookmark == false
                                  ? const Icon(Fontisto.bookmark)
                                  : const Icon(Fontisto.bookmark_alt),
                            ),
                    )
                  ],
                  child: const BackBtn()),
            ),
            body: buildStyleContainer(
              context,
              FutureBuilder(
                  future: _job,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const PageLoader();
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    } else {
                      final job = snapshot.data;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Stack(
                          children: [
                            ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Container(
                                  width: width,
                                  height: hieght * 0.27,
                                  decoration: BoxDecoration(
                                      color: Color(kLightGrey.value),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/jobs.png'),
                                          fit: BoxFit.fitWidth,
                                          opacity: 0.35),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(9))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(job!.imageUrl),
                                      ),
                                      const HeightSpacer(size: 10),
                                      ReusableText(
                                          text: job.title,
                                          style: appStyle(
                                              16,
                                              Color(kDark.value),
                                              FontWeight.w600)),
                                      const HeightSpacer(size: 5),
                                      ReusableText(
                                          text: job.location,
                                          style: appStyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.normal)),
                                      const HeightSpacer(size: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomOutlineBtn(
                                                width: width * 0.26,
                                                height: hieght * 0.04,
                                                color2: Color(kLight.value),
                                                text: job.contract,
                                                color: Color(kOrange.value)),
                                            Row(
                                              children: [
                                                ReusableText(
                                                    text: job.salary,
                                                    style: appStyle(
                                                        16,
                                                        Color(kDark.value),
                                                        FontWeight.w600)),
                                                ReusableText(
                                                    text: "/${job.period}",
                                                    style: appStyle(
                                                        16,
                                                        Color(kDark.value),
                                                        FontWeight.w600))
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const HeightSpacer(size: 20),
                                ReusableText(
                                    text: "Description",
                                    style: appStyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                                const HeightSpacer(size: 10),
                                Text(
                                  job.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 8,
                                  style: appStyle(12, Color(kDarkGrey.value),
                                      FontWeight.normal),
                                ),
                                const HeightSpacer(size: 20),
                                ReusableText(
                                    text: "Requirements",
                                    style: appStyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                                const HeightSpacer(size: 10),
                                SizedBox(
                                  height: hieght * 0.6,
                                  child: ListView.builder(
                                      itemCount: job.requirements.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final req = job.requirements[index];
                                        String bullet = "\u2022";
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12.0),
                                          child: Text(
                                            "$bullet $req\n",
                                            maxLines: 4,
                                            textAlign: TextAlign.justify,
                                            style: appStyle(
                                                12,
                                                Color(kDarkGrey.value),
                                                FontWeight.normal),
                                          ),
                                        );
                                      }),
                                ),
                                const HeightSpacer(size: 20),
                              ],
                            ),
                            job.agentId != userUid
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: CustomOutlineBtn(
                                          onTap: () async {
                                            String messageType = "text";
                                            String chatRoomId =
                                                "${job.id}.$userUid";
                                            List<String> users = [
                                              job.agentId,
                                              userUid,
                                            ];

                                            Map<String, dynamic> jobDetails = {
                                              'job_id': job.id,
                                              'image_url': job.imageUrl,
                                              'salary':
                                                  "${job.salary} per ${job.period}",
                                              'title': job.title,
                                              'company': job.company,
                                            };

                                            bool doesChatExist = await services
                                                .chatRoomExists(chatRoomId);

                                            if (doesChatExist == false) {
                                              createChatRoom(
                                                  jobDetails,
                                                  users,
                                                  chatRoomId,
                                                  messageType,
                                                  job.imageUrl);
                                              zoomNotifier.currentIndex = 1;

                                              AppliedPost model =
                                                  AppliedPost(job: job.id);

                                              AppliedHelper.applyJob(model);
                                              Get.to(() => const MainScreen());
                                            } else {
                                              zoomNotifier.currentIndex = 1;
                                              Get.to(() => const MainScreen());
                                            }
                                          },
                                          color2: Color(kOrange.value),
                                          width: width,
                                          height: hieght * 0.06,
                                          text: loggedIn == false
                                              ? "Please login to apply"
                                              : "Apply Now",
                                          color: Color(kLight.value)),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: CustomOutlineBtn(
                                          onTap: () async {
                                            editable = job;
                                            Get.to(() => const EditJobs());
                                          },
                                          color2: Color(kOrange.value),
                                          width: width,
                                          height: hieght * 0.06,
                                          text: loggedIn == false
                                              ? "Please login to apply"
                                              : "Edit Job Details",
                                          color: Color(kLight.value)),
                                    ),
                                  )
                          ],
                        ),
                      );
                    }
                  }),
            ));
      },
    );
  }
}
