class BaseResponse<T> {
  const BaseResponse(this.data, this.errorResult);

  factory BaseResponse.success(T data) => BaseResponse(data, null);

  factory BaseResponse.failure(String error) => BaseResponse(null, error);

  final T? data;
  final String? errorResult;
}
