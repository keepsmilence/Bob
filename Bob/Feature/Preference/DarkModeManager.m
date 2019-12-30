//
//  DarkModeManager.m
//  Bob
//
//  Created by chen on 2019/12/24.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "DarkModeManager.h"
#import "PreferenceManager.h"

@interface DarkModeManager()

@property (nonatomic, assign) BOOL systemDarkMode;

@end

@implementation DarkModeManager

mm_singleton_m

+ (instancetype)manager {
    return [self shared];
}

- (instancetype)init {
    if (self = [super init]) {
        [self fetch];
        [self monitor];
        [self test];
    }
    return self;
}

- (void)test {
}

- (void)fetch {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    self.systemDarkMode = ( style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"] );
}

- (void)monitor {
    NSString * const darkModeNotificationName = @"AppleInterfaceThemeChangedNotification";
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDarkMode) name:darkModeNotificationName object:nil];
}

- (void)updateDarkMode {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:NSGlobalDomain];
    id style = [dict objectForKey:@"AppleInterfaceStyle"];
    BOOL isDarkMode = ( style && [style isKindOfClass:[NSString class]] && NSOrderedSame == [style caseInsensitiveCompare:@"dark"] );
    if (isDarkMode) {
        NSLog(@"黑夜模式");
    } else {
        NSLog(@"正常模式");
    }
    self.systemDarkMode = isDarkMode;
}

@end

