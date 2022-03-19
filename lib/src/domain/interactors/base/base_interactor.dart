abstract class BaseInteractor<Input, Output> {
  Future<Output> call(Input input);
}

abstract class BaseNoInputInteractor<Output> {
  Future<Output> call();
}
