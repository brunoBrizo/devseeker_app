import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:devseeker_app/controllers/agents_provider.dart';
import 'package:devseeker_app/controllers/chat_provider.dart';
import 'package:devseeker_app/controllers/login_provider.dart';
import 'package:devseeker_app/controllers/zoom_provider.dart';
import 'package:devseeker_app/models/request/agents/agents.dart';
import 'package:devseeker_app/services/firebase_services.dart';
import 'package:devseeker_app/utils/date.dart';
import 'package:devseeker_app/views/common/drawer/drawer_widget.dart';
import 'package:devseeker_app/views/common/exports.dart';
import 'package:devseeker_app/views/common/loader.dart';
import 'package:devseeker_app/views/ui/agent/agent_page.dart';
import 'package:devseeker_app/views/ui/auth/non_user.dart';
import 'package:devseeker_app/views/ui/chat/chat_page.dart';
import 'package:provider/provider.dart';

class ChatsList extends StatefulWidget {
  const ChatsList({super.key});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> with TickerProviderStateMixin {
  // ignore: prefer_final_fields
  late TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  String imageUrl =
      'https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf-vinci_03.jpeg';

  final FirebaseServices _services = FirebaseServices();

  final Stream<QuerySnapshot> _chats = FirebaseFirestore.instance
      .collection('chats')
      .where('users', arrayContains: userUid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var chatNotifier = Provider.of<ChatNotifier>(context);
    bool loggedIn = loginNotifier.loggedIn;
    chatNotifier.onlineStatus(loggedIn, zoomNotifier);

    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171717),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(12.0),
          child: DrawerWidget(
            color: Colors.white,
          ),
        ),
        title: loggedIn == false
            ? SizedBox.fromSize()
            : TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color(0x00BABABA),
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.white,
                padding: const EdgeInsets.all(3),
                labelStyle: appStyle(12, Colors.white, FontWeight.w500),
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                tabs: const [
                    Tab(
                      text: "MESSAGES",
                    ),
                    Tab(
                      text: "ONLINE",
                    ),
                    Tab(
                      text: "GROUPS",
                    ),
                  ]),
      ),
      body: loggedIn == false
          ? const NonUser()
          : TabBarView(
              controller: _tabController,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 15, left: 25, right: 0),
                        height: 220,
                        decoration: const BoxDecoration(
                            color: Color(0xFF3281E3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReusableText(
                                  text: "Agencies and Companies",
                                  style: appStyle(
                                      12, Colors.white, FontWeight.normal),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      AntDesign.ellipsis1,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            Consumer<AgentsNotifier>(
                              builder: (context, agentsNotifier, child) {
                                var agents = agentsNotifier.getAgents();
                                return FutureBuilder<List<Agents>>(
                                    future: agents,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                          height: 90,
                                          child: ListView.builder(
                                              itemCount: 7,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return buildContactAvatar(
                                                    'Agent $index', imageUrl);
                                              }),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("Error ${snapshot.error}");
                                      } else {
                                        return SizedBox(
                                          height: 90,
                                          child: ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              var agent = snapshot.data![index];
                                              return Consumer<AgentsNotifier>(
                                                  builder: (context,
                                                      agentsNotifier, child) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    agentsNotifier.agent =
                                                        agent;
                                                    Get.to(() =>
                                                        const AgentDetails());
                                                  },
                                                  child: buildContactAvatar(
                                                      agent.username,
                                                      agent.profile),
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      }
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 180,
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
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _chats,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Image.asset('assets/images/loader.gif'),
                              );
                            }
                            if (snapshot.data?.docs.isEmpty == true) {
                              return const NoSearchResults(
                                text: 'Apply For Jobs To View Chats',
                              );
                            }
                            final chatList = snapshot.data!.docs;
                            return ListView.builder(
                                itemCount: chatList.length,
                                padding: const EdgeInsets.only(left: 25),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final chat = chatList[index].data()
                                      as Map<String, dynamic>;
                                  Timestamp lastChatTime = chat['lastChatTime'];
                                  DateTime lastChatDateTime =
                                      lastChatTime.toDate();
                                  return Consumer<AgentsNotifier>(
                                    builder: (context, agentsNotifier, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (chat['sender'] != userUid) {
                                            _services.updateCount(
                                                chat['chatRoomId']);
                                          } else {}
                                          agentsNotifier.chat = chat;
                                          Get.to(() => const ChatPage());
                                        },
                                        child: buildConversationRow(
                                            name == chat['name']
                                                ? chat['agentName']
                                                : chat['name'],
                                            chat['lastChat'],
                                            chat['profile'],
                                            chat['read'] == false ? 1 : 0,
                                            lastChatDateTime),
                                      );
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 15, left: 25, right: 0),
                        height: 220,
                        decoration: const BoxDecoration(
                            color: Color(0xFF3281E3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Agencies and Companies",
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 90,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  buildContactAvatar('Alla', imageUrl),
                                  buildContactAvatar('July', imageUrl),
                                  buildContactAvatar('Mikle', imageUrl),
                                  buildContactAvatar('Kler', imageUrl),
                                  buildContactAvatar('Moane', imageUrl),
                                  buildContactAvatar('Julie', imageUrl),
                                  buildContactAvatar('Allen', imageUrl),
                                  buildContactAvatar('John', imageUrl),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 180,
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
                          child: ListView(
                            padding: const EdgeInsets.only(left: 25),
                            children: [
                              buildConversationRow(
                                  'Laura',
                                  'Hello, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow('Kalya', 'Will you visit me',
                                  imageUrl, 2, DateTime.now()),
                              buildConversationRow('Mary', 'I ate your ...',
                                  imageUrl, 6, DateTime.now()),
                              buildConversationRow(
                                  'Hellen',
                                  'Are you with Kayla again',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow(
                                  'Louren',
                                  'Barrow money please',
                                  imageUrl,
                                  3,
                                  DateTime.now()),
                              buildConversationRow('Tom', 'Hey, whatsup',
                                  imageUrl, 0, DateTime.now()),
                              buildConversationRow(
                                  'Laura',
                                  'Helle, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow(
                                  'Laura',
                                  'Helle, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                            ],
                          ),
                        ))
                  ],
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 15, left: 25, right: 0),
                        height: 220,
                        decoration: const BoxDecoration(
                            color: Color(0xFF3281E3),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Agencies and Companies",
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 90,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  buildContactAvatar('Alla', imageUrl),
                                  buildContactAvatar('July', imageUrl),
                                  buildContactAvatar('Mikle', imageUrl),
                                  buildContactAvatar('Kler', imageUrl),
                                  buildContactAvatar('Moane', imageUrl),
                                  buildContactAvatar('Julie', imageUrl),
                                  buildContactAvatar('Allen', imageUrl),
                                  buildContactAvatar('John', imageUrl),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 180,
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
                          child: ListView(
                            padding: const EdgeInsets.only(left: 25),
                            children: [
                              buildConversationRow(
                                  'Laura',
                                  'Hello, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow('Kalya', 'Will you visit me',
                                  imageUrl, 2, DateTime.now()),
                              buildConversationRow('Mary', 'I ate your ...',
                                  imageUrl, 6, DateTime.now()),
                              buildConversationRow(
                                  'Hellen',
                                  'Are you with Kayla again',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow(
                                  'Louren',
                                  'Barrow money please',
                                  imageUrl,
                                  3,
                                  DateTime.now()),
                              buildConversationRow('Tom', 'Hey, whatsup',
                                  imageUrl, 0, DateTime.now()),
                              buildConversationRow(
                                  'Laura',
                                  'Helle, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                              buildConversationRow(
                                  'Laura',
                                  'Helle, how are you',
                                  imageUrl,
                                  0,
                                  DateTime.now()),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
    );
  }

  Column buildConversationRow(
      String name, String message, String filename, int msgCount, time) {
    return Column(
      children: [
        FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(filename: filename),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        text: name,
                        style: appStyle(12, Colors.grey, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: width * 0.6,
                        child: ReusableText(
                          text: message,
                          style: appStyle(10, Colors.black, FontWeight.normal),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 5),
                child: Column(
                  children: [
                    ReusableText(
                      text: duTimeLineFormat(time),
                      style: appStyle(10, Colors.black, FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (msgCount > 0)
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: const Color(0xFF3281E3),
                        child: ReusableText(
                          text: msgCount.toString(),
                          style: appStyle(8, Colors.white, FontWeight.normal),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          indent: 70,
          height: 20,
        )
      ],
    );
  }

  Padding buildContactAvatar(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          UserAvatar(
            filename: filename,
          ),
          const SizedBox(
            height: 5,
          ),
          ReusableText(
            text: name,
            style: appStyle(11, Colors.white, FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf-vinci_03.jpeg';
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: CachedNetworkImage(
          errorWidget: (context, url, error) {
            return Image.network(imageUrl);
          },
          imageUrl: filename,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
