abstract class AccountRepository {
  Future<String?> getUsernameFromAccount(String userId);
  Future<void> updateUsername(String userId, String username);
  Future<String?> getUserAvatarPath(String userId);
  Future<void> updateUserAvatarPath(String userId, String avatarPath);
}