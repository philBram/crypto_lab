import 'package:crypto_lab/view/globals.dart';
import 'package:crypto_lab/view/widgets/circular_icon_widget.dart';
import 'package:crypto_lab/view/widgets/custom_snackbar.dart';
import 'package:crypto_lab/view/widgets/popup.dart';
import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:crypto_lab/controller/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenBody();
}

class _SettingsScreenBody extends State<SettingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SettingsGroup(
              title: "Allgemein",
              subtitle: "",
              children: [
                _buildChangePassword(),
                const Divider(),
                _buildDeleteAccount(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteAccount() => SimpleSettingsTile(
        title: "Account löschen",
        subtitle: "",
        leading: const CircularIconWidget(
          icon: Icons.delete,
          color: Colors.redAccent,
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Popup(
                buildContext: context,
                popupType: PopupType.confirmation,
                title: confirmationDeleteAccountTitle,
                content: confirmationDeleteAccountText,
                onConfirmationCallback: (bool confirmed) {
                  setState(() {
                    if (confirmed) {
                      _deleteAccount();
                    }
                  });
                },
              );
            },
          );
        },
      );

  Widget _buildChangePassword() => SimpleSettingsTile(
        title: "Passwort ändern",
        subtitle: "",
        leading: const CircularIconWidget(
          icon: Icons.password,
          color: Colors.lightBlueAccent,
        ),
      );

  Future<void> _deleteAccount() async {
    try {
      await AuthenticationService().deleteUser();
      CustomSnackbar().displayTextWithTitle(
          context: context,
          status: SnackbarStatus.success,
          displayTitle: successTitle,
          displayText: successDeleteAccountText);
    } on Exception catch (e) {
      CustomSnackbar().displayException(context: context, status: SnackbarStatus.failure, exception: e);
      await AuthenticationService().signOut();
    } finally {
      RouteManager().navigateToRoute(context, "/login");
    }
  }
}
