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
  BehaviorSubject<String> selectedAnswer = BehaviorSubject<String>();

  initbloc() {
    questionBloc ??= Injector.of(context).inject<QuestionBloc>();
    questionBloc.add(GetQuestionEvent(widget.category));
  }

  initNavigationService() {
    service ??= Injector.of(context).inject<NavigationService>();
  }

  @override
  void dispose() {
    selectedAnswer.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initbloc();
    initNavigationService();
    return StreamBuilder(
      stream: questionBloc.currentQuestionIndexStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  if (snapshot.data == 9) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => Container()));
                  } else {
                    questionBloc.changeQuestionIndex(
                        questionBloc.currentQuestionIndexStream.value + 1);
                  }
                },
                label: Text('Next')),
            body: BlocListener(
              bloc: questionBloc,
              listener: (ctx, state) {
                if (state is GetQuestionsSuccess) {
                  questions = state.questionLs;
                } else if (state is GetQuestionsFail)
                  Toast.show(state.error, context);
              },
              child: BlocBuilder(
                bloc: questionBloc,
                builder: (context, state) {
                  if (state is GetQuestionsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 40, right: 40, top: 200, bottom: 20),
                        child: Column(
                          children: [
                            Text(
                                '${snapshot.data == null ? '' : snapshot.data + 1}/10'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(questions[snapshot.data].question),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: (questions[snapshot.data]
                                            .incorrectAnswers +
                                        [
                                          questions[snapshot.data].correctAnswer
                                        ])
                                    .length,
                                itemBuilder: (ctx, index) {
                                  return StreamBuilder<String>(
                                    stream: selectedAnswer,
                                    builder: (context, radioSnapshot) {
                                      return RadioListTile(
                                        title: Text((questions[snapshot.data]
                                                .incorrectAnswers +
                                            [
                                              questions[snapshot.data]
                                                  .correctAnswer
                                            ])[index]),
                                        value: (questions[snapshot.data]
                                                .incorrectAnswers +
                                            [
                                              questions[snapshot.data]
                                                  .correctAnswer
                                            ])[index],
                                        selected: (questions[snapshot.data]
                                                    .incorrectAnswers +
                                                [
                                                  questions[snapshot.data]
                                                      .correctAnswer
                                                ])[index] ==
                                            radioSnapshot.data,
                                        groupValue: radioSnapshot.data,
                                        onChanged: (val) {
                                          selectedAnswer.sink.add(val);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                },
              ),
            ),
          );
      },
    );
  }
}
