import 'package:crypto_lab/view/globals.dart';
import 'package:crypto_lab/view/widgets/custom_circular_icon_widget.dart';
import 'package:crypto_lab/view/widgets/custom_snackbar.dart';
import 'package:crypto_lab/view/widgets/custom_popup.dart';
import 'package:crypto_lab/controller/authentication_service.dart';
import 'package:crypto_lab/controller/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_colors.dart';

class SettingsScreenBody extends StatefulWidget {
  const SettingsScreenBody({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsScreenBody();
}

class _SettingsScreenBody extends State<SettingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildEditProfile(),
            const SizedBox(height: 10.0),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  _buildChangePassword(),
                  _buildDividingContainer(),
                  _buildDeleteAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividingContainer() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        width: double.infinity,
        height: 1.0,
        color: Colors.grey.shade400,
      );

  Widget _buildEditProfile() {
    final User? user = FirebaseAuth.instance.currentUser;
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
      color: CustomColors.cryptoLabButton,
      child: ListTile(
        onTap: () {
          // TODO implement
        },
        title: Text(
          user == null || user.isAnonymous ? ("Gast") : (user.email!),
          style: const TextStyle(color: CustomColors.cryptoLabLightFont),
        ),
        leading: CircleAvatar(
          child: ClipOval(
            child: Image.network(
              'https://media.istockphoto.com/photos/young-handsome-man-with-beard-wearing-casual-sweater-standing-over-picture-id1212702108?k=20&m=1212702108&s=612x612&w=0&h=ZI4gKJi2d1dfi74yTljf4YhulA1nfhD3dcUFGH-NUkY=',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDeleteAccount() => ListTile(
        title: const Text("Account löschen"),
        leading: const CustomCircularIconWidget(
          icon: Icons.delete,
          color: Colors.redAccent,
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopup(
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

  Widget _buildChangePassword() => ListTile(
        title: const Text("Passwort ändern"),
        leading: const CustomCircularIconWidget(
          icon: Icons.lock_outlined,
          color: Colors.lightBlueAccent,
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomPopup(
                buildContext: context,
                popupType: PopupType.changePassword,
                title: changePasswordTitle,
                content: changePasswordText,
                onConfirmationCallback: (bool confirmed) {
                  setState(() {
                    if (confirmed) {
                      // TODO:
                    }
                  });
                },
                onConfirmationTextFieldValues: (List<String> values) {
                  setState(() {
                    // TODO:
                  });
                }
              );
            }
          );
        },
      );

  Future<void> _deleteAccount() async {
    try {
      await AuthenticationService().deleteUser();
      CustomSnackbar().displayTextWithTitle(
        context: context,
        status: SnackbarStatus.success,
        displayTitle: successTitle,
        displayText: successDeleteAccountText,
      );
    } on Exception catch (e) {
      CustomSnackbar().displayException(context: context, status: SnackbarStatus.failure, exception: e);
      await AuthenticationService().signOut();
    } finally {
      RouteManager().navigateToRoute(context, "/login");
    }
  }
}
