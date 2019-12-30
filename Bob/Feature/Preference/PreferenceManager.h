//
//  PreferenceManager.h
//  Bob
//
//  Created by chen on 2019/12/28.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"

NS_ASSUME_NONNULL_BEGIN

/// 偏好设置与 userdefault 建立绑定关系
@interface PreferenceManager : NSObject

mm_singleton_h

/// 字号
@property (nonatomic, assign) NSInteger font;
@property (nonatomic, assign) BOOL autoCopyTranslateResult;
@property (nonatomic, assign) BOOL launchAtStartup;
@property (nonatomic, assign) BOOL automaticallyChecksForUpdates;

@property (nonatomic, copy) NSString *translateIdentifier;
@property (nonatomic, assign) Language from;
@property (nonatomic, assign) Language to;
@property (nonatomic, assign) BOOL isPin;
@property (nonatomic, assign) BOOL isFold;

- (void)updateLoginItemWithLaunchAtStartup:(BOOL)launchAtStartup;

@end

NS_ASSUME_NONNULL_END
