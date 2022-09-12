import 'package:ebiblio/providers/theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => SettingsList(
          sections: [
            SettingsSection(
              title: Text('Section 1'),
              tiles: [
                SettingsTile(
                  title: Text('Language'),
                  trailing: Text('English'),
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Use System Theme'),
                  leading: Icon(Icons.phone_android),
                  onToggle: (value) {
                    setState(() {
                      isSwitched = value;
                      final provider = Provider.of<ThemeProvider>(context, listen: false);
                      provider.toggleTheme(value);
                    });
                  }, initialValue: themeProvider.isDarkMode,
                ),
              ],
            ),
            SettingsSection(
              title: Text('Section 2'),
              tiles: [
                SettingsTile(
                  title: Text('Security'),
                  trailing: Text('Security'),
                  leading: Icon(Icons.lock),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: Text('Use fingerprint'),
                  leading: Icon(Icons.fingerprint),
                  initialValue: true,
                  onToggle: (value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
