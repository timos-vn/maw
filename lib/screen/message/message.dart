import 'package:flutter/material.dart';

import '../../models/models/chat_message.dart';
import '../../themes/colors.dart';
import '../../utils/const.dart';
import 'component/message_line.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Const.kDefaultPadding),
              child: ListView.builder(
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index) =>
                    Message(message: demoChatMessages[index]),
              ),
            ),
          ),
          chatInputField(context),
        ],
      ),
    );
  }

  Widget chatInputField(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Const.kDefaultPadding,
        vertical: Const.kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: Const.kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Const.kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: Const.kDefaultPadding / 4),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    const SizedBox(width: Const.kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: const SizedBox(
                height:20,
                width: 30,
                child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 20,)),
          ),
          const SizedBox(width: Const.kDefaultPadding * 0.25),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon.png"),
          ),
          const SizedBox(width: Const.kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Admin",
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12,color: Colors.black),
              )
            ],
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.phone,color: mainColor,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.message,color: mainColor,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Icon(Icons.notifications,color: mainColor,),
        ),
        const SizedBox(width: Const.kDefaultPadding * 0.75),
      ],
    );
  }
}