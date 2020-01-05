//
//  GeneralViewController.m
//  Bob
//
//  Created by ripper on 2019/12/9.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "GeneralViewController.h"
#import "Shortcut.h"
#import "PreferenceManager.h"
#import "NSObject+Debug.h"
#import "PreferenceManager.h"

@interface GeneralViewController ()

@property (weak) IBOutlet MASShortcutView *selectionShortcutView;
@property (weak) IBOutlet MASShortcutView *snipShortcutView;
@property (weak) IBOutlet MASShortcutView *inputShortcutView;
@property (weak) IBOutlet NSButton *autoCopyTranslateResultButton;
@property (weak) IBOutlet NSButton *launchAtStartupButton;
@property (weak) IBOutlet NSButton *autoCheckUpdateButton;
@property (weak) IBOutlet NSSlider *fontSlider;

@end

@implementation GeneralViewController

- (instancetype)init {
//    [self debug_hookAllMehtods];
    return [super initWithNibName:[self className] bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.selectionShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.selectionShortcutView setAssociatedUserDefaultsKey:SelectionShortcutKey];
    
    self.snipShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.snipShortcutView setAssociatedUserDefaultsKey:SnipShortcutKey];
    
    self.inputShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.inputShortcutView setAssociatedUserDefaultsKey:InputShortcutKey];
    
    [self setupFontSlider];
    
    self.autoCopyTranslateResultButton.mm_isOn = PreferenceManager.shared.autoCopyTranslateResult;
    self.launchAtStartupButton.mm_isOn = PreferenceManager.shared.launchAtStartup;
    self.autoCheckUpdateButton.mm_isOn = PreferenceManager.shared.automaticallyChecksForUpdates;
}

- (void)setupFontSlider {
    self.fontSlider.numberOfTickMarks = 3;
    self.fontSlider.maxValue = 2;
    self.fontSlider.minValue = 0;
    self.fontSlider.integerValue = PreferenceManager.shared.font;
}

- (IBAction)fontDidChanged:(NSSlider *)sender {
    PreferenceManager.shared.font = sender.integerValue;
}


#pragma mark - event

- (IBAction)autoCopyTranslateResultButtonClicked:(NSButton *)sender {
    PreferenceManager.shared.autoCopyTranslateResult = sender.mm_isOn;
}

- (IBAction)launchAtStartupButtonClicked:(NSButton *)sender {
    PreferenceManager.shared.launchAtStartup = sender.mm_isOn;
}

- (IBAction)autoCheckUpdateButtonClicked:(NSButton *)sender {
    PreferenceManager.shared.automaticallyChecksForUpdates = sender.mm_isOn;
}

#pragma mark - MASPreferencesViewController

- (NSString *)viewIdentifier {
    return self.className;
}

- (NSString *)toolbarItemLabel {
    return @"通用";
}

- (NSImage *)toolbarItemImage {
    return [NSImage imageNamed:@"toolbar_general"];
}

- (BOOL)hasResizableWidth {
    return NO;
}

- (BOOL)hasResizableHeight {
    return NO;
}

@end
