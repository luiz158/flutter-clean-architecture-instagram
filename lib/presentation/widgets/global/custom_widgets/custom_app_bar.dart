import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/core/widgets/svg_pictures.dart';
import 'package:instagram/core/resources/assets_manager.dart';
import 'package:instagram/core/resources/strings_manager.dart';
import 'package:instagram/core/resources/styles_manager.dart';
import 'package:instagram/core/utility/injector.dart';
import 'package:instagram/data/models/user_personal_info.dart';
import 'package:instagram/presentation/cubit/firestoreUserInfoCubit/user_info_cubit.dart';
import 'package:instagram/presentation/cubit/firestoreUserInfoCubit/users_info_cubit.dart';
import 'package:instagram/presentation/pages/activity/activity_page.dart';
import 'package:instagram/presentation/pages/messages/messages_page.dart';
import 'package:instagram/presentation/widgets/belong_to/profile_w/custom_gallery/create_new_story.dart';
import 'package:instagram/presentation/widgets/global/custom_widgets/custom_gallery_display.dart';
import 'package:instagram/presentation/widgets/global/custom_widgets/custom_network_image_display.dart';

class CustomAppBar {
  static AppBar basicAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      title: const InstagramLogo(),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 10.0),
          child: PopupMenuButton<int>(
            position: PopupMenuPosition.under,
            elevation: 20,
            offset: const Offset(90, 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SvgPicture.asset(
              IconsAssets.add2Icon,
              color: Theme.of(context).focusColor,
              height: 22.5,
            ),
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsManager.post.tr(),
                        style:
                            getMediumStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    const SizedBox(width: 25),
                    const Icon(Icons.grid_on_sharp),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsManager.story.tr(),
                        style:
                            getMediumStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    SvgPicture.asset(
                      IconsAssets.addInstagramStoryIcon,
                      color: Theme.of(context).focusColor,
                      height: 25,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsManager.reel.tr(),
                        style:
                            getMediumStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    SvgPicture.asset(
                      IconsAssets.videoIcon,
                      color: Theme.of(context).focusColor,
                      height: 25,
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsManager.live.tr(),
                        style:
                            getMediumStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                    SvgPicture.asset(
                      IconsAssets.instagramHighlightStoryIcon,
                      color: Theme.of(context).focusColor,
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(
            IconsAssets.favorite,
            color: Theme.of(context).focusColor,
            height: 30,
          ),
          onPressed: () {
            UserPersonalInfo myPersonalInfo =
                FirestoreUserInfoCubit.getMyPersonalInfo(context);
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) =>
                    ActivityPage(myPersonalInfo: myPersonalInfo),
              ),
            );
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            IconsAssets.messengerIcon,
            color: Theme.of(context).focusColor,
            height: 22.5,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                  builder: (context) => BlocProvider<UsersInfoCubit>(
                        create: (context) => injector<UsersInfoCubit>(),
                        child: const MessagesPage(),
                      ),
                  maintainState: false),
            );
          },
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  static void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        pushToCustomGallery(context);
        break;
      case 1:
        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
            builder: (context) {
              return const CreateNewStory();
            },
            maintainState: false));
        break;
      case 2:
        pushToCustomGallery(context);
        break;
      case 3:
    }
  }

  static Future pushToCustomGallery(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute(
            builder: (context) {
              return const CustomGalleryDisplay();

            },
            maintainState: false),
      );


  static AppBar chattingAppBar(
      UserPersonalInfo userInfo, BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          CircleAvatar(
              child: ClipOval(
                  child: NetworkImageDisplay(
                imageUrl: userInfo.profileImageUrl,
              )),
              radius: 17),
          const SizedBox(width: 15),
          Text(
            userInfo.name,
            style: TextStyle(
                color: Theme.of(context).focusColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
      actions: [
        SvgPicture.asset(
          IconsAssets.phone,
          height: 27,
          color: Theme.of(context).focusColor,
        ),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(
          IconsAssets.videoPoint,
          height: 25,
          color: Theme.of(context).focusColor,
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  static AppBar oneTitleAppBar(BuildContext context, String text,
      {bool logoOfInstagram = false}) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      title: logoOfInstagram
          ? const InstagramLogo()
          : Text(
              text,
              style: getMediumStyle(
                  color: Theme.of(context).focusColor, fontSize: 20),
            ),
    );
  }

  static AppBar menuOfUserAppBar(
      BuildContext context, String text, AsyncCallback bottomSheet) {
    return AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).focusColor),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(text,
            style: getMediumStyle(
                color: Theme.of(context).focusColor, fontSize: 20)),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              IconsAssets.menuHorizontalIcon,
              color: Theme.of(context).focusColor,
              height: 22.5,
            ),
            onPressed: () => bottomSheet,
          ),
          const SizedBox(width: 5)
        ]);
  }
}
