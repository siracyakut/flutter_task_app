// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:nanoid/nanoid.dart';
import 'package:path_provider/path_provider.dart';

import '../core/data.dart';
import '../core/localizations.dart';
import '../core/storage.dart';
import '../utils/dialogs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  List<String> countries = [];
  String? country;
  File? currentAvatar;
  bool loaded = false;

  loadCountryNames() async {
    List<String> names = await CacheManager().getCountryData();
    setState(() {
      countries = names;
    });
  }

  selectPhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final String imageFormat = image.name.split('.').last.toLowerCase();
      final img.Image? imageBytes;
      switch (imageFormat) {
        case ("jpg"):
          imageBytes = img.decodeJpg(File(image.path).readAsBytesSync());
        case ("jpeg"):
          imageBytes = img.decodeJpg(File(image.path).readAsBytesSync());
        case ("png"):
          imageBytes = img.decodePng(File(image.path).readAsBytesSync());
        case ("bmp"):
          imageBytes = img.decodeBmp(File(image.path).readAsBytesSync());
        case ("gif"):
          imageBytes = img.decodeGif(File(image.path).readAsBytesSync());
        case ("tiff"):
          imageBytes = img.decodeTiff(File(image.path).readAsBytesSync());
        default:
          Dialogs().errorDialog(
            context: context,
            text:
                AppLocalizations.of(context).getTranslate("file-not-supported"),
          );
          return;
      }

      if (imageBytes == null) {
        Dialogs().errorDialog(
          context: context,
          text: AppLocalizations.of(context).getTranslate("file-deprecated"),
        );
        return;
      }

      if (imageBytes.width <= 400 || imageBytes.height <= 400) {
        Dialogs().errorDialog(
          context: context,
          text: AppLocalizations.of(context).getTranslate("file-min-400px"),
        );
        return;
      }

      final img.Image resizedImage;

      if (imageBytes.width > imageBytes.height) {
        resizedImage = img.copyResize(imageBytes, height: 400);
      } else {
        resizedImage = img.copyResize(imageBytes, width: 400);
      }

      List<int> resizedBytes = img.encodeJpg(
        resizedImage,
        quality: 85,
      );

      final Directory appTempDir = await getApplicationCacheDirectory();

      if (appTempDir.existsSync()) {
        appTempDir.listSync().forEach((fileEntity) {
          if (fileEntity is File) {
            if (fileEntity.path.contains("avt")) {
              fileEntity.deleteSync();
            }
          }
        });
      }

      File finalFinal = File("${appTempDir.path}/avt_${nanoid()}.jpg");
      await finalFinal.writeAsBytes(resizedBytes);
      await Storage().saveProfileInfo(null, null, finalFinal.path, null);

      setState(() {
        currentAvatar = finalFinal;
      });
    } on Exception {
      Dialogs().errorDialog(
        context: context,
        text: AppLocalizations.of(context).getTranslate("file-min-400px"),
      );
    }
  }

  loadInfo() async {
    final data = await Storage().getProfileInfo();

    if (data["avatarPath"] != null) {
      setState(() {
        currentAvatar = File(data["avatarPath"]);
      });
    }

    if (data["country"] != null) {
      setState(() {
        country = data["country"];
      });
    }

    if (data["name"] != null) {
      setState(() {
        nameController.text = data["name"];
      });
    }

    if (data["surname"] != null) {
      setState(() {
        surnameController.text = data["surname"];
      });
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        loaded = true;
      });
    });
  }

  saveInfo() async {
    await Storage().saveProfileInfo(
      nameController.text,
      surnameController.text,
      null,
      null,
    );
    Dialogs().infoDialog(context: context, text: "", navigate: false);
  }

  @override
  void initState() {
    super.initState();
    loadCountryNames();
    loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return !loaded
        ? const SizedBox.expand(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context).getTranslate("profile"),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Gap(30),
                GestureDetector(
                  onTap: selectPhoto,
                  child: Stack(
                    children: [
                      if (currentAvatar != null)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onBackground,
                              width: 4,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: FileImage(currentAvatar!),
                            radius: 64,
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onBackground,
                              width: 4,
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/4874/4874944.png",
                            ),
                            radius: 64,
                          ),
                        ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Icon(
                          Icons.photo,
                          size: 40,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(25),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).getTranslate(
                            "name",
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Flexible(
                      child: TextField(
                        controller: surnameController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).getTranslate(
                            "surname",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(25),
                DropdownButton<String>(
                  isExpanded: true,
                  items: countries
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  value: country,
                  onChanged: (String? value) {
                    setState(() {
                      country = value!;
                    });
                    Storage().saveProfileInfo(null, null, null, value);
                  },
                ),
                const Gap(25),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: saveInfo,
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
