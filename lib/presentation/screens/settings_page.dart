import 'package:codex/presentation/model_theme.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedTheme = ModelTheme().getTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Theme'),
            subtitle: Text(_selectedTheme),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showThemeDialog();
            },
          ),
        ],
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Light'),
                onTap: () {
                  setState(() {
                    _selectedTheme = 'Light';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Dark'),
                onTap: () {
                  setState(() {
                    _selectedTheme = 'Dark';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('System'),
                onTap: () {
                  setState(() {
                    _selectedTheme = 'System';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
