class RoutingData {
  final String route;
  final Map<String, dynamic> _queryParameters;

  RoutingData({
    this.route,
    Map<String, dynamic> queryParameters,
  }) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}
