//
//  List.m
//  TodoList
//
//  Created by Jason Wang on 6/30/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "List.h"
#import "Manager.h"

@implementation List

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(int)getPriority {
    [Manager printString:@"Enter priority (1 - 4):"];
    int priority = [Manager getInputString].intValue;
    if (priority < 1 || priority > 4) {
        [Manager printString:@"Outside limits! 1 is min, 4 is max."];
        //instead of making the worlds saddest loop; recursion
//        while (priority < 1 || priority > 4) {
//            [Manager printString:@"Enter priority (1 - 4):"];
//            priority = [Manager getInputString].intValue;
//        }
        return [self getPriority];
    }
    return priority;
}

-(Item *)addItem {
    [Manager printString:@"Enter task:"];
    NSString *task = [Manager getInputString];
    
    int priority = [self getPriority];
    
    Item *newItem = [[Item alloc] initWithContent:task priority:priority];
    [self.items addObject:newItem];
    
    [self printList];
    return newItem;
    
}

-(void)removeItem {
    [self printList];
    [Manager printString:@"Choose the index to remove:"];
    int removeIndex = [Manager getInputString].intValue-1;
    [self.items removeObjectAtIndex:removeIndex];
    [self printList];
}

-(void)editItem {
    [self printList];
    [Manager printString:@"Choose the index to edit:"];
    int editIndex = [Manager getInputString].intValue-1;
    Item *item = [self.items objectAtIndex:editIndex];
    
    [Manager printString:@"Enter task:"];
    NSString *task = [Manager getInputString];
    
    int priority = [self getPriority];
    
    item.content = task;
    item.priority = priority;
    [self printList];
    
}

-(void)markDone {
    [self printList];
    [Manager printString:@"Chose the index to Mark Done:"];
    int markIndex = [Manager getInputString].intValue-1;
    Item *markItem = [self.items objectAtIndex:markIndex];
    markItem.done = YES;
}

-(void)printList {
    [Manager printString:[NSString stringWithFormat:@"Title: %@", self.title]];
    [Manager printString:self.description];
}


-(NSString *)description
{
    NSMutableString *desc = [[NSMutableString alloc] init];
    [desc appendString:@"\n"];
    for (int i = 0; i < self.items.count; i++) {
        NSString *newLine = [NSString stringWithFormat:@"%@: %@\n",@(i+1), self.items[i]];
        [desc appendString:newLine];
    }
    return desc;
}


-(void)printMenu {
    [Manager printString:[NSString stringWithFormat:@"\n\n~[%@]~\n \nChoose form the following:", self.title]];
    [Manager printString:@"1. Print list"];
    [Manager printString:@"2. Add Item"];
    [Manager printString:@"3. Remove Item"];
    [Manager printString:@"4. Edit Item"];
    [Manager printString:@"5. Mark Done"];
    [Manager printString:@"99. Main menu"];
}

-(int)getMenuInput {
    [self printMenu];
    return [Manager getInputString].intValue;
}

-(void)showMenu {
    while (true) {
        int input = [self getMenuInput];
        if (input == 1) {
            [self printList];
        }
        else if (input == 2) {
            [self addItem];
        }
        else if (input == 3) {
            [self removeItem];
        }
        else if (input == 4) {
            [self editItem];
        }
        else if (input == 5) {
            [self markDone];
        }
        else if (input == 99) {
            break;
        }
    }
}

@end
