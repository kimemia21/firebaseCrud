import 'package:app/create_button.dart';
import 'package:app/firebase_options.dart';
import 'package:app/updateBottom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'RealTime  Database CRUD'),
    );
  }
}

final DatabaseReference databaseReferance = FirebaseDatabase.instance.ref();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
                    query: databaseReferance,
                    itemBuilder: (context, snapshot, index, animation) {
                      return ListTile(
                        title: Text(snapshot.child("name").value.toString()),
                        subtitle:
                            Text(snapshot.child("address").value.toString()),
                        leading: Text(snapshot.child("sn").value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                    return updateBottomSheet(
                                        context,
                                        snapshot.child("name").value.toString(),
                                        snapshot.child("sn").value.toString(),
                                        snapshot
                                            .child("address")
                                            .value
                                            .toString(),
                                        snapshot.child("id").value.toString());
                                  },
                                  value: index,
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text("Edit"),
                                  )),
                              PopupMenuItem(
                                  value: index,
                                  onTap: () {
                                    databaseReferance
                                        .child(snapshot.child("id").value.toString())
                                        .remove();
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text("Delete"),
                                  ))
                            ];
                          },
                        ),
                      );
                    }))
          ],

          //
        ));
  }
}
