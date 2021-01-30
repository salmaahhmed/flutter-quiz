import 'dart:async';

import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/presentation_index.dart';
import 'package:quiz/services/index.dart';
import 'package:toast/toast.dart';

import '../injector.dart';

class QuestionPage extends StatefulWidget {
  final TriviaCategoryEntity category;
  const QuestionPage({
    Key key,
    this.category,
  }) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuestionBloc questionBloc;
  NavigationService service;
  int score;

  initbloc() {
    questionBloc ??= Injector.of(context).inject<QuestionBloc>();
    questionBloc.add(GetQuestionEvent(widget.category));
  }

  initNavigationService() {
    service ??= Injector.of(context).inject<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    initbloc();
    initNavigationService();
    return StreamBuilder(
      stream: questionBloc.currentScore,
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(questions[snapshot.data].question),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: StreamBuilder(
                        initialData: [],
                        stream: answersController.stream,
                        builder: (context, answerSnapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: answerSnapshot.data.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                    child: Text(answerSnapshot.data[index]));
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 5,
                                crossAxisCount: 2,
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
