//
//  Item.h
//  TodoList
//
//  Created by Jason Wang on 6/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic) NSString *content;
@property (nonatomic) int priority;
@property (nonatomic) BOOL done;

- (instancetype)initWithContent:(NSString *)content priority:(int)priority ;

@end
