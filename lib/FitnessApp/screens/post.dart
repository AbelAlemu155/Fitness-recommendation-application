import 'package:firsstapp/FitnessApp/bloc/user_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  static const routeName = '/postscreen';
  final Blog post;
  PostScreen({required this.post});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostScreenState();
  }
}

class PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    String uurl = widget.post.author_url.replaceAll('%40', '@');
    BlocProvider.of<UserBloc>(context).add(UserLoadEvent(url: uurl, idx: 1));
    DateTime date = DateTime.parse(widget.post.timestamp);
    String date2 = DateFormat("yy-MM-dd hh:mm:ss aaa").format(date);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            if (widget.post.image_url.isNotEmpty)
              Image(
                height: 400,
                image: NetworkImage(
                    'https://drive.google.com/uc?export=view&id=' +
                        widget.post.image_url),
              ),
            Text(widget.post.title,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            Text(widget.post.body),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                  if (state is UserLoadProgress) {
                    return CircularProgressIndicator();
                  }
                  if (state is UserLoadFail) {
                    return Text(state.message);
                  }
                  if (state is UserLoadSuccess) {
                    return Text('Posted by: ' + state.user.username);
                  }
                  return Container();
                }),
                Text(date2)
              ],
            )
          ],
        ),
      ),
    );
  }
}
