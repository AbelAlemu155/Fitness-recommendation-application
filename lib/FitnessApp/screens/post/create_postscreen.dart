import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_event.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:googleapis/blogger/v3.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/createPostScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreatePostScreenState();
  }
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey4 = GlobalKey<FormBuilderState>();
  FilePickerResult? result;
  File? file2;
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a Post'),
        ),
        /*    floatingActionButton: IconButton(
          iconSize: 50,
          onPressed: () async {
            result = await FilePicker.platform.pickFiles();
            file2 = File(result!.files.single.path as String);
            setState(() {});
          },
          icon: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.cyan,
          ),
        ),*/
        body: Padding(
          padding: EdgeInsets.all(10),
          child: FormBuilder(
            key: _formKey4,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    name: 'title',
                    maxLines: 1,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  FormBuilderTextField(
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: 5,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                    name: 'description',
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (file2 != null) Image.file(file2 as File),
                  SizedBox(height: 40),
                  GestureDetector(
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _tapped ? Colors.grey : Colors.cyan,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create Post',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _tapped = true;
                      });
                      Future.delayed(const Duration(milliseconds: 200), () {
                        setState(() {
                          _tapped = false;
                        });
                      });
                      List<int> imageBytes = [];
                      if (result != null) {
                        if (result!.files.single.path != null) {
                          imageBytes = file2!.readAsBytesSync();
                        }

                        // String  base64Image = base64.encode(imageBytes);
                        //  BlocProvider.of<UploadBloc>(context)
                        //    .add(UploadPostEvent(bstr: imageBytes));
                        //await drive.upload(file);
                      }
                      if (_formKey4.currentState!.validate()) {
                        _formKey4.currentState!.save();
                        String title = _formKey4.currentState!.value['title'];
                        String body =
                            _formKey4.currentState!.value['description'];
                        BlocProvider.of<UploadBloc>(context).add(
                            UploadPostEvent(
                                bstr: imageBytes, body: body, title: title));

                        Future.delayed(Duration(milliseconds: 200), () {
                          BlocProvider.of<BlogBloc>(context).add(BlogEvent());
                          Navigator.pop(context);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
