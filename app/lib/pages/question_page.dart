import 'dart:async';

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
  List<QuestionEntity> questions = [];
  StreamController<List<String>> answersController =
      StreamController<List<String>>();
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
        stream: questionBloc.currentQuestionIndexStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: BlocListener(
              bloc: questionBloc,
              listener: (ctx, state) {
                if (state is GetQuestionsSuccess) {
                  questions = state.questionLs;
                  answersController.sink.add(
                      questions[snapshot.data].incorrectAnswers
                        ..add(questions[snapshot.data].correctAnswer));
                } else if (state is GetQuestionsFail)
                  Toast.show(state.error, context);
              },
              child: BlocBuilder(
                  bloc: questionBloc,
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        children: [
                          Text(questions[snapshot.data].question),
                          Expanded(
                            child: StreamBuilder(
                                stream: answersController.stream,
                                builder: (context, answerSnapshot) {
                                  return ListView.builder(
                                      itemCount: answerSnapshot.data.length,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                            child: Text(
                                                answerSnapshot.data[index]));
                                      });
                                }),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}
