#import "MessengerContactPhotoProvider.h"

@implementation MessengerContactPhotoProvider

- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
	NSString *profileID = [notification.applicationUserInfo valueForKeyPath:@"p.a"];
    if (!profileID) return nil;
    NSString *profileURLStr = [NSString stringWithFormat: @"https://graph.facebook.com/%@/picture?type=large", profileID];
    NSURL *profileURL = [NSURL URLWithString:profileURLStr];
    if (!profileURL) return nil;
    return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:profileURLStr fromURL:profileURL];
}

@end