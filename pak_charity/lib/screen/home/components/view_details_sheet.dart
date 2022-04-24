import 'package:flutter/material.dart';
class ViewDetailSheet extends StatelessWidget {
  const ViewDetailSheet({Key key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            collapsedHeight: MediaQuery.of(context).size.height * 0.2,
            elevation: 0,
            backgroundColor: pageColor,
            automaticallyImplyLeading: false,
            pinned: true,
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: whiteFonts,
                textColor: darkFonts,
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.arrow_back,
                  size: 18,
                ),
                shape: CircleBorder(),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  getFollowersCount();
                  followOrUnFollow();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: isFollowing ? redFonts : whiteFonts,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isFollowing ? 'Unfollow' : 'Follow',
                      style: TextStyle(
                        color: isFollowing ? whiteFonts : darkFonts,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.height, 75),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  dense: true,
                  trailing: Text(
                    '$followersCount Followers',
                    style: TextStyle(
                      color: whiteFonts,
                      fontSize: 14,
                    ),
                  ),
                  isThreeLine: true,
                  title: Text(
                    trainerDetails['Username'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: whiteFonts,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  subtitle: Text(
                    trainerDetails['Email'] +
                        '\n' +
                        trainerDetails['PhoneNumber'],
                    style: TextStyle(
                      color: whiteFonts.withOpacity(0.9),
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: BackgroundFlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(trainerDetails['ProfilePicture']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        appThemeLight.withOpacity(0.25),
                        appThemeDark.withOpacity(0.5),
                        appThemeDark,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Exercises',
                style: TextStyle(
                  color: darkFonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Workout Details')
                .where('TrainerID', isEqualTo: trainerDetails['UserID'])
                .snapshots(),
            builder: (
              context,
              snapshot,
            ) {
              if (!snapshot.hasData)
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              if (snapshot.data.size == 0)
                return SliverToBoxAdapter(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/cerate-workout.png'),
                          size: 75,
                          color: redFonts,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 10,
                          ),
                          child: Text(
                            '${trainerDetails['Username']} Exercises list is currently empty'
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkFonts,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              if (snapshot.hasData)
                return SliverAnimatedList(
                  initialItemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index, Animation) {
                    return WorkoutListCard(
                      title: snapshot.data.docs[index]['Title'],
                      subtitle: snapshot.data.docs[index]['Duration'] +
                          '     ' +
                          snapshot.data.docs[index]['Level'],
                      thumbnail: snapshot.data.docs[index]['Thumbnail'],
                      onPressed: () {
                        push(
                          context,
                          DetailsScreen(
                            workoutDetails: snapshot.data.docs[index],
                          ),
                        );
                      },
                    );
                  },
                );
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: darkFonts.withOpacity(0.75),
                    ),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
              child: Text(
                'Diet Plans',
                style: TextStyle(
                  color: darkFonts,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Diet Plan Details')
                .where('TrainerID', isEqualTo: trainerDetails['UserID'])
                .snapshots(),
            builder: (
              context,
              snapshot,
            ) {
              if (!snapshot.hasData)
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              if (snapshot.data.size == 0)
                return SliverToBoxAdapter(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/cerate-workout.png'),
                          size: 75,
                          color: redFonts,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 10,
                          ),
                          child: Text(
                            '${trainerDetails['Username']} Diet Plan list is currently empty'
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkFonts,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              if (snapshot.hasData)
                return SliverAnimatedList(
                  initialItemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index, Animation) {
                    return DietPlanListCard(
                      title: snapshot.data.docs[index]['Title'],
                      subtitle: 'You can burns ' +
                          snapshot.data.docs[index]['BurnsCalories'] +
                          ' Calories in ' +
                          snapshot.data.docs[index]['Duration'],
                      thumbnail: snapshot.data.docs[index]['Thumbnail'],
                      onPressed: () {
                        push(
                          context,
                          DietPlanDetail(
                            dietPlanDetails: snapshot.data.docs[index],
                          ),
                        );
                      },
                    );
                  },
                );
              return SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: darkFonts.withOpacity(0.75),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}