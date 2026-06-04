#import "WKDefines.h"
#import "PCKMessageCapturer.h"

NS_ASSUME_NONNULL_BEGIN

@class WKInterfaceController;
@protocol WKExtensionDelegate;

@interface WKExtension : PCKMessageCapturer

+ (WKExtension *)sharedExtension;

- (void)openSystemURL:(NSURL *)url;

@property (nonatomic, weak, nullable) id<WKExtensionDelegate> delegate;
@property (nonatomic, readonly, nullable) WKInterfaceController *rootInterfaceController;

@end

@class UILocalNotification;

@protocol WKExtensionDelegate <NSObject>

@optional

- (void)applicationDidFinishLaunching;
- (void)applicationDidBecomeActive;
- (void)applicationWillResignActive;

- (void)handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification; // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification; // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
#pragma clang diagnostic pop
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification withResponseInfo:(NSDictionary *)responseInfo; // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification withResponseInfo:(NSDictionary *)responseInfo; // when the app is launched from a notification. If launched from app icon in notification UI, identifier will be empty
#pragma clang diagnostic pop
- (void)handleUserActivity:(nullable NSDictionary *)userInfo;

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)didReceiveLocalNotification:(UILocalNotification *)notification;
#pragma clang diagnostic pop

@end

NS_ASSUME_NONNULL_END

