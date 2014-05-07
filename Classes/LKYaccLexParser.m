//
//  LKYaccLexParser.m
//  LKYaccLex
//
//  Created by Hiroshi Hashiguchi on 2014/05/05.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//
#import "LKYaccLexParser.h"

#pragma mark - Yacc/Lex prototype
int  yyparse(_LKYaccLexContext* context);
int  yylex_init(void** scanner);
void yyset_extra(_LKYaccLexContext* context, void* scanner);
int  yylex_destroy(void* scanner);

#pragma mark - Macros
#define _LKYaccLexParserKey(ctx)    ([NSValue valueWithPointer:ctx])


@interface LKYaccLexParser()
@property (nonatomic, assign) _LKYaccLexContext* context;
@property (nonatomic, strong) NSInputStream* stream;
@end

@implementation LKYaccLexParser

#pragma mark - Privates

+ (NSMutableDictionary*)parsers
{
    static NSMutableDictionary* _parsers = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _parsers = @{}.mutableCopy;
    });
    return _parsers;
}

#pragma mark - Basics
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.context = (_LKYaccLexContext*)malloc(sizeof(_LKYaccLexContext));
        yylex_init(&(self.context->scanner));
        yyset_extra(self.context, self.context->scanner);
        self.context->result = nil;
        self.context->error_text = nil;
        self.context->error_line = -1;
        
        LKYaccLexParser.parsers[_LKYaccLexParserKey(self.context)] = self;
    }
    return self;
}

- (void)dealloc
{
    free((void*)self.context->error_text);
    yylex_destroy(self.context->scanner);
    free(self.context);
    [LKYaccLexParser.parsers removeObjectForKey:_LKYaccLexParserKey(self.context)];
}

#pragma mark - API (Context Management)
+ (instancetype)_parserForContext:(_LKYaccLexContext*)context
{
	return [self.parsers objectForKey:_LKYaccLexParserKey(context)];
}

#pragma mark - API
- (id)parseString:(NSString*)string error:(NSError**)error
{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
	self.stream = [NSInputStream inputStreamWithData:data];

	[self.stream open];
    
    id result = nil;
    
	if(yyparse(self.context)) {
		if(error) {
			NSString* description = [NSString stringWithFormat:
                                     @"Error at line %d: %s", self.context->error_line, self.context->error_text];
            (*error) = [NSError errorWithDomain:@"ParseError"
                                           code:-1
                                       userInfo:@{NSLocalizedDescriptionKey:description}];
		}
        
	} else {
		result = self.context->result;
	}

	[self.stream close];
	self.stream = nil;
    
	return result;
}

#pragma mark - Privates
- (int)_readToBuffer:(char* )buffer maxLength:(size_t)maxLength
{
    switch (self.stream.streamStatus) {
        case NSStreamStatusAtEnd:
            return 0;

        case NSStreamStatusClosed:
            self.context->error_text = strdup("Illegal state: NSStreamStatusClosed)");
            self.context->error_line = -1;
            return 0;
            
        case NSStreamStatusError:
            self.context->error_text = strdup("Illegal state: NSStreamStatusError)");
            self.context->error_line = -1;
            return 0;
            
        case NSStreamStatusNotOpen:
            self.context->error_text = strdup("Illegal state: NSStreamStatusNotOpen)");
            self.context->error_line = -1;
            return 0;
            
        default:
            break;
    }

	NSInteger bytesRead = [self.stream read:(uint8_t* )buffer maxLength:(NSUInteger)maxLength];

	if(bytesRead == 0) {
		return 0;
	}

	if(bytesRead < 0) {
		self.context->error_text = strdup("Read failed");
        self.context->error_line = -1;
		return 0;
	}

	return (int)bytesRead;
}


@end
