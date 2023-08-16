import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PdfEng extends StatefulWidget {
  const PdfEng({super.key});

  @override
  State<PdfEng> createState() => _PdfEngState();
}

class _PdfEngState extends State<PdfEng> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  Future<String> uploadPdf(String fileName, File file) async {
    final refrence = FirebaseStorage.instance.ref().child("pdf/$fileName.pdf");
    final uploadTask = refrence.putFile(file);

    await uploadTask.whenComplete(() {});

    final downloadLink = await refrence.getDownloadURL();

    return downloadLink;
  }

  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;

      File file = File(pickedFile.files[0].path!);

      final downloadLink = await uploadPdf(fileName, file);

      await _firebaseFirestore.collection("english").add({
        "name": fileName,
        "url": downloadLink,
      });
      print("uploaded");
    }
  }

  void getAllPdf() async {
    final results = await _firebaseFirestore.collection("english").get();

    pdfData = results.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("English",style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue[50],
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 1),
            itemCount: pdfData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PdfViewerScreen(
                                  pdfUrl: pdfData[index]['url'],
                                )));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "images/pdf.png",
                            height: 90,
                            width: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              width: 150,
                              height: 50,
                              child: Text(
                                pdfData[index]['name'],
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: Icon(Icons.upload_file),
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  const PdfViewerScreen({super.key, required this.pdfUrl});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PDFDocument? document;

  void initialisePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialisePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: document != null
          ? PDFViewer(document: document!)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
