//
//  EWAppDelegate.m
//  ExcelWriter
//
//  Created by Tom Grill on 27.09.12.
//  Copyright (c) 2012 Tom Grill. All rights reserved.
//
/*
Copyright (c) 2012 Thomas Grill
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "EWAppDelegate.h"
#import "SpreadsheetWriter.h"

@implementation EWAppDelegate
@synthesize txtInputCSV;
@synthesize tableView;
@synthesize content;
@synthesize hasTitleRow;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [self initData];
}

-(void) initData{
    
    
    
    NSMutableArray * data = [[NSMutableArray alloc] initWithCapacity: 5];
    
    [data insertObject:[NSMutableArray arrayWithObjects:@"Col1",@"Col2",@"Col3",nil] atIndex:0];
    [data insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:1];
    [data insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:2];
    [data insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:3];
    [data insertObject:[NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil] atIndex:4];

    for (NSTableColumn *tc in [tableView tableColumns]) [tableView removeTableColumn:tc];
    
    for (int i = 0; i< [[data objectAtIndex:0] count];i++){
        NSTableColumn * tc = [[NSTableColumn alloc] initWithIdentifier:@"Col"];
        //NSString * title =[[data objectAtIndex:0] objectAtIndex:i];
        //[tc setName:title];
        [[self tableView] addTableColumn:tc];
    }
    
    [self setContent:data];

    [tableView reloadData];
}

- (IBAction)btnLoadXLSX:(id)sender {
    
    
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"xlsx",@"ods",@"xml",nil]];
    
    if ([panel runModal] == NSOKButton) {
        if ([[panel.URL pathExtension] isEqualToString:@"xlsx"]){
            
            content = [SpreadsheetWriter ReadWorkbook:panel.URL];
            
        } else if ([[panel.URL pathExtension] isEqualToString:@"xml"]){
            
            content = [SpreadsheetWriter ReadWorksheetXML2004:panel.URL];
            
        } else {
            
            content = [SpreadsheetWriter ReadODS:panel.URL ];
        }
        
        [tableView reloadData];
    }
}

- (IBAction)btnWriteXLSX:(id)sender {
    
    NSSavePanel * panel = [[NSSavePanel alloc] init];
    
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"xlsx",@"ods",@"xml",nil]];
    if ([panel runModal] == NSOKButton) {
        
        if ([[panel.URL pathExtension] isEqualToString:@"xlsx"]){
            
            [SpreadsheetWriter WriteWorkbook:panel.URL
                                    withData:content
                                 hasTitleRow:[self hasTitleRow]];
        } else if ([[panel.URL pathExtension] isEqualToString:@"xml"]){
            
            [SpreadsheetWriter WriteWorksheetXML2004:panel.URL
                                    withData:content];
            
        } else {
            
            [SpreadsheetWriter WriteODS:panel.URL
                                    withData:content
                                 hasTitleRow:[self hasTitleRow]];
        }
        

    }
    
}

- (IBAction)btnOpenPressed:(id)sender {
    
    NSOpenPanel * p = [NSOpenPanel new];
    
    if ([p runModal] == NSOKButton) {

        [txtInputCSV setStringValue:[[p URL] path]];
    }
    
}

//************************* table view data source necessities ***************************/
#pragma mark -
#pragma mark Datasource methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTable {
	
	if (content != nil) {
        return [content count];
	} else
		return 0;
	
}

- (id)tableView:(NSTableView *)aTable objectValueForTableColumn:(NSTableColumn *)aCol row:(NSInteger)rowIndex {
	
    int colIndex = 0;
    for (int i = 0; i< aTable.tableColumns.count; i++){
        if ([[aTable.tableColumns objectAtIndex:i] isEqualTo:aCol]){
            colIndex = i;
            break;
        }
    }
    
	if (content != nil) {
        
        return [[content objectAtIndex:rowIndex] objectAtIndex:colIndex];
		
	} else
		return nil;
}

- (void)tableView:(NSTableView *)aTable setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{

    int colIndex = 0;
    for (int i = 0; i< aTable.tableColumns.count; i++){
        if ([[aTable.tableColumns objectAtIndex:i] isEqualTo:tableColumn]){
            colIndex = i;
            break;
        }
    }

    [[content objectAtIndex:row] replaceObjectAtIndex:colIndex withObject:object];
	
}

@end
