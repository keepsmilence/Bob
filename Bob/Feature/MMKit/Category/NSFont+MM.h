//
//  NSFont+MM.h
//  Bob
//
//  Created by chen on 2020/1/5.
//  Copyright © 2020 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFont (MM)

+ (NSFont *)systemAutoFontWithSize:(NSUInteger)size;

@end

NS_ASSUME_NONNULL_END
