import 'package:app478/report.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'addnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Student report",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 11, 133),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var lis;
  var liss;
  var url;
  @override
  void initState() {
    lis = FirebaseStorage.instance.ref("images").listAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addnote()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title: Text('Students'),
      ),
      body: FutureBuilder<ListResult>(
        future: lis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            liss = snapshot.data!.items;
          }
          return ListView.builder(
            itemCount: liss.length,
            itemBuilder: (context, index) {
              var image = liss[index];
              return GestureDetector(
                onTap: () {
                  // print(image.url.toString());
                  // print(image.toString());
                  downl(image);
                },
                child: ListTile(
                  title: Text(image.name),
                ),
              );
            },
          );
        },
      ),
    );
  }

  downl(Reference ref) async {
    // var sav = await getApplicationDocumentsDirectory();
    // var file = File('$')

    url = await ref.getDownloadURL().whenComplete(() {
      setState(() {
        url;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ss(
                    url: url,
                  )));
    });
    print("//////////////////////////////////////");
    print(url.toString());
    print("//////////////////////////////////////");
  }
}
