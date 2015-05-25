//
//  JSONFileManager.h
//  GoRent
//
//  Created by CHIN-KANG CHANG on 2015/1/7.
//  Copyright (c) 2015年 HippoColors. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSON_DEFAULT_FILE_NAME      @"test"

@interface JSONFileManager : NSObject

+(NSDictionary*) JSON_ReadJSONFileWithFileName : (NSString*) FileName;
+(NSDictionary*) JSON_ReadJSONStringWithString : (NSString*) JSONStr;
+(NSDictionary*) JSON_ReadJSONFileWithFilePath : (NSString *) FilePath;
@end
