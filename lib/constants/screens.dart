class ScreenRoutes {
  static final List<String> _screens = [
    "/",
    "/meet",
    "/purchase",
    "/exercise",
  ];

  static Map<int, String> getRouteMap() {
    return _screens.asMap();
  }
}
