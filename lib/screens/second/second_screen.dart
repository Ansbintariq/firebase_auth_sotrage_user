import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {

    super.initState();
  }
  String? token;
  List subscribed = [];
  List topics = [
    'Samsung',
    'Apple',
    'Huawei',
    'Nokia',
    'Sony',
    'HTC',
    'Lenovo'
  ];
  final image =
      "https://img.freepik.com/free-photo/medium-shot-boy-holding-book_23-2148892765.jpg?t=st=1683877144~exp=1683877744~hmac=dbecbeff64ec9bbf189f66ad0b97a1211f404dfd6ea8349c723c433d09251cdd";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("second"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        color:
                            Color.fromRGBO(255, 255, 255, 0.9019607843137255)),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(image))),
                          )),
                      title:  Text(
                        topics[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Row(
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "1 section",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          )
                        ],
                      ),
                      trailing:

                      subscribed.contains(topics[index])
                          ? ElevatedButton(
                        onPressed: () async {
                          await FirebaseMessaging.instance
                              .unsubscribeFromTopic(topics[index]);
                          await FirebaseFirestore.instance
                              .collection('topics')
                              .doc(topics[index])
                              .update({topics[index]: FieldValue.delete()});
                          setState(() {
                            subscribed.remove(topics[index]);
                          });
                        },
                        child: Text('unsubscribe'),
                      )
                          : ElevatedButton(
                          onPressed: () async {
                            getToken();
                            await FirebaseMessaging.instance
                                .subscribeToTopic(topics[index]);

                            await FirebaseFirestore.instance
                                .collection('topics')
                                .doc(topics[index])
                                .set({topics[index]: '$token'},
                                );
                            setState(() {
                              subscribed.add(topics[index]);
                            });
                          },
                          child: Text('subscribe')),
                    ),

                    ),

                );
              },
            )
          ],
        ),
      ),
    );
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print(token);
  }

  getTopics() async {
    await FirebaseFirestore.instance
        .collection('topics')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (token == element.id) {
                subscribed = element.data().keys.toList();
              }
            }));

    setState(() {
      subscribed = subscribed;
    });
  }

}
