import 'dart:async';

import 'package:flutter/material.dart';

enum NotifierState { initilializing, loading, ready, error }

class ChangeNotifierCustom extends ChangeNotifier {
  ChangeNotifierCustom();

  NotifierState state = NotifierState.initilializing;

  bool _isLoading = false;
  String _errorMessage = '';

  String get error => _errorMessage;

  void setError(String error) {
    _errorMessage = error;
    updateState();
  }

  void updateState({bool loading = false}) {
    _isLoading = loading;

    if (_isLoading) {
      _errorMessage = '';
      state = NotifierState.loading;
    } else if (_errorMessage.isNotEmpty) {
      state = NotifierState.error;
    } else {
      state = NotifierState.ready;
    }

    notifyListeners();
  }

  /// Waits for the notifier's [state] to become [desiredState].
  ///
  /// If the [state] is already [desiredState], the [Future] completes immediately.
  /// Otherwise, it listens for state changes and completes when the state matches.
  ///
  /// Throws an [Exception] if the notifier is disposed before reaching the desired state.
  Future<void> waitForState(NotifierState desiredState) {
    // If the desired state is already achieved, return immediately.
    if (state == desiredState) {
      return Future.value();
    }

    // Create a Completer to complete when the desired state is reached.
    final completer = Completer<void>();

    // Define a listener that checks for the desired state.
    void listener() {
      if (state == desiredState) {
        completer.complete();
        removeListener(listener);
      }
    }

    // Add the listener to the notifier.
    addListener(listener);

    // Handle the case where the notifier is disposed before reaching the desired state.
    // Completes the future with an error if disposed.
    completer.future.catchError((_) {});
    Future<void>.delayed(Duration.zero).then((_) {
      if (!completer.isCompleted && !hasListeners) {
        completer.completeError(Exception(
            'ChangeNotifierCustom was disposed before reaching the desired state [${desiredState.name}].'));
      }
    });

    return completer.future;
  }
}
