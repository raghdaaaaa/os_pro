# TODO

## Profile / Rewards / Tasks Firebase bug fixes

- [ ] Add `if (userId.isEmpty) return/Stream.empty()` guards before any Firestore call
- [ ] Fix ProfileController so it doesn’t crash when `userId` is empty and doesn’t call Firestore unnecessarily
- [ ] Fix RewardsController/RewardsService so rewards stream always emits (and doesn’t fail before login)
- [ ] Fix Home/TaskService user tasks query so `createdAt` ordering works with required composite index and doesn’t crash when `userId` empty
- [ ] Provide Firestore composite index link for query on (userId, createdAt)
- [x] Update any affected controllers to match guards (only logic)


