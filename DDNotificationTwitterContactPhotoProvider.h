#import "ShortLook-API.h"

@interface DDNotificationTwitterContactPhotoProvider : NSObject <DDNotificationContactPhotoProviding>
- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(NSObject<DDNotificationDisplayable> *)notification;
@end