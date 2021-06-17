enum AuthenticationStatus { authenticated, unauthenticated }

extension Explanation on AuthenticationStatus {
  bool get isAuthenticated => this == AuthenticationStatus.authenticated;
  bool get isUnauthenticated => this == AuthenticationStatus.unauthenticated;
}
