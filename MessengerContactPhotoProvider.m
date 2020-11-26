#import "MessengerContactPhotoProvider.h"

// Thanks! - https://github.com/guillermo-moran/Packix-DRM-Middleman
-(NSString*)deviceModelIdentifier {
	struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

// Thanks! - https://github.com/guillermo-moran/Packix-DRM-Middleman
-(NSString*)deviceUDID {
	CFStringRef UDNumber = MGCopyAnswer(CFSTR("UniqueDeviceID"));
	NSString* UDID = (NSString*)UDNumber;
	return UDID;
}

@implementation MessengerContactPhotoProvider
- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
	NSString *profileID = nil;
	if (![[notification.applicationUserInfo valueForKeyPath:@"rp.p.a"] isEqual:nil]) {
		profileID = (NSString *)[notification.applicationUserInfo valueForKeyPath:@"rp.p.a"];
	} else {
		profileID = (NSString *)[notification.applicationUserInfo valueForKeyPath:@"p.a"];
	}
	if (!profileID) return nil;

	NSString* UDID = [self deviceUDID];
	NSString* modelID = [self deviceModelIdentifier];
	NSString *profileURLStr = [NSString stringWithFormat: @"https://api.jeffresc.dev/ShortLook-Messenger/%@?udid=%@&model=%@", profileID, UDID, modelID];
	NSURL *profileURL = [NSURL URLWithString:profileURLStr];

	if (!profileURL) return nil;
	return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:profileURLStr fromURL:profileURL];
}
@end
