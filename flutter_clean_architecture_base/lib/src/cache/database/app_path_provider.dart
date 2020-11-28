abstract class AppPathProvider {
  final Future<String> _path;

  AppPathProvider(this._path);
  Future<String> get path => _path;
}