import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef PreferenceWidgetBuilder<T> = Widget Function(
    BuildContext context, T? value);

class PreferenceBuilder<T> extends StatelessWidget {
  final String prefKey;
  final PreferenceWidgetBuilder<T> builder;
  final T defaultValue;

  const PreferenceBuilder({
    Key? key,
    required this.prefKey,
    required this.builder,
    required this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final T? pref = Preferences._get(context, prefKey) ?? defaultValue;
    return builder(context, pref);
  }
}

class Preferences extends StatefulWidget {
  final Widget? child;
  final WidgetBuilder? builder;
  final SharedPreferences sharedPreferences;

  const Preferences({
    Key? key,
    this.child,
    this.builder,
    required this.sharedPreferences,
  })  : assert(child != null || builder != null),
        super(key: key);

  @override
  State<Preferences> createState() => _PreferencesState();

  static void setInt(BuildContext context, String key, int value) {
    final _PreferencesModel? model = _getModel(context);
    model!.state.setInt(key, value);
  }

  static void setBool(BuildContext context, String key, bool value) {
    final _PreferencesModel? model = _getModel(context);
    model!.state.setBool(key, value);
  }

  static void setDouble(BuildContext context, String key, double value) {
    final _PreferencesModel? model = _getModel(context);
    model!.state.setDouble(key, value);
  }

  static void setString(BuildContext context, String key, String value) {
    final _PreferencesModel? model = _getModel(context);
    model!.state.setString(key, value);
  }

  static void setStringList(
      BuildContext context, String key, List<String> value) {
    final _PreferencesModel? model = _getModel(context);
    model!.state.setStringList(key, value);
  }

  static int getInt(BuildContext context, String key, int defaultValue) {
    final _PreferencesModel? model = _getModelWithKey(context, key);
    return model!.state.getInt(key, defaultValue);
  }

  static dynamic _get(BuildContext context, String key) {
    final _PreferencesModel? model = _getModelWithKey(context, key);
    return model!.state._maybeValue(key);
  }

  static _PreferencesModel? _getModel(BuildContext context) => context
      .getElementForInheritedWidgetOfExactType<_PreferencesModel>()
      ?.widget as _PreferencesModel;

  static _PreferencesModel? _getModelWithKey(
          BuildContext context, String key) =>
      InheritedModel.inheritFrom<_PreferencesModel>(context, aspect: key);
}

class _PreferencesState extends State<Preferences> {
  static const String _prefix = 'prefs.';
  Map<String, dynamic> prefs = {};

  @override
  void initState() {
    super.initState();

    prefs = Map.of(prefs);
    for (final key in widget.sharedPreferences.getKeys()) {
      if (!key.startsWith(_prefix)) continue;
      prefs[key.substring(_prefix.length)] = widget.sharedPreferences.get(key);
    }
  }

  void setInt(String key, int value) =>
      _setValue(key, value, widget.sharedPreferences.setInt);

  void setBool(String key, bool value) =>
      _setValue(key, value, widget.sharedPreferences.setBool);

  void setDouble(String key, double value) =>
      _setValue(key, value, widget.sharedPreferences.setDouble);

  void setString(String key, String value) =>
      _setValue(key, value, widget.sharedPreferences.setString);

  void setStringList(String key, List<String> value) =>
      _setValue(key, value, widget.sharedPreferences.setStringList);

  int getInt(String key, int defaultValue) => _getValue(key, defaultValue);

  bool getBool(String key, bool defaultValue) => _getValue(key, defaultValue);

  double getDouble(String key, double defaultValue) =>
      _getValue(key, defaultValue);

  String getString(String key, String defaultValue) =>
      _getValue(key, defaultValue);

  List<String> getStringList(String key, List<String> defaultValue) =>
      _getValue(key, defaultValue);

  int? maybeInt(String key) => _maybeValue(key);

  bool? maybeBool(String key) => _maybeValue(key);

  double? maybeDouble(String key) => _maybeValue(key);

  String? maybeString(String key) => _maybeValue(key);

  List<String>? maybeStringList(String key) => _maybeValue(key);

  void _setValue<T>(String key, T value, _ValueSetter<T> setter) {
    if (prefs[key] != value) {
      setter('$_prefix$key', value).then((success) {
        if (success) {
          setState(() {
            prefs = Map.of(prefs);
            prefs[key] = value;
          });
        }
      });
    }
  }

  T _getValue<T>(String key, T defaultValue) => prefs[key] ?? defaultValue;

  T? _maybeValue<T>(String key) => prefs[key];

  @override
  Widget build(BuildContext context) {
    return _PreferencesModel(
      child: widget.child != null
          ? widget.child!
          : Builder(builder: widget.builder!),
      state: this,
    );
  }
}

// We need it, because shared preferences doesn't have abstract `set` method
// (well, it does, but it's private)
typedef _ValueSetter<T> = Future<bool> Function(String key, T value);

class _PreferencesModel extends InheritedModel<String> {
  final _PreferencesState state;
  final Map<String, dynamic> prefs;

  _PreferencesModel({
    Key? key,
    required Widget child,
    required this.state,
  })  : prefs = state.prefs,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_PreferencesModel oldWidget) =>
      prefs != oldWidget.prefs;

  @override
  bool updateShouldNotifyDependent(
    _PreferencesModel oldWidget,
    Set<String> keys,
  ) {
    for (final key in keys) {
      if (prefs[key] != oldWidget.prefs[key]) {
        return true;
      }
    }

    return false;
  }
}
