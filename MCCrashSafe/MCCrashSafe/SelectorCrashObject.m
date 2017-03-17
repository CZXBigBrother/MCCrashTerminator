//
//  SelectorCrashObject.m
//  MCCrashSafe
//
//  Created by marco chen on 2017/3/17.
//  Copyright © 2017年 marco chen. All rights reserved.
//

#import "SelectorCrashObject.h"
#import <objc/runtime.h>


@implementation SelectorCrashObject
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"******* unrecognized selector -[%s %@]", object_getClassName(self),NSStringFromSelector([anInvocation selector]));
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
        return methodSignature;
    }else {
        SEL selector = NSSelectorFromString(@"empty");
        class_addMethod([self class], selector,(IMP)empty,"v@:");
        NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selector];
        return methodSignature;
    }
}
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}
void empty(){
    NSLog(@"empty");
}
//- (void)asdf {
//    NSLog(@"asdf");
//}
@end
