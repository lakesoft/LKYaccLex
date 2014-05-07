//
//  ViewController.m
//  LKYaccLex
//
//  Created by Hiroshi Hashiguchi on 2014/05/05.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "ViewController.h"
#import "LKYaccLexParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LKYaccLexParser* p = LKYaccLexParser.new;
    NSError* error = nil;
    id r1 = [p parseString:@"1 + 2 + 4\n" error:&error];
    NSLog(@"RESULT=%@", r1);
    NSLog(@"ERROR: %@", error);

    LKYaccLexParser* p2 = LKYaccLexParser.new;
    NSError* error2 = nil;
    id r2 = [p2 parseString:@"500-200" error:&error2];
    NSLog(@"RESULT=%@", r2);
    NSLog(@"ERROR: %@", error2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
