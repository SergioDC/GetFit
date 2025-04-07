// We define a simple Loader class with a flag to control whether data statistics should be printed.
// This flag is useful to toggle verbose logging during development or troubleshooting.
class Loader {
  bool printDataStatistics;

  // The constructor allows configuring the printDataStatistics flag,
  // which helps in controlling the verbosity of debug logs in different environments.
  Loader({this.printDataStatistics = true});
}
