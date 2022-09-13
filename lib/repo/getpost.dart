import 'package:atmega/repo/model/postmodel.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  Future<List<PostModel>> fetchPosts() async {
    String endpoint = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(Uri.parse(endpoint));

    return postModelFromJson(response.body);
  }
}
