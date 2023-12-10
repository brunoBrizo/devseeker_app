import 'package:flutter/material.dart';
import 'package:devseeker_app/controllers/jobs_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/pages_loader.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';
import 'package:devseeker_app/views/common/styled_container.dart';
import 'package:devseeker_app/views/ui/auth/non_user.dart';
import 'package:devseeker_app/views/ui/bookmarks/widgets/bookmark_widget.dart';
import 'package:provider/provider.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    bool loggedIn = Provider.of<LoginNotifier>(context).loggedIn;
    return Scaffold(
      backgroundColor: const Color(0xFF3281E3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3281E3),
        elevation: 0,
        title: ReusableText(
            text: !loggedIn ? "" : "Bookmarks",
            style: appStyle(16, Colors.white, FontWeight.w600)),
        leading: const Padding(
          padding: EdgeInsets.all(12.0),
          child: DrawerWidget(color: Colors.white),
        ),
      ),
      body: loggedIn == false
          ? const NonUser()
          : Consumer<JobsNotifier>(
              builder: (context, jobsNotifier, child) {
                if (loggedIn == true) {
                  jobsNotifier.getBookMarks();
                }

                return Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Color(0xFFEFFFFC),
                            ),
                            child: buildStyleContainer(
                              context,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: FutureBuilder<List<AllBookMarks>>(
                                  future: jobsNotifier.bookmarks,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const PageLoader();
                                    } else if (snapshot.hasError) {
                                      return Text("Error ${snapshot.error}");
                                    } else {
                                      final bookmark = snapshot.data;
                                      return ListView.builder(
                                        itemCount: bookmark!.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          final bookmarks = bookmark[index];
                                          return BookMarkTileWidget(
                                              job: bookmarks);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            )))
                  ],
                );
              },
            ),
    );
  }
}
