import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference typing = FirebaseFirestore.instance.collection('typing');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference status = FirebaseFirestore.instance.collection('status');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  createStatus() {
    Map<String, dynamic> data = {};
    status.doc(userUid).set(data);
    debugPrint('$userUid is online ');
  }

  offlineStatus() {
    status.doc(userUid).delete();
    debugPrint('Completed creating the chat');
  }

  createChatRoom({chatData}) {
    chats.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
      debugPrint(e.toString());
    });
    debugPrint('Completed creating the chat');
  }

  void addTypingStatus(String chatRoomId) {
    typing.doc(chatRoomId).collection('typing').doc(userUid).set({});
  }

  void removeTypingStatus(String chatRoomId) {
    typing.doc(chatRoomId).collection('typing').doc(userUid).delete();
  }

  createChat(String chatRoomId, message) {
    chats.doc(chatRoomId).collection('messages').add(message).catchError((e) {
      debugPrint(e.toString());
      throw e;
    });
    removeTypingStatus(chatRoomId);
    chats.doc(chatRoomId).update({
      'messageType': message['messageType'],
      'sender': message['sender'],
      'profile': message['profile'],
      'timestamp': Timestamp.now(),
      'lastChat': message['message'],
      'lastChatTime': message['time'],
      'read': false
    });
    debugPrint('Completed sending  message');
  }

  updateCount(String chatRoomId) {
    chats.doc(chatRoomId).update({'read': true});
  }

  getChat(chatRoomId) async {
    return chats
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  deleteChat(chatRoomId) async {
    return chats.doc(chatRoomId).delete();
  }

  Future<bool> chatRoomExists(chatRoomId) async {
    // Reference to the chat room document
    DocumentReference chatRoomRef = chats.doc(chatRoomId);

    // Check if the chat room document exists
    DocumentSnapshot chatRoomSnapshot = await chatRoomRef.get();

    return chatRoomSnapshot.exists;
  }

  Future<Stream<QuerySnapshot>> getChatRooms(String userUid) async {
    return FirebaseFirestore.instance
        .collection("chats")
        // .orderBy("time", descending: true)
        .where("users", arrayContains: userUid)
        .snapshots();
  }
}
