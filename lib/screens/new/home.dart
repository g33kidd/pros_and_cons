import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/post.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final posts = Post.all().snapshots();
    final snapshot = useStream(posts);

    if (snapshot.hasData) {
      return PageScaffold(
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) =>
                    PostCard(snapshot.data.docs[index]),
                // itemBuilder: (context, index) {
                //   var widget = Center(
                //     child: CircularProgressIndicator(),
                //   );
                //   Post.fromSnapshot(snapshot.data.docs[index]).then((val) {
                //     widget = PostCard(val);
                //   });
                // },
                // itemBuilder: (context, index) => PostCard(
                //   Post.fromSnapshot(snapshot.data.docs[index]),
                // ),
                separatorBuilder: (context, index) {
                  if (index % 5 == 0) {
                    return DeveloperSupport();
                  }
                  // TODO this is where the ads will be...
                  // if (index % 3 == 0) {
                  //   return NativeAdmob(
                  //     adUnitID: "ca-app-pub-3940256099942544/2247696110",
                  //     loading: Center(child: CircularProgressIndicator()),
                  //     error: Text("Failed to load the ad"),
                  //     type: NativeAdmobType.full,
                  //   );
                  // }
                  return SizedBox(height: 12);
                },
              ),
            )
          ],
        ),
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class PostCard extends HookWidget {
  final QueryDocumentSnapshot snapshot;

  PostCard(this.snapshot);

  @override
  Widget build(BuildContext context) {
    final postFuture = useFuture(Post.fromSnapshot(snapshot));

    final Post post = postFuture.data;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFFF8F8F8),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User",
                style: TextStyle(
                  color: purple,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                timeago.format(post.created.toDate()),
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            post.text,
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class DeveloperSupport extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Box(
      color: darkPurple,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            "Help support development!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: pink,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
