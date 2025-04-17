import '../../FireBase/account_service.dart';
import 'account_repository_interface.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountService _accountService;

  AccountRepositoryImpl(this._accountService);

  @override
  Future<String?> getUsernameFromAccount(String userId) async {
    return await _accountService.getUsernameFromAccount(userId);
  }

  @override
  Future<void> updateUsername(String userId, String username) async {
    await _accountService.updateUsername(userId, username);
  }

  @override
  Future<String?> getUserAvatarPath(String userId) async {
    return await _accountService.getUserAvatarPath(userId);
  }

  @override
  Future<void> updateUserAvatarPath(String userId, String avatarPath) async {
    await _accountService.updateUserAvatarPath(userId, avatarPath);
  }
}