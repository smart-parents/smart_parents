import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/widgest/dropDownWidget.dart';

class DataModel {
  final String name;
  final String mime;
  final int bytes;
  final String url;

  DataModel({
    required this.name,
    required this.mime,
    required this.bytes,
    required this.url,
  });

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)}MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}

class DropAreaPageWeb extends StatefulWidget {
  const DropAreaPageWeb({super.key});

  @override
  State<DropAreaPageWeb> createState() => _DropAreaPageWebState();
}

class _DropAreaPageWebState extends State<DropAreaPageWeb> {
  late DropzoneViewController controller;

  DataModel? dropedfile;
  bool highlight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Result'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                dropdown(
                  DropdownValue: batchyeardropdownValue,
                  sTring: batchList,
                  Hint: "Batch(Starting Year)",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.grey),
                  ),
                  child: TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Enter Description of Results",
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Description of Results';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DottedBorder(
                  color: kPrimaryColor,
                  dashPattern: const [10, 15],
                  strokeWidth: 5,
                  child: Container(
                    height: 250,
                    color: highlight == true
                        ? const Color.fromRGBO(64, 255, 0, 1)
                        : kPrimaryLightColor,
                    child: Stack(
                      children: [
                        DropzoneView(
                          onDrop: uploadedFile,
                          onCreated: (dropcontroller) =>
                              controller = dropcontroller,
                          onHover: () {
                            setState(() {
                              highlight = true;
                            });
                          },
                          onLeave: () {
                            setState(() {
                              highlight = false;
                            });
                          },
                        ),
                        Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.file_upload_outlined,
                                size: 100,
                                color: kPrimaryColor,
                              ),
                              const Text(
                                "Drag and Drop File \n               or",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    final events = await controller.pickFiles();
                                    if (events.isEmpty) return;
                                    uploadedFile(events.first);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 20.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    // primary:
                                    //     Color.fromARGB(255, 176, 39, 39)
                                  ),
                                  label: const Text(
                                    "Browse File",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  icon: const Icon(Icons.search))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                if (dropedfile != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.picture_as_pdf,
                        size: 30,
                      ),
                      Text(dropedfile!.name),

                      // Text('MIME: ${dropedfile!.mime}'),
                      // Image.network(dropedfile!.Url),
                    ],
                  ),
                  Text('Size: ${dropedfile!.size}'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   setState(() {
                      //     subject = subjectController.text;
                      //     notice = noticeController.text;
                      //     addnotice();
                      //     Navigator.pop(context);
                      //   });
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      // primary:
                      //     Color.fromARGB(255, 176, 39, 39)
                    ),
                    child: const Text(
                      "Add Result",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ));
  }

  Future uploadedFile(dynamic events) async {
    final name = events.name;
    final mine = await controller.getFileMIME(events);
    final byteData = await controller.getFileData(events);
    final bytes = byteData.buffer.asUint8List().length;
    final url = await controller.createFileUrl(events);

    print(name);
    print(mine);
    print(bytes);
    print(url);

    setState(() {
      dropedfile = DataModel(name: name, mime: mine, bytes: bytes, url: url);
      highlight = false;
    });
  }
}
