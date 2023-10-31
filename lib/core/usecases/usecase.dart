abstract class UseCase<T, P> {
  Future<T> execute({required P params});
}
