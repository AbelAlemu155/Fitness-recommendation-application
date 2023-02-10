import 'package:firsstapp/FitnessApp/bloc/blog_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_event.dart';
import 'package:firsstapp/FitnessApp/bloc/blog_state.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_event.dart';
import 'package:firsstapp/FitnessApp/bloc/upload/upload_state.dart';
import 'package:firsstapp/FitnessApp/bloc/user_bloc.dart';
import 'package:firsstapp/FitnessApp/bloc/user_event.dart';
import 'package:firsstapp/FitnessApp/bloc/user_state.dart';
import 'package:firsstapp/FitnessApp/models/Trainer.dart';
import 'package:firsstapp/FitnessApp/screens/trainer/trainer_plans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/notebooks/v1.dart';

class TrainerScreen extends StatefulWidget {
  static const routeName = '/TrainerScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TrainerScreenState();
  }
}

class TrainerScreenState extends State<TrainerScreen> {
  List aps = [];
  List<Trainer> trainers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<UserBloc>(context).add(TrainerLoadEvent());
    BlocProvider.of<BlogBloc>(context).add(RequestInit());
    // BlocProvider.of<UploadBloc>(context).add(getApprovalEvent(trainer_id: trainer_id));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Trainers'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          BlocListener<UploadBloc, UploadState>(
              child: Container(),
              listener: (_, state) {
                if (state is ApprovalCompleted) {
                  aps.add(GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, TrainerPlanScreen.routeName,
                          arguments: state.trid);
                    },
                    child: Row(
                      children: [
                        Text('Approved'),
                        Container(
                          width: 5,
                        ),
                        Icon(
                          Icons.navigate_next,
                          color: Colors.cyan,
                        )
                      ],
                    ),
                  ));
                  setState(() {});
                }
                if (state is ApprovalNotRequested) {
                  int ind = aps.length;
                  aps.add(GestureDetector(
                    onTap: () {
                      BlocProvider.of<BlogBloc>(context).add(
                          RequestEvent(index: ind, trid: trainers[ind].id));
                    },
                    child: Row(
                      children: [
                        Text('Request Trainer'),
                        Container(
                          width: 5,
                        ),
                        Icon(
                          Icons.add_task,
                          color: Colors.cyan,
                        )
                      ],
                    ),
                  ));
                  setState(() {});
                }
                if (state is ApprovalPending) {
                  aps.add(Text('Pending Request...'));
                }
                if (state is ApprovalFail) {
                  aps.add(Text('getting data failed'));
                }
                setState(() {});
              }),
          BlocListener<BlogBloc, PostState>(
            child: Container(),
            listener: (_, state) {
              if (state is RequestLoad) {
                setState(() {
                  aps[state.index] = CircularProgressIndicator();
                });
              }
              if (state is RequestFail) {
                setState(() {
                  aps[state.index] = Text(state.message);
                });
              }
              if (state is RequestSuccess) {
                setState(() {
                  aps[state.index] = Text('Pending Request...');
                });
              }
            },
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (_, state) {
              if (state is TrainerLoadProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TrainerLoadFail) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is TrainerLoadSuccess) {
                final trs = state.trainers;
                if (trainers.isEmpty) {
                  trainers.addAll(trs);
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      int idx2 = index + 1;
                      BlocProvider.of<UploadBloc>(context)
                          .add(getApprovalEvent(trainer_id: trs[index].id));

                      Widget w = Container();
                      if (index < aps.length) {
                        w = aps[index];
                      }

                      return ListTile(
                        leading: Text(idx2.toString()),
                        title: Text(trs[index].username),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                                'Experience   ${trs[index].yearOfExperience} years'),
                            SizedBox(
                              height: 4,
                            ),
                            Text('Gender   ${trs[index].gender} '),
                            SizedBox(
                              height: 4,
                            ),
                            Text('Cost perHour   ${trs[index].costPerHour}'),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                        trailing: Container(
                          width: 160,
                          child: Column(
                            children: [
                              Expanded(
                                child: w,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.cyan,
                        thickness: 1,
                      );
                    },
                    itemCount: trs.length);
              }
              return Container();
            },
          ),
        ],
      )),
    );
  }
}
