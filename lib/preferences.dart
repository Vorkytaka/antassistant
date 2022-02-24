import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    // final _SharedAppModel? model = context.getElementForInheritedWidgetOfExactType<_SharedAppModel>()?.widget as _SharedAppModel?;
    // assert(_debugHasSharedAppData(model, context, 'setValue'));
    // model!.sharedAppDataState.setValue<K, V>(key, value);

    final _PreferencesModel? model = context
        .getElementForInheritedWidgetOfExactType<_PreferencesModel>()
        ?.widget as _PreferencesModel;
    model!.state.setInt(context, key, value);
  }

  static int? getInt(BuildContext context, String key) {
    // final _SharedAppModel? model = InheritedModel.inheritFrom<_SharedAppModel>(context, aspect: key);
    // assert(_debugHasSharedAppData(model, context, 'getValue'));
    // return model!.sharedAppDataState.getValue<K, V>(key, init);

    final _PreferencesModel? model =
        InheritedModel.inheritFrom<_PreferencesModel>(context, aspect: key);
    return model!.state.getInt(context, key);
  }
}

class _PreferencesState extends State<Preferences> {
  static const String _prefix = 'prefs.';
  Map<String, dynamic> prefs = {};

  @override
  void initState() {
    super.initState();

    final keys = widget.sharedPreferences
        .getKeys()
        .where((key) => key.startsWith(_prefix));
    setState(() {
      prefs = Map.of(prefs);
      for (final key in keys) {
        prefs[key.substring(_prefix.length)] =
            widget.sharedPreferences.get(key);
      }
    });
  }

  void setInt(BuildContext context, String key, int value) {
    if (prefs[key] != value) {
      widget.sharedPreferences.setInt('$_prefix$key', value).then((success) {
        if (success) {
          setState(() {
            prefs = Map.of(prefs);
            prefs[key] = value;
          });
        }
      });
    }
  }

  int? getInt(BuildContext context, String key) {
    return prefs[key];
  }

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
