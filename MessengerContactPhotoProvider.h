#import "ShortLook-API.h"

@interface MessengerContactPhotoProvider : NSObject <DDNotificationContactPhotoProviding>
- (NSString*)deviceModelIdentifier;
- (NSString*)deviceUDID;
- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification;
@end