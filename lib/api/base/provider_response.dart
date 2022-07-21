class ProviderResponse<T> {
  final bool success;
  final T? content;

  const ProviderResponse({
    required this.success,
    this.content,
  });

  ProviderResponse<S> unType<S>() => ProviderResponse(success: success, content: null,);

  ProviderResponse<S> assignContent<S>(S content) {
    return ProviderResponse(
      success: success,
      content: content,
    );
  }

  bool isSuccess() => success;
  bool isFail() => !isSuccess();
}