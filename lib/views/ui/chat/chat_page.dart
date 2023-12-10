import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:devseeker_app/constants/app_constants.dart';
import 'package:devseeker_app/controllers/agents_provider.dart';
import 'package:devseeker_app/controllers/chat_provider.dart';
import 'package:devseeker_app/controllers/image_provider.dart';
import 'package:devseeker_app/services/firebase_services.dart';
import 'package:devseeker_app/views/common/back_btn.dart';
import 'package:devseeker_app/views/common/app_style.dart';
import 'package:devseeker_app/views/common/reusable_text.dart';
import 'package:devseeker_app/views/ui/auth/profile.dart';
import 'package:devseeker_app/views/ui/chat/widgets/message_list.dart';
import 'package:devseeker_app/views/ui/chat/widgets/textfield.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseServices _services = FirebaseServices();

  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  String imageUrl =
      'https://d326fntlu7tb1e.cloudfront.net/uploads/bdec9d7d-0544-4fc4-823d-3b898f6dbbbf-vinci_03.jpeg';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  sendMessage() {
    var chat = Provider.of<AgentsNotifier>(context, listen: false).chat;

    Map<String, dynamic> message = {
      'message': _messageController.text,
      'messageType': 'text',
      'profile': profile,
      'sender': userUid,
      'time': DateTime.now()
    };

    _services.createChat(chat['chatRoomId'], message);
    _messageController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    var imageNotifier = Provider.of<ImageUpoader>(context);
    var chatNotifier = Provider.of<ChatNotifier>(context);

    String chatRoomId =
        Provider.of<AgentsNotifier>(context, listen: false).chat['chatRoomId'];

    final Stream<QuerySnapshot> typingStatus = FirebaseFirestore.instance
        .collection('typing')
        .doc(chatRoomId)
        .collection('typing')
        .snapshots();

    return Scaffold(
        backgroundColor: Color(kLight.value),
        appBar: AppBar(
          backgroundColor: Color(kLight.value),
          elevation: 0,
          leading: const Padding(
            padding: EdgeInsets.all(12.0),
            child: BackBtn(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: typingStatus,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox.fromSize();
                            }
                            if (snapshot.data?.docs.isEmpty == true) {
                              return SizedBox.fromSize();
                            }
                            // Extract document IDs from the list of documents
                            List<String> documentIds = snapshot.data!.docs
                                .map((doc) => doc.id)
                                .toList();

                            return ReusableText(
                              text: documentIds.isNotEmpty &&
                                      !documentIds.contains(userUid)
                                  ? "typing ..."
                                  : "",
                              style: appStyle(
                                  9, Colors.black54, FontWeight.normal),
                            );
                          }),
                      ReusableText(
                        text: 'online',
                        style: appStyle(
                            9, Colors.green.shade600, FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<AgentsNotifier>(
                    builder: (context, agentNotifier, child) {
                      return Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(imageUrl),
                            radius: 15,
                          ),
                          Positioned(
                            child: CircleAvatar(
                                backgroundColor: Colors.green.shade600,
                                radius: 4),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 5),
                  height: 120,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3281E3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Consumer<AgentsNotifier>(
                        builder: (context, agentsNotifier, child) {
                          var jobDetails = agentsNotifier.chat['job'];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: "Company",
                                          style: appStyle(10, Colors.white54,
                                              FontWeight.w600),
                                        ),
                                        ReusableText(
                                          text: 'Job Title',
                                          style: appStyle(10, Colors.white54,
                                              FontWeight.normal),
                                        ),
                                        ReusableText(
                                          text: 'Salary',
                                          style: appStyle(10, Colors.white54,
                                              FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Container(
                                        height: 60,
                                        width: 1,
                                        color: Colors.amberAccent,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(
                                          text: jobDetails['company'],
                                          style: appStyle(10, Colors.white,
                                              FontWeight.w600),
                                        ),
                                        ReusableText(
                                          text: jobDetails['title'],
                                          style: appStyle(10, Colors.white,
                                              FontWeight.normal),
                                        ),
                                        ReusableText(
                                          text: jobDetails['salary'],
                                          style: appStyle(10, Colors.white,
                                              FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                CircularAvata(
                                    w: 50,
                                    h: 50,
                                    image: jobDetails['image_url']),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 85,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color(0xFFEFFFFC),
                    ),
                    child: Stack(
                      children: [
                        MessageList(chatRoomId: chatRoomId),
                        Positioned(
                          bottom: 0.h,
                          child: MessagingTextController(
                              sendText: () {
                                sendMessage();
                              },
                              sendImages: () {
                                imageNotifier.pickImage();
                              },
                              onTapOutside: (p0) {
                                chatNotifier.isFocused = false;
                                _services.removeTypingStatus(chatRoomId);
                              },
                              onTap: () {},
                              onEditingComplete: () {
                                chatNotifier.isFocused = false;
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (message) => {
                                    if (message.isNotEmpty || message != '')
                                      {
                                        chatNotifier.isFocused = true,
                                        _services.addTypingStatus(chatRoomId)
                                      }
                                  },
                              messageController: _messageController,
                              messageFocusNode: _messageFocusNode),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
