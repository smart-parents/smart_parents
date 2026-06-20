import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:smart_parents/components/custom_dialog.dart';

class InternetPopup {
  bool _isOnline = false;
  bool _isDialogOn = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  static final InternetPopup _internetPopup = InternetPopup._internal();
  factory InternetPopup() {
    return _internetPopup;
  }
  InternetPopup._internal();
  void initialize({
    required BuildContext context,
    String? customMessage,
    String? customDescription,
    bool? onTapPop = false,
    Function? onChange,
  }) {
    final navigator = Navigator.of(context);
    _checkConnection(
      navigator: navigator,
      context: context,
      customMessage: customMessage,
      customDescription: customDescription,
      onTapPop: onTapPop,
      onChange: onChange,
    );
    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      if (!context.mounted) return;
      await _checkConnection(
        navigator: navigator,
        context: context,
        customMessage: customMessage,
        customDescription: customDescription,
        onTapPop: onTapPop,
        onChange: onChange,
      );
    });
  }

  Future<void> _checkConnection({
    required NavigatorState navigator,
    required BuildContext context,
    String? customMessage,
    String? customDescription,
    bool? onTapPop,
    Function? onChange,
  }) async {
    final results = await _connectivity.checkConnectivity();
    if (!context.mounted) return;
    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet) ||
        results.contains(ConnectivityResult.vpn)) {
      _isOnline = await InternetConnectionChecker.instance.hasConnection;
      if (!context.mounted) return;
    } else {
      _isOnline = false;
    }
    if (_isOnline) {
      if (_isDialogOn) {
        _isDialogOn = false;
        if (navigator.canPop()) {
          navigator.pop();
        }
      }
    } else {
      if (!_isDialogOn) {
        _isDialogOn = true;
        Alerts(context: context).customDialog(
          type: AlertType.warning,
          message: customMessage ?? 'No Internet Connection Found!',
          description: customDescription ?? 'Please enable your internet',
          showButton: onTapPop,
          onTap: () {
            _isDialogOn = false;
            if (navigator.canPop()) {
              navigator.pop();
            }
          },
        );
      }
    }
    if (onChange != null) {
      onChange(_isOnline);
    }
  }

  void initializeCustomWidget({
    required BuildContext context,
    required Widget widget,
  }) {
    final navigator = Navigator.of(context);
    _checkCustomWidget(
      navigator: navigator,
      context: context,
      widget: widget,
    );
    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      if (!context.mounted) return;
      await _checkCustomWidget(
        navigator: navigator,
        context: context,
        widget: widget,
      );
    });
  }

  Future<void> _checkCustomWidget({
    required NavigatorState navigator,
    required BuildContext context,
    required Widget widget,
  }) async {
    final results = await _connectivity.checkConnectivity();
    if (!context.mounted) return;
    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet) ||
        results.contains(ConnectivityResult.vpn)) {
      _isOnline = await InternetConnectionChecker.instance.hasConnection;
      if (!context.mounted) return;
    } else {
      _isOnline = false;
    }
    if (_isOnline) {
      if (_isDialogOn) {
        _isDialogOn = false;
        if (navigator.canPop()) {
          navigator.pop();
        }
      }
    } else {
      if (!_isDialogOn) {
        _isDialogOn = true;
        Alerts(context: context).showModalWithWidget(child: widget);
      }
    }
  }

  Future<bool> checkInternet() async {
    bool isConnected = false;
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet) ||
        results.contains(ConnectivityResult.vpn)) {
      isConnected = await InternetConnectionChecker.instance.hasConnection;
    }
    return isConnected;
  }

  Future<String> getConnectionType() async {
    final results = await _connectivity.checkConnectivity();
    if (results.contains(ConnectivityResult.mobile)) {
      return "mobile";
    } else if (results.contains(ConnectivityResult.wifi)) {
      return "wifi";
    } else {
      return "none";
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
