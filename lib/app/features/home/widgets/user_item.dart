import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:git_app/app/models/user_model.dart';

class UserItem extends StatelessWidget {
  final UserModel user;

  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64),
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    user.login,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                       const Icon(
                        Icons.pin_drop_rounded,
                        size: 18,
                        color: Colors.blueAccent//Color(0xFFAEAEAE),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          user.location ?? "No location",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAEAEAE),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.message,
                        size: 18,
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          user.bio ?? "No bio",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFAEAEAE),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.people,
                            size: 18,
                            color: Color(0xFFAEAEAE),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.followers.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          const Icon(
                            Icons.book,
                            size: 18,
                            color: Color(0xFFAEAEAE),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.publicRepos.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
