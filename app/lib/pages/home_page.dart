import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/presentation_index.dart';
import 'package:toast/toast.dart';

import '../injector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CategoryBloc categoryBloc;
  List<TriviaCategoryEntity> categories = [];
  StreamController<TriviaCategoryEntity> selectedCategoryStreamController =
      StreamController<TriviaCategoryEntity>();

  initbloc() {
    categoryBloc ??= Injector.of(context).inject<CategoryBloc>();
    categoryBloc.add(GetCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    initbloc();
    return Scaffold(
      backgroundColor: Colors.orange,
      body: BlocListener(
        bloc: categoryBloc,
        listener: (context, state) {
          if (state is GetCategorySuccess) {
            categories = state.categoryLs;
          } else if (state is GetCategoryFail) {
            categories = [];
            Toast.show('${state.error}', context);
          }
        },
        child: BlocBuilder(
            bloc: categoryBloc,
            builder: (context, catState) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepPurple, Colors.orange])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 56.0),
                        child: const Text(
                          'TRIVIA',
                          style: TextStyle(
                            fontSize: 46.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 4.0,
                            shadows: [
                              Shadow(
                                blurRadius: 8.0,
                                color: Colors.deepPurple,
                                offset: Offset(3.0, 4.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Choose a category',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 14.0,
                            color: Colors.deepPurple,
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<TriviaCategoryEntity>(
                        stream: selectedCategoryStreamController.stream,
                        builder: (context, snapshot) {
                          return DropdownButton<TriviaCategoryEntity>(
                            dropdownColor: Colors.white,
                            hint: Text('Select Category'),
                            value: snapshot.data,
                            onChanged: (entity) {
                              selectedCategoryStreamController.sink.add(entity);
                            },
                            items: categories
                                .map((c) => DropdownMenuItem(
                                    value: c,
                                    onTap: () {
                                      selectedCategoryStreamController.sink
                                          .add(c);
                                      print(c.name);
                                    },
                                    child: Text('${c.name}')))
                                .toList(),
                          );
                        }),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.5),
                              ]),
                          child: const Text(
                            'Play trivia',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
