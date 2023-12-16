import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive/doc_example/data/person.dart';

import '../../boxes.dart';

class DocumentExample extends StatefulWidget {
  const DocumentExample({super.key});

  @override
  State<DocumentExample> createState() => _DocumentExampleState();
}

class _DocumentExampleState extends State<DocumentExample> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    mybox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        title: const Text(
          "Hive Flutter",
          style: TextStyle(
              fontSize: 26,
              color: Color(0xff3D3D3D),
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  mybox.clear();
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 15, 20),
          child: SizedBox(
            height: h,
            width: w,
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(),
                        child: ColoredBox(color: Color(0xff6BBFED))),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(),
                        child: ColoredBox(color: Color(0xff2A74D7))),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: CircleBorder(),
                        child: ColoredBox(color: Color(0xff9197EF))),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SizedBox(
                  height: h,
                  width: w,
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            const FlutterLogo(
                              size: 50,
                            ),
                            const SizedBox(height: 20),
                            customeTextField(nameController, "Enter Name"),
                            const SizedBox(height: 20),
                            customeTextField(ageController, "Enter Age"),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6BBFED),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (nameController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(
                                            child: Text(
                                          "Kindly Enter the name.",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else if (ageController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Center(
                                            child: Text(
                                          "Kindly Enter the age.",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      mybox
                                          .put(
                                              "key ${nameController.text}",
                                              Person(
                                                  name: nameController.text,
                                                  age: int.parse(
                                                      ageController.text)))
                                          .then((value) {
                                        nameController.clear();
                                        ageController.clear();
                                      });
                                    });
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: mybox.length,
                          itemBuilder: (context, index) {
                            Person person = mybox.getAt(index);

                            return Card(
                              child: ListTile(
                                title: Text(person.name!),
                                subtitle:
                                    Text("age : ${person.age!.toString()}"),
                              ),
                            );
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget customeTextField(TextEditingController controller, String text) {
  return TextField(
    style: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff3D3D3D)),
    scrollPadding: const EdgeInsets.all(10),
    maxLines: 1,
    controller: controller,
    decoration: InputDecoration(
        hintText: text,
        hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))),
  );
}
