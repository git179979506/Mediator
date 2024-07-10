//
//  Mediator.m
//  Mediator
//
//  Created by zhaoshouwen on 2024/7/1.
//

#import "Mediator.h"

@implementation Mediator

+ (instancetype)shared
{
    static Mediator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Mediator alloc] init];
    });

    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSAssert(NO, @"Mediator 未实现方法 %@", NSStringFromSelector(aSelector));
    return [NSMethodSignature signatureWithObjCTypes:"@"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

@end
