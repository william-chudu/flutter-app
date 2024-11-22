part of '../index.dart';

final class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
    required this.label,
  });

  final AuthenticatedUser user;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              children: [
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label.account,
                      style: context.text.labelMedium,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.memShipAccountProfile.fullName,
                          style: context.text.titleMedium,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user.accountUser,
                          style: context.text.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ItemUserInfo(
                      isStart: true,
                      title: label.accountType,
                      content: label.jsonAccountType[user.accountBusinessType] ?? '',
                    ),
                    ItemUserInfo(
                      title: label.point,
                      content: Utils.money.currency(user.totalPoint),
                    ),
                    ItemUserInfo(
                      title: label.level,
                      content: user.levelName,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ItemNavigation(title: label.accountInfo),
                ItemNavigation(
                  title: label.services,
                  onTap: () {
                    Navigator.of(context).pushNamed(Journey.routeName);
                  },
                ),
                ItemNavigation(
                  title: label.point,
                  onTap: () {
                    Navigator.of(context).pushNamed(ListPoint.routeName);
                  },
                ),
                ItemNavigation(title: label.myReviews),
                ItemNavigation(
                  title: label.promotions,
                  onTap: () {
                    Navigator.of(context).pushNamed(Notifications.routeName);
                  },
                ),
                ItemNavigation(
                  title: label.favoriteHotels,
                  onTap: () {
                    Navigator.of(context).pushNamed(FavouriteHotel.routeName);
                  },
                ),
                ItemNavigation(
                  title: label.memberPolicy,
                  onTap: () {
                    MemberPolicy.showModal(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
            child: ButtonFilledWidget(
              onTap: () {
                context.read<AuthenticationBloc>().add(const SignOutEvent());
              },
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  label.signOut,
                  style: context.text.titleLarge?.copyWith(
                    color: context.color.surfaceTint,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
