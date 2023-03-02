
import '../utils/ui/ui_util.dart';
import '../utils/utils.dart';

class ApiCallException implements Exception {
  final int statusCode;
  final String? message;
  final String? api;

  const ApiCallException(this.statusCode, {this.message, this.api});

  @override
  String toString() {
    String s = "ApiCallException|status code:$statusCode";
    if (message?.isNotEmpty ?? false) s = s + "|message:$message";
    if (api?.isNotEmpty ?? false) s = s + "|api:$api";
    return s;
  }

  static List<ApiCallException> get customApiErrors => [
        const BadRequestError(),
        const UnauthorizedError(),
        const ForbiddenError(),
        const NotFoundError(),
        const NotImplemented(),
        const InternalServerError(),
        const BadGateway(),
        const ServiceUnavailable(),
        const HTTPVersionNotSupported(),
        const GatewayTimeout(),
        const InsufficientStorage(),
        const VariantAlsoNegotiates(),
        const LoopDetected(),
        const NotExtended(),
        const NetworkAuthenticationRequired(),
      ];

  get reaction=>null;
}

class BadRequestError extends ApiCallException {
  const BadRequestError() : super(400);
  @override
  get reaction => AppSnackBar.snackBarE4xx("(400) User error!",
      "he server cannot or will not process the request due"
          " to something that is perceived to be a client error");
}

class UnauthorizedError extends ApiCallException {
  const UnauthorizedError() : super(401);
  // get reaction => UiUtil.snackBar("title", "401");
}

class ForbiddenError extends ApiCallException {
  const ForbiddenError() : super(403);
  @override
  get reaction => AppSnackBar.snackBarE4xx("forbidden!(403)",
      "The server understands the request but refuses to allow it");
}

class NotFoundError extends ApiCallException {
  const NotFoundError() : super(404);
}

class InternalServerError extends ApiCallException {
  const InternalServerError() : super(500);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(500) Server problem!",
      "A generic error message is given when an unexpected "
          "condition is encountered and a specific message is not appropriate.");
}

class NotImplemented extends ApiCallException {
  const NotImplemented() : super(501);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(501) Server problem!",
      "The server either does not know the request method or is"
          " not able to fulfill the request."
          " Usually this means future availability "
          "(eg, a new feature of a web service API).");
}

class BadGateway extends ApiCallException {
  const BadGateway() : super(502);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(502) Server problem!",
      "The server was acting as a gateway or proxy and received "
          "an invalid response from the upstream server");
}

class ServiceUnavailable extends ApiCallException {
  const ServiceUnavailable() : super(503);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(503) Server problem!",
      "The server cannot handle the request (because it is overloaded or down for"
          " maintenance). Generally, this is a temporary state");
}

class HTTPVersionNotSupported extends ApiCallException {
  const HTTPVersionNotSupported() : super(505);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(505) Server problem!",
      "The server does not support the HTTP protocol version used in the request");
}

class GatewayTimeout extends ApiCallException {
  const GatewayTimeout() : super(504);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(504) Server problem!",
      "The server does not support the HTTP protocol version used in the request");
}

class VariantAlsoNegotiates extends ApiCallException {
  const VariantAlsoNegotiates() : super(506);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(506) Server problem!",
      "Clear content negotiation for the request leads to a circular reference.");
}

class InsufficientStorage extends ApiCallException {
  const InsufficientStorage() : super(507);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(507) Server problem!",
      "The server is unable to store the view required to complete the request");
}

class LoopDetected extends ApiCallException {
  const LoopDetected() : super(508);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(508) Server problem!",
      "The server detected an infinite loop while processing requests");
}

class NotExtended extends ApiCallException {
  const NotExtended() : super(510);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(510) Server problem!",
      "More extensions are required for the request so that the server can fulfill it");
}

class NetworkAuthenticationRequired extends ApiCallException {
  const NetworkAuthenticationRequired() : super(511);
  @override
  get reaction => AppSnackBar.snackBarE5xx("(511) Server problem!",
      "The client needs authentication to access the network");
}

class InvalidAccessTokenError extends ApiCallException {
  const InvalidAccessTokenError() : super(401);
}
