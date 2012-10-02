//
//  SpreadsheetWriter.h
//  SpreadsheetWriter
//
//  Created by Tom Grill on 27.09.12.
//  Copyright (c) 2012 Tom Grill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpreadsheetWriter : NSObject

@property (retain) NSMutableArray * data;
@property (retain) NSMutableArray * sharedStrings;
@property (retain) NSString * tmpDir;

+ (NSMutableArray*) ReadWorksheetXML2004: (NSURL*)inputFile;
+ (void) WriteWorksheetXML2004: (NSURL*) outputFile withData:(NSArray*) data;

+ (NSMutableArray*) ReadWorkbook: (NSURL*)inputFile;
+ (void) WriteWorkbook: (NSURL*) outputFile withData: (NSArray*) data hasTitleRow:(Boolean) hasTitleRow;

+ (NSMutableArray*) ReadODS: (NSURL*) inputFile;
+ (void) WriteODS: (NSURL*) outputFile withData: (NSArray*) data hasTitleRow:(Boolean) hasTitleRow;

@end
