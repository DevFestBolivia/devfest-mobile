import 'dart:math';

import 'package:devfestbolivia/firebase/profile/profile_firestore.dart';
import 'package:devfestbolivia/firebase/profile/profile_repository_impl.dart';
import 'package:devfestbolivia/models/avatar.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/providers/edit_profile_provider.dart';
import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/dialogs/error_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    required this.profileProvider,
    required this.onEditProfileDone,
    super.key,
  });

  final ProfileProvider profileProvider;
  final VoidCallback onEditProfileDone;

  @override
  Widget build(BuildContext context) {
    final profile = profileProvider.profile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: DevFestColors.textBlack,
          ),
        ),
        title: Text(
          TextStrings.editProfile.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: DevFestColors.textBlack,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingValues.xxl,
          vertical: SpacingValues.xl * 2,
        ),
        child: _EditProfileForm(
          profile: profile,
          onEditProfileDone: onEditProfileDone,
        ),
      ),
    );
  }
}

class _EditProfileForm extends StatefulWidget {
  const _EditProfileForm({
    required this.profile,
    required this.onEditProfileDone,
  });

  final Profile profile;
  final VoidCallback onEditProfileDone;

  @override
  State<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<_EditProfileForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _aboutYouController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final double _imageRadius = 60.0;
  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.profile.fullName;
    _aboutYouController.text = widget.profile.bio;
    _instagramController.text = widget.profile.instagramUrl;
    _facebookController.text = widget.profile.facebookUrl;
    _twitterController.text = widget.profile.twitterUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(
        initialProfile: widget.profile,
        profileRepository: ProfileRepositoryImpl(
          profileFirestore: ProfileFirestore(),
        ),
      ),
      child: Builder(builder: (context) {
        final editProfileProvider =
            Provider.of<EditProfileProvider>(context, listen: false);

        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (editProfileProvider.profile.avatar == 0)
                    Align(
                      // alignment: Alignment.bottomCenter,
                      child: editProfileProvider.profile.imageUrl.isEmpty
                          ? CircleAvatar(
                              radius: _imageRadius,
                              backgroundColor: Colors.primaries[Random()
                                  .nextInt(Colors.primaries.length - 1)],
                              child: Center(
                                child: Text(
                                  editProfileProvider
                                      .profile.fullName.characters.first,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SpacingValues.xxl * 2,
                                  ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: _imageRadius,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                editProfileProvider.profile.imageUrl,
                              ),
                            ),
                    )
                  else
                    Image.asset(
                      Avatar.getAvatart(editProfileProvider.profile.avatar)
                          .path,
                      width: 120,
                    ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        var avatar = await showDialog<Avatar>(
                            context: context,
                            builder: (context) => _GridAvatars(
                                  avatarId: editProfileProvider.profile.avatar,
                                ));
                        // print(avatar);
                        if (avatar != null) {
                          editProfileProvider.setAvatar(avatar.id);
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.emoji_emotions),
                      label: const Text("Cambiar avatar")),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  label: Text(
                    'Nombre Completo',
                  ),
                ),
                onChanged: editProfileProvider.setFullName,
              ),
              VerticalSpacing.xl,
              TextField(
                controller: _aboutYouController,
                decoration: const InputDecoration(
                  label: Text('Acerca de ti'),
                ),
                onChanged: editProfileProvider.setAboutYou,
              ),
              VerticalSpacing.xl,
              TextField(
                controller: _instagramController,
                decoration: const InputDecoration(
                  label: Text('Instagram'),
                ),
                onChanged: editProfileProvider.setInstagram,
              ),
              VerticalSpacing.xl,
              TextField(
                controller: _facebookController,
                decoration: const InputDecoration(
                  label: Text('Facebook'),
                ),
                onChanged: editProfileProvider.setFacebook,
              ),
              VerticalSpacing.xl,
              TextField(
                controller: _twitterController,
                decoration: const InputDecoration(
                  label: Text('Twitter'),
                ),
                onChanged: editProfileProvider.setTwitter,
              ),
              const SizedBox(
                height: SpacingValues.l * 2,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    Dialogs.showLoadingDialog(context);
                    await editProfileProvider.edit();
                    // ignore: use_build_context_synchronously
                    Dialogs.hideLoadingDialog(context);
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text('Perfil editado correctamente'),
                          actions: [
                            TextButton(
                              child: const Text('Aceptar'),
                              onPressed: () {
                                widget.onEditProfileDone();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    ErrorDialog.showErrorDialog(
                      context,
                      'Hubo un problema al editar los datos',
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: SpacingValues.l,
                  ),
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      'LISTO',
                      style: TextStyle(
                        color: DevFestColors.primaryLight,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _GridAvatars extends StatefulWidget {
  final int avatarId;
  const _GridAvatars({Key? key, required this.avatarId}) : super(key: key);

  @override
  State<_GridAvatars> createState() => __GridAvatarsState();
}

class __GridAvatarsState extends State<_GridAvatars> {
  late Avatar avatar;
  @override
  void initState() {
    avatar = Avatar.getAvatart(widget.avatarId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: Avatar.listAvatart.length,
              itemBuilder: (BuildContext context, int index) {
                return ClipOval(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        avatar = Avatar.listAvatart[index];
                      });
                    },
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: [
                        Image.asset(
                          Avatar.listAvatart[index].path,
                          width: 120,
                        ),
                        if (Avatar.listAvatart[index].id == avatar.id)
                          ClipOval(
                            child: Container(
                              height: 120,
                              width: 120,
                              color: Colors.blue.withOpacity(0.5),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(avatar);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: SpacingValues.l,
                ),
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'GUARDAR',
                    style: TextStyle(
                      color: DevFestColors.primaryLight,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
