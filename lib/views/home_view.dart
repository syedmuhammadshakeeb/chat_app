import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/signin_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore.collection('data').snapshots(),
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
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                          ),
                          child: ListTile(
                            leading: const Text(
                              'Chit Chat',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                auth.signOut().then((value) {
                                  setState(() {});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInView()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('sign out sucessfully')));
                                }).onError((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(error.toString())));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 78, 40, 143),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.logout_outlined,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 1.15,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 10),
                                physics: const BouncingScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10),
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Dismissible(
                                        key: UniqueKey(),
                                        background: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.red[200],
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(Icons.delete),
                                          ),
                                        ),
                                        onDismissed:
                                            (DismissDirection direction) {
                                          setState(() {
                                            firestore
                                                .collection('data')
                                                .doc(snapshot
                                                    .data!.docs[index].id)
                                                .delete();
                                            snapshot.data!.docs.remove(
                                                snapshot.data!.docs[index]);
                                          });
                                        },
                                        child: ListTile(
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Image.network(
                                                snapshot
                                                    .data!.docs[index]['image']
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            snapshot.data!.docs[index]['name'],
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          subtitle: Text(
                                            snapshot.data!.docs[index]
                                                ['username'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45),
                                          ),
                                          trailing: Text(
                                            '${DateTime.now().hour}:${DateTime.now().second} pm',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black45),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatView(
                                                          rid: snapshot.data!
                                                              .docs[index].id,
                                                          name: snapshot.data!
                                                                  .docs[index]
                                                              ['name'],
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }))
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
