import 'package:flutter/material.dart';


import 'Students.dart';
import 'form_page.dart';
import 'formpage_two.dart';

class HomehomePage extends StatefulWidget {
  const HomehomePage({Key? key}) : super(key: key);

  @override
  State<HomehomePage> createState() => _HomehomePageState();
}

class _HomehomePageState extends State<HomehomePage> {

  late List<Students> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text("Information"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FormpageTwo()));
          setState(() {
            if (result != ""){
              data.add(result);
            }
          });
        },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            Students information = data[index];
            final remove = data[index];
            return Dismissible(
              background: Container(color: Colors.red,),
              key: Key(remove.toString()),
              onDismissed: (direction) {
                setState(() {
                  data.removeAt(index);
                });
              },
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(25),
                  title: const Center(
                    child: Text("test"),
                  ),
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FormpageTwo()));
                    setState(() {});
                  },
                ),
              ),
            );
          }),
    );
  }
}
