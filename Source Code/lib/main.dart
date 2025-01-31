import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appName',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChatScreen(),
    );
  }
}

class Users {
  final String name;
  final bool isFraud;
  final String imagePath;
  final String message;
  Users(this.name, this.isFraud, this.imagePath, this.message);
}

List<Users> usersList = [
  Users('Levi', false, 'assets/levi.jpg','Hi Eren\nClean your room'),
  Users('Zeke', true, 'assets/zeke.jpg','Hi Eren\nI lost my mobile, can you send me  5000 to this Gpay number: +91 123456789'),
  Users('Mikasa♥️', false, 'assets/mikasa.jpg','Hi Ereh\nIm your family'),
  Users('Bertolt Hoover', true, 'assets/bertolt.jpg','Hi Eren\nI lost my mobile, can you send me  5000 to this Gpay number: +91 123456789'),
  Users('Armin', false, 'assets/armin.jpg','Hi Eren\nWe see the sea bro'),
];

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eren Yeager'),
      ),
      body: ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ChatDetailsScreen(
                              index: index,
                            ))));
              },
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(usersList[index].imagePath),
                ),
                title: Text(usersList[index].name),
                trailing: Icon(Icons.camera_alt),
              ),
            ),
          );
        },
      ),
    );
  }
}



class ChatDetailsScreen extends StatefulWidget {
  const ChatDetailsScreen({super.key, required this.index});

  final int index;

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: ListTile(
          title: Text('Message'),
          trailing: Icon(Icons.send),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(usersList[widget.index].isFraud ?kBottomNavigationBarHeight * 3: kToolbarHeight),
        child: Column(
          children: [
            AppBar(
              title: Text(usersList[widget.index].name),
            ),
            if (usersList[widget.index].isFraud)
              ListTile(
                tileColor: Colors.redAccent,
                leading: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.yellowAccent,
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirmation Required'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Is this really your friend??'),
                                  // Text('Would you like to approve of this message?'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.close)),
                title: Text(
                    'Might Be a Fraud, don\'t send money without confirming with your friend'),
              )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(usersList[widget.index].message),
        );
      },),
    );
  }
}
// 'I lost my mobile, can you send me  5000 to this Gpay number: +91 123456789'