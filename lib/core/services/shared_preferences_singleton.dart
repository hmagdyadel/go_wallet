import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePrefs {
  static late FlutterSecureStorage _instance;

  /// Initialize before using
  static Future<void> init() async {
    _instance = const FlutterSecureStorage();
  }

  /// Set String
  static Future<void> setString(String key, String value) async {
    try {
      await _instance.write(key: key, value: value);
    } catch (e) {
      debugPrint('Error setting string: $e');
    }
  }

  /// Get String
  static Future<String?> getString(String key) async {
    try {
      return await _instance.read(key: key);
    } catch (e) {
      debugPrint('Error getting string: $e');
      return null;
    }
  }

  /// Set Bool
  static Future<void> setBool(String key, bool value) async {
    try {
      await _instance.write(key: key, value: value.toString());
    } catch (e) {
      debugPrint('Error setting bool: $e');
    }
  }

  /// Get Bool
  static Future<bool> getBool(String key) async {
    try {
      final value = await _instance.read(key: key);
      return value?.toLowerCase() == 'true';
    } catch (e) {
      debugPrint('Error getting bool: $e');
      return false;
    }
  }

  /// Remove key
  static Future<void> remove(String key) async {
    try {
      await _instance.delete(key: key);
    } catch (e) {
      debugPrint('Error removing key: $e');
    }
  }

  /// Clear all
  static Future<void> clear() async {
    try {
      await _instance.deleteAll();
    } catch (e) {
      debugPrint('Error clearing storage: $e');
    }
  }
}
