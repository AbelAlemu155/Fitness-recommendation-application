import 'package:firsstapp/FitnessApp/bloc/blog_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_event.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_state.dart';
import 'package:firsstapp/FitnessApp/bloc/user_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';
import 'package:firsstapp/FitnessApp/screens/post.dart';
import 'package:firsstapp/FitnessApp/screens/post/create_postscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String usernameLogin = LoginScreen.box.read('username');

  final Map<String, dynamic> _postData = {};

  final _formKey = GlobalKey<FormState>();
  List<Blog> postList = [];

  List<Map<bool, String>> images = [];
  List<String> roles = [];
  List<String> postcounts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BlogBloc>(context).add(BlogEvent());
  }

  @override
  Widget build(BuildContext context) {
    String _baseUrl = '/api/v1/user/$usernameLogin';
    final url = _baseUrl.replaceAll('@', '%40');
    // BlocProvider.of<BlogBloc>(context).add(BlogEvent());

    return Scaffold(
      floatingActionButton: IconButton(
          iconSize: 35,
          color: Colors.cyan,
          onPressed: () {
            Navigator.pushNamed(context, CreatePostScreen.routeName);
          },
          icon: Icon(Icons.create)),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 35,
          ),
          BlocListener<BlogBloc, PostState>(
              child: Container(),
              listener: (_, state) {
                if (state is LoadBlog) {
                  postList = state.posts;
                }
                for (int i = 0; i < postList.length; i++) {
                  print(i);
                  String url = postList[i].author_url.replaceAll('%40', '@');
                  print(url);
                  BlocProvider.of<UserBloc>(context)
                      .add(UserLoadEvent(url: url, idx: i));
                }
              }),
          BlocListener<UserBloc, UserState>(
              child: Container(),
              listener: (_, state) {
                print(state.runtimeType);
                if (state is UserLoadSuccess) {
                  Map<bool, String> imagemap = {true: state.user.image_url};
                  if (images.length < postList.length) {
                    images.add(imagemap);
                    roles.add(state.user.role);
                    postcounts.add(state.user.post_count.toString());
                  }
                  if (state.ind == postList.length - 1 &&
                      postList.length != 0) {
                    setState(() {});
                  }
                }
                if (state is UserLoadFail) {
                  Map<bool, String> imagemap = {false: state.message};
                  if (images.length < postList.length) {
                    images.add(imagemap);
                    postcounts.add(state.message);
                    roles.add(state.message);
                  }
                  if (state.ind == postList.length && postList.length != 0) {
                    setState(() {});
                  }
                }
              }),
          BlocBuilder<BlogBloc, PostState>(
            builder: (_, state) {
              print(postList);
              print(roles);
              if (state is DeleteFailure) {
                BlocProvider.of<BlogBloc>(context)
                    .add(BlogEvent('Unable to delete message'));
              }
              if (state is DeleteSuccess) {
                final snackBar =
                    SnackBar(content: Text('Delete was succesful'));

                BlocProvider.of<BlogBloc>(context).add(BlogEvent());

                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
              if (state is BlogFailure) {
                print(state.message);
                return Text(state.message);
              }
              if (state is CreationSuccess) {
                // BlocProvider.of<BlogBloc>(context).add(BlogEvent());
              }
              if (state is CreationFailure) {
                return Text(state.message);
              }
              if (state is LoadBlog) {
                return Container();
              }
              return CircularProgressIndicator();
            },
          ),
          if (postList.length != 0 &&
              roles.length != 0 &&
              postList.length == roles.length)
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < postList.length; i++)
                  InkWell(
                    onTap: () {
                      Future.delayed(Duration(milliseconds: 200), () {
                        Navigator.pushNamed(context, PostScreen.routeName,
                            arguments: postList[i]);
                      });
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (images[i].containsKey(true))
                                CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        images[i][true] as String)),
                              Column(
                                children: [
                                  Text(
                                    postList[i].title,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Mon"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  if (postList[i].body.length <= 15)
                                    Text(postList[i].body,
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon")),
                                  if (postList[i].body.length > 15)
                                    Text(
                                        postList[i].body.substring(0, 14) +
                                            '....',
                                        style: TextStyle(
                                            fontSize: 15, fontFamily: "Mon")),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      'User is ' +
                                          roles[i] +
                                          ' [' +
                                          postcounts[i] +
                                          'posts]',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: "Mon")),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        ]),
      ),
    );
  }
}
