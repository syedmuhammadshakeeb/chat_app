import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  String name;
  String rid;

  ChatView({
    super.key,
    required this.name,
    required this.rid,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController messagecontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? id = randomString(100);
  String? mid = randomNumeric(100);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  sentmessage() async {
    await _firestore.collection('chat').doc(id).collection('msg').doc(mid).set({
      'chatRoomId': id,
      'messages': messagecontroller.text.toString(),
      'senderid': mid,
      'reseverid': widget.rid,
      'Time': Timestamp.now()
    }).then((value) {
      setState(() {});
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            _firestore.collection('chat').doc(id).collection('msg').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.deepPurple],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios_new_outlined,
                                color: Colors.black),
                          ),
                          title: Center(
                            child: Text(
                              widget.name.toString(),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.17,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10),
                            child: Column(children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: snapshot.data!.docs[index]
                                                      ['senderid'] ==
                                                  snapshot.data!.docs[index]
                                                      ['reseverid']
                                              ? EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                )
                                              : EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                ),
                                          decoration: BoxDecoration(
                                              color: snapshot.data!.docs[index]
                                                          ['senderid'] ==
                                                      snapshot.data!.docs[index]
                                                          ['reseverid']
                                                  ? const Color.fromARGB(
                                                      255, 194, 246, 207)
                                                  : const Color.fromARGB(
                                                      255, 200, 220, 237),
                                              borderRadius: snapshot.data!.docs[index]
                                                          ['senderid'] ==
                                                      snapshot.data!.docs[index]
                                                          ['reseverid']
                                                  ? const BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                      bottomRight: Radius.circular(10))
                                                  : const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['messages'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 44, 44, 44)),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                        controller: messagecontroller,
                                        decoration: const InputDecoration(
                                            hintText: 'Message',
                                            border: InputBorder.none),
                                      )),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: const Color.fromARGB(
                                                31, 174, 169, 169)),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              sentmessage();
                                              setState(() {
                                                messagecontroller.clear();
                                              });
                                            },
                                            child: const Icon(
                                              Icons.send,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
