import 'package:flutter/material.dart';
import 'model.dart';
import 'database_helper.dart';

class FormPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  final Note? note;
  FormPage({
    Key? key,
    this.note
  }) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController bdayController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  List<String> gender = <String>['Male', 'Female', 'Gender', 'Other'];
  String fgender = 'Gender';

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if(note != null){
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text( note == null
            ? 'Save Information'
            : 'EDIT ITEM'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'Put Your Information Here',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "ID Number", labelText: "ID number",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black38,
                      )
                  )
              ),
              validator: (value) {
                return (value == "") ? "Please enter your ID Number" : null;
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: sectionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Year and Section", labelText: "Year and Section",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    )
                ),),
              validator: (value) {
                return (value == "") ? "Please enter your year and section" : null;
              },
            ),
            TextFormField(
              controller: bdayController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                hintText: "Birthday", labelText: "Birthdate",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    )
                ),),
              validator: (value) {
                return (value == "") ? "Please enter your birthdate" : null;
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: courseController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Course", labelText: "Course",
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black38,
                    )
                ),),
              validator: (value) {
                return (value == "") ? "Please enter your course" : null;
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Type here the description',
                  labelText: 'description',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;

                      if (title.isEmpty || description.isEmpty) {
                        return;
                      }

                      final Note model = Note(title: title, description: description, id: note?.id);
                      if(note == null){
                        await DatabaseHelper.addNote(model);
                      }else{
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text( note == null
                        ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}