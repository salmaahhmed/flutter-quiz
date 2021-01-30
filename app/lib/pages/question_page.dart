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
  List<QuestionEntity> questions = [];
  BehaviorSubject<List<String>> answersController =
      BehaviorSubject<List<String>>();
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (snapshot.data == 9) {
                  Navigator.pop(context);
                } else
                  questionBloc
                      .changeQuestionIndex(questionBloc.currentQuestionVal + 1);
              },
              child: Text('next'),
            ),
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
                    if (state is GetQuestionsSuccess) {
                      return Container(
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
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                      child: Text(answerSnapshot
                                                          .data[index])),
                                                  OutlineButton(
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            );
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
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          );
        });
  }
}
