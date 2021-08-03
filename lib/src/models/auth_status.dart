enum AuthenticationStatus { authenticated, unauthenticated, authenticating }

extension Explanation on AuthenticationStatus {
  bool get isAuthenticating => this == AuthenticationStatus.authenticating;
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;
}
