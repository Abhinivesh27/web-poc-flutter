import 'package:atmega/blocs/post_bloc/post_bloc.dart';
import 'package:atmega/repo/model/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PostBloc _postbloc = PostBloc();
  @override
  void initState() {
    // TODO: implement initState

    _postbloc.add(GetPostsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text("List of Posts in Server"),
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              child: BlocProvider(
                create: (context) => _postbloc,
                child: BlocListener<PostBloc, PostState>(
                  listener: (context, state) {},
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostInitial) {
                        return Text(
                          "Yet to load",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        );
                      } else if (state is PostLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PostLoaded) {
                        return ListofPosts(postModel: state.postModels);
                      } else {
                        return Text(
                          "Error on Loading check internet connection and try again",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListofPosts extends StatelessWidget {
  const ListofPosts({super.key, required this.postModel});
  final List<PostModel> postModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              title: Text(postModel[index].title),
            ));
  }
}
