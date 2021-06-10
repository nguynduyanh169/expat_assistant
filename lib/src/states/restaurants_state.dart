abstract class RestaurantsState {
  const RestaurantsState();
}

class Init extends RestaurantsState{
  const Init();
}

class LoadingScreen extends RestaurantsState{
  const LoadingScreen();
}

class LoadScreenSuccess extends RestaurantsState{
  final String currentAddress;
  const LoadScreenSuccess(this.currentAddress);
}

class LoadScreenError extends RestaurantsState{
  final String errorMessage;
  const LoadScreenError(this.errorMessage);
}

class FindCurrentAddressSuccess extends RestaurantsState{
  final String currentAddress;
  const FindCurrentAddressSuccess(this.currentAddress);
}

class FindingCurrentAddress extends RestaurantsState{
  const FindingCurrentAddress();
}
