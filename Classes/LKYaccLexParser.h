//
//  LKYaccLexParser.h
//  LKYaccLex
//
//  Created by Hiroshi Hashiguchi on 2014/05/05.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    void*                   scanner;
    __unsafe_unretained id  result;
    const char*             error_text;
    int                     error_line;
} _LKYaccLexContext;


@interface LKYaccLexParser : NSObject

@property (nonatomic, assign, readonly) _LKYaccLexContext* context;

#pragma mark - Privates
+ (instancetype)_parserForContext:(_LKYaccLexContext*)context;
- (int)_readToBuffer:(char* )buffer maxLength:(size_t)maxLength;


#pragma mark - API
- (id)parseString:(NSString*)string error:(NSError**)error;


@end
