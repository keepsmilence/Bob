//
//  PreferenceManager.m
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "PreferenceManager.h"
#import <ServiceManagement/ServiceManagement.h>
#import <Sparkle/Sparkle.h>

#define PreferenceKey(property) [NSString stringWithFormat:@"Preference_%@", @keypath(self, property)]

#define MMBindUserDefault(keyPath, defaultValue) \
{\
    NSString *key = PreferenceKey(keyPath);\
    if (![[NSUserDefaults standardUserDefaults] objectForKey:key] && defaultValue != nil) {\
        [[NSUserDefaults standardUserDefaults] setObject:defaultValue forKey:key];\
        [[NSUserDefaults standardUserDefaults] synchronize];\
    }\
    RACChannelTo(self, keyPath) = [[NSUserDefaults standardUserDefaults] rac_channelTerminalForKey:key];\
}

@implementation PreferenceManager

mm_singleton_m

- (instancetype)init {
    self = [super init];
    if (self) {
        [self refreshUserDefault];
        [self bindPreference];
    }
    return self;
}

/// v 0.2.0 之前的自定义 key refresh 为新 key
- (void)refreshUserDefault {
#define kAutoCopyTranslateResultKey @"configuration_auto_copy_translate_result"
#define kLaunchAtStartupKey @"configuration_launch_at_startup"

#define kTranslateIdentifierKey @"configuration_translate_identifier"
#define kFromKey @"configuration_from"
#define kToKey @"configuration_to"
#define kPinKey @"configuration_pin"
#define kFoldKey @"configuration_fold"
    [self refreshOldkey:kAutoCopyTranslateResultKey newKey:PreferenceKey(autoCopyTranslateResult)];
    [self refreshOldkey:kLaunchAtStartupKey newKey:PreferenceKey(launchAtStartup)];
    [self refreshOldkey:kTranslateIdentifierKey newKey:PreferenceKey(translateIdentifier)];
    [self refreshOldkey:kFromKey newKey:PreferenceKey(from)];
    [self refreshOldkey:kToKey newKey:PreferenceKey(to)];
    [self refreshOldkey:kPinKey newKey:PreferenceKey(isPin)];
    [self refreshOldkey:kFoldKey newKey:PreferenceKey(isFold)];
}

- (void)refreshOldkey:(NSString *)oldKey newKey:(NSString *)newKey {
    NSObject *value = [[NSUserDefaults standardUserDefaults] objectForKey:oldKey];
    if (value) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:newKey];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:oldKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)bindPreference {
    MMBindUserDefault(font, @(3));
    MMBindUserDefault(autoCopyTranslateResult, @NO);
    MMBindUserDefault(translateIdentifier, nil);
    MMBindUserDefault(from, @(Language_auto));
    MMBindUserDefault(to, @(Language_auto));
    MMBindUserDefault(isPin, @NO);
    MMBindUserDefault(isFold, @NO);
    MMBindUserDefault(launchAtStartup, @NO);
    RACChannelTo(self, automaticallyChecksForUpdates) = RACChannelTo([SUUpdater sharedUpdater], automaticallyChecksForUpdates);
    mm_weakify(self)
    [[RACObserve(self, launchAtStartup) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        mm_strongify(self)
        [self updateLoginItemWithLaunchAtStartup:[x boolValue]];
    }];
    NSLog(@"%@", self.mj_keyValues);
}

#pragma mark -

- (void)updateLoginItemWithLaunchAtStartup:(BOOL)launchAtStartup {
    // 注册启动项
    // https://nyrra33.com/2019/09/03/cocoa-launch-at-startup-best-practice/
#if DEBUG
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper-debug"];
#else
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper"];
#endif
    SMLoginItemSetEnabled((__bridge CFStringRef)helper, launchAtStartup);
}

@end
