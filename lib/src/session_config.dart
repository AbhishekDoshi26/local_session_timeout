import 'dart:async';

enum SessionTimeoutState { AppFocusTimeout, UserInactivityTimeout }

class SessionConfig {
  /// Immediately invalidates the sesion after [invalidateSessionForUserInactiviity] duration of user inactivity
  ///
  /// If null, never invalidates the session for user inactivity
  final Duration? invalidateSessionForUserInactiviity;

  ///  mmediately invalidates the sesion after [invalidateSessionForAppLostFocus] duration of app losing focus
  ///
  /// If null, never invalidates the session for app losing focus
  final Duration? invalidateSessionForAppLostFocus;

  SessionConfig({
    this.invalidateSessionForUserInactiviity,
    this.invalidateSessionForAppLostFocus,
  });

  final _controller = StreamController<SessionTimeoutState>();

  /// Stream yields Map if session is valid, else null
  Stream<SessionTimeoutState> get stream => _controller.stream;

  /// invalidate session and pass [SessionTimeoutState.AppFocusTimeout] through stream
  void pushAppFocusTimeout() {
    _controller.sink.add(SessionTimeoutState.AppFocusTimeout);
  }

  /// invalidate session and pass [SessionTimeoutState.UserInactivityTimeout] through stream
  void pushUserInactivityTimeout() {
    _controller.sink.add(SessionTimeoutState.UserInactivityTimeout);
  }
}
