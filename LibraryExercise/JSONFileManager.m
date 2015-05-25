//
//  JSONFileManager.m
//  GoRent
//
//  Created by CHIN-KANG CHANG on 2015/1/7.
//  Copyright (c) 2015年 HippoColors. All rights reserved.
//

#import "JSONFileManager.h"

@implementation JSONFileManager

+(NSDictionary*) JSON_ReadJSONFileWithFileName : (NSString*) FileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:FileName ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    return json;
}

+(NSDictionary*) JSON_ReadJSONFileWithFilePath : (NSString *) FilePath
{
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:FileName ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:FilePath options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    return json;
}


+(NSDictionary*) JSON_ReadJSONStringWithString : (NSString*) JSONStr
{
    NSError *jsonError;
    NSData *objectData = [JSONStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    return json;
}

-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end
