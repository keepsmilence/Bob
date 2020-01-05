//
//  NSFont+MM.m
//  Bob
//
//  Created by chen on 2020/1/5.
//  Copyright © 2020 ripperhe. All rights reserved.
//

#import "NSFont+MM.h"
#import <AppKit/AppKit.h>
#import "PreferenceManager.h"


@implementation NSFont (MM)

+ (NSFont *)systemAutoFontWithSize:(NSUInteger)size {
    NSInteger font = PreferenceManager.shared.font;
    switch (font) {
        case 0:
            return [NSFont systemFontOfSize:size];
        case 1:
            return [NSFont systemFontOfSize:size + 1];
        case 2:
            return [NSFont systemFontOfSize:size + 2];
            default:
        return [NSFont systemFontOfSize:size];
    }
}

@end
