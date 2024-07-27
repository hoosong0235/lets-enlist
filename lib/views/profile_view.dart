import 'package:flutter/material.dart';
import 'package:lets_enlist/controllers/authentication_controller.dart';
import 'package:lets_enlist/controllers/enlist_controller.dart';
import 'package:lets_enlist/controllers/firestore_database_controller.dart';
import 'package:lets_enlist/utilities/value.dart';
import 'package:lets_enlist/utilities/widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    TextTheme tt = Theme.of(context).textTheme;

    double viewportWidth = MediaQuery.of(context).size.width;
    bool isMobile = viewportWidth <= WIDTHTRHESHOLD;

    Column _buildFavoriteEnlists() {
      return Column(
        children: List.generate(
          FirestoreDatabaseController.favoriteEnlists!.length,
          (int i) => buildEnlist(
            enlistModel: EnlistController
                .rawEnlists[FirestoreDatabaseController.favoriteEnlists![i]],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const buildAppBar(),
      floatingActionButton: const buildFloatingActionButton(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? MOBILEPADDING : DESKTOPPADDING(viewportWidth),
              vertical: 48,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    AuthenticationController.photoURL,
                  ),
                  radius: 60,
                ),
                buildSizedBox(16),
                Text(
                  '${AuthenticationController.displayName}님, 환영합니다',
                  style: (isMobile ? tt.headlineSmall : tt.headlineLarge),
                ),
                buildSizedBox(48),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '⭐',
                          style: (isMobile ? tt.titleSmall : tt.titleLarge)
                              ?.copyWith(
                            color: Colors.yellow,
                          ),
                        ),
                        buildSizedBox(4),
                        Text(
                          '관심 모집병',
                          style: (isMobile ? tt.titleSmall : tt.titleLarge),
                        ),
                      ],
                    ),
                    buildSizedBox(16),
                    _buildFavoriteEnlists(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
