import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectivityService {
  static final NetworkConnectivityService _instance =
      NetworkConnectivityService._internal();
  factory NetworkConnectivityService() => _instance;
  NetworkConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.instance;

  StreamController<bool>? _connectionStreamController;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = true;
  bool _isInitialized = false;

  // Get the singleton instance
  static NetworkConnectivityService get instance => _instance;

  // Initialize the network service
  Future<void> initialize() async {
    // Prevent multiple initializations
    if (_isInitialized) return;

    _connectionStreamController = StreamController<bool>.broadcast();

    // Check initial connection
    try {
      _isConnected = await _connectionChecker.hasConnection;
    } catch (_) {
      _isConnected = false;
    }

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
    );

    _isInitialized = true;
  }

  // Handle connectivity changes
  void _onConnectivityChanged(List<ConnectivityResult> results) async {
    try {
      if (results.contains(ConnectivityResult.none)) {
        _updateConnectionStatus(false);
      } else {
        // Double check with internet connection checker
        final hasInternet = await _connectionChecker.hasConnection;
        _updateConnectionStatus(hasInternet);
      }
    } catch (_) {
      _updateConnectionStatus(false);
    }
  }

  /// Update connection status and notify listeners
  void _updateConnectionStatus(bool isConnected) {
    if (_isConnected != isConnected) {
      _isConnected = isConnected;
      _connectionStreamController?.add(_isConnected);
    }
  }

  /// Get current connection status
  bool get isConnected => _isConnected;

  /// Get connection status stream
  Stream<bool>? get connectionStream => _connectionStreamController?.stream;

  /// Check connection status (async)
  Future<bool> checkConnection() async {
    try {
      _isConnected = await _connectionChecker.hasConnection;
      _updateConnectionStatus(_isConnected); // Notify listeners
      return _isConnected;
    } catch (_) {
      _updateConnectionStatus(false);
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _connectionStreamController?.close();
    _connectionStreamController = null;
    _isInitialized = false;
  }
}
