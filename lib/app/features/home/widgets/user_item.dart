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
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.location ?? "No location",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.bio ?? "No bio",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(user.followers.toString()),
                      const SizedBox(width: 16),
                      Text(user.publicRepos.toString()),
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
