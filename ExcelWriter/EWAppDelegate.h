//
//  EWAppDelegate.h
//  ExcelWriter
//
//  Created by Tom Grill on 27.09.12.
//  Copyright (c) 2012 Tom Grill. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EWAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSTableView *tableView;
@property (assign) IBOutlet NSTextField *txtInputCSV;

@property (assign) IBOutlet NSWindow *window;

@property (retain) IBOutlet NSMutableArray *content;

@property (assign) BOOL hasTitleRow;

- (IBAction)btnOpenPressed:(id)sender;
-(void) initData;
- (IBAction)btnLoadXLSX:(id)sender;
- (IBAction)btnWriteXLSX:(id)sender;

@end
