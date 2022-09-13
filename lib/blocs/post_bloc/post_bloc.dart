import 'package:atmega/repo/getpost.dart';
import 'package:atmega/repo/model/postmodel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    final PostRepo _postRepo = PostRepo();
    on<GetPostsEvent>((event, emit) async {
      emit(PostLoading());
      var posts = await _postRepo.fetchPosts();
      emit(PostLoaded(posts));
    });
  }
}
