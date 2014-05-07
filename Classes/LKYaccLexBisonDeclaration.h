//
//  LKYaccLexBisonDeclaration.h
//  LKYaccLex
//
//  Created by Hiroshi Hashiguchi on 2014/05/07.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#define _LK_YACC_ERROR void yyerror(YYLTYPE* locp,_LKYaccLexContext* context,const char* err) {     \
    LKYaccLexParser* p = [LKYaccLexParser _parserForContext:context];                               \
    if(p) {                                                                                         \
        p.context->error_text = err;                                                                \
        p.context->error_line = locp->first_line;                                                   \
    } else {                                                                                        \
        NSLog(@"Error at line %d: %s\n", locp->first_line, err);                                    \
    }                                                                                               \
}
_LK_YACC_ERROR
int yylex(YYSTYPE* lvalp,YYLTYPE* llocp,void* scanner);

#define scanner context->scanner

