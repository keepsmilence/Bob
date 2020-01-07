//
//  AppDelegate.m
//  Bob
//
//  Created by ripper on 2019/11/20.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItem.h"
#import "Shortcut.h"
#import "MMCrash.h"
#import <ApplicationServices/ApplicationServices.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    MMLogInfo(@"程序启动");
    [MMCrash registerHandler];
    [StatusItem.shared setup];
    [Shortcut setup];
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self xxx1];
        [self xxx];
        
    }];
}

- (void)xxx1 {
    AXUIElementRef systemWideElement = AXUIElementCreateSystemWide();
    AXUIElementRef focussedElement = NULL;
    AXError error = AXUIElementCopyAttributeValue(systemWideElement, kAXFocusedUIElementAttribute, (CFTypeRef *)&focussedElement);
    if (error != kAXErrorSuccess) {
        NSLog(@"Error while retrieving focused element");
        return;
    } else {
        NSLog(@"%@", (__bridge id)focussedElement);
    }
    
    AXValueRef selectedText = NULL;
    AXError selectedTextError = AXUIElementCopyAttributeValue(focussedElement, kAXSelectedTextAttribute, (CFTypeRef *)&selectedText);          //Copy selected text attribute from focussedElement to selectedText
    if (selectedTextError == kAXErrorSuccess)
    {
        NSString* selectedTextString = (__bridge NSString *)(selectedText);
        NSLog(@"%@", selectedTextString);            // Selected text value retrieved
    }
    else
    {
        NSLog(@"Error while retrieving selected text");
    }
}

- (void)xxx {
    AXUIElementRef systemWideElement = AXUIElementCreateSystemWide();
    AXUIElementRef focussedElement = NULL;
    AXError error = AXUIElementCopyAttributeValue(systemWideElement,
                                                  kAXFocusedUIElementAttribute, (CFTypeRef*)&focussedElement);
    NSLog(@"%@", (__bridge id)focussedElement);
    if (error != kAXErrorSuccess) {
        NSLog(@"Could not get focussed element");
    }
    else {
        AXValueRef selectedRangeValue = NULL;
        AXError getSelectedRangeError =
        AXUIElementCopyAttributeValue(focussedElement,
                                      kAXSelectedTextRangeAttribute, (CFTypeRef*)&selectedRangeValue);
        if (getSelectedRangeError == kAXErrorSuccess) {
            CFRange selectedRange;
            AXValueGetValue(selectedRangeValue, kAXValueCFRangeType,
                            &selectedRange);
            AXValueRef attributedString = NULL;
            AXError getAttrStrError =
            AXUIElementCopyParameterizedAttributeValue(focussedElement,
                                                       kAXAttributedStringForRangeParameterizedAttribute, selectedRangeValue,
                                                       (CFTypeRef*)&attributedString);
            NSLog(@"%@", (__bridge id)selectedRangeValue);
            CFRelease(selectedRangeValue);
            if (getAttrStrError == kAXErrorSuccess)
            {
//                CFAttributedStringRef attrStr = (CFAttributedStringRef)attributedString;
//                CFTypeRef value = CFAttributedStringGetAttribute(attrStr, 0, kAXFontTextAttribute, NULL);
//                NSLog(@"%@", (__bridge id)value);
//                printf("CFTypeRef type is: %s\n",CFStringGetCStringPtr(CFCopyTypeIDDescription(CFGetTypeID(value)),kCFStringEncodingUTF8));
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"xxxx" object:[NSString stringWithFormat:@"%s", CFStringGetCStringPtr(CFCopyTypeIDDescription(CFGetTypeID(value)),kCFStringEncodingUTF8)]];
//                //                printf("value: %X", value); // value is not NULL, but I can't obtain font name from it.
//                CFRelease(attributedString);
            }
            else
            {
                NSLog(@"Could not get attributed string for selected range");
            }
        }
        else {
            NSLog(@"Could not get selected range");
        }
    }
    if (focussedElement != NULL)
        CFRelease(focussedElement);
    CFRelease(systemWideElement);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [StatusItem.shared remove];
}

@end
