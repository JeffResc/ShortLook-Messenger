#import "DDNotificationTwitterContactPhotoProvider.h"

@implementation DDNotificationTwitterContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(NSObject<DDNotificationDisplayable> *)notification {
    if (![notification isKindOfClass:NSClassFromString(@"DDUserNotification")]) return nil;
    DDUserNotification *userNotification = (DDUserNotification *)notification;

    // Get profile URL from Twitter
    NSString *profileURLStr = [userNotification.applicationUserInfo valueForKeyPath:@"users.sender.profile_image_url"];
    if (!profileURLStr) return nil;
    profileURLStr = [profileURLStr stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *profileURL = [NSURL URLWithString:profileURLStr];
    if (!profileURL) return nil;

    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:profileURLStr fromURL:profileURL];
}

@end