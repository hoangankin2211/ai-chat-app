import 'package:chat_app/core/domain/usecase/use_case.dart';
import 'package:chat_app/domain/entity/post/post_list.dart';
import 'package:chat_app/domain/repository/post/post_repository.dart';

class GetPostUseCase extends UseCase<PostList, void> {
  final PostRepository _postRepository;

  GetPostUseCase(this._postRepository);

  @override
  Future<PostList> call({required params}) {
    return _postRepository.getPosts();
  }
}
