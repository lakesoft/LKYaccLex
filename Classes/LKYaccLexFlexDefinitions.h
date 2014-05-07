//
//  LKYaccLexFunction.h
//  LKYaccLex
//
//  Created by Hiroshi Hashiguchi on 2014/05/05.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#define YY_INPUT(buf,bytes_read,max_size) {                            \
    LKYaccLexParser* p = [LKYaccLexParser _parserForContext:yyextra];  \
    if(p) {                                                            \
        bytes_read = [p _readToBuffer:buf maxLength:max_size];         \
    } else {                                                           \
        bytes_read = YY_NULL;                                          \
    }                                                                  \
}

#define YY_USER_ACTION yylloc->first_line = yylineno;
#define YY_EXTRA_TYPE _LKYaccLexContext*
