//
//  Mediator.h
//  Mediator
//
//  Created by zhaoshouwen on 2024/7/1.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

/**
 * 模块间通信接口抽象
 * @discussion 子protocol需要统一使用MT前缀
 */
@protocol Mediator <NSObject>

+ (instancetype)shared;

@end

@interface Mediator : NSObject<Mediator>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;

+ (instancetype)shared;

@end

// 根据传入的组件协议返回实现该协议的类的代理
NS_INLINE id MediaInstanceFromProtocol(Protocol *protocol) {
    if ([Mediator.shared conformsToProtocol:protocol]) {
        return Mediator.shared;
    } else {
        NSCAssert(NO, @"Mediator must confirm the procol %@", NSStringFromProtocol(protocol));
        return nil;
    }
}

/// 模块间调用
#define MT(protocol_t) ((id<protocol_t>)(MediaInstanceFromProtocol(@protocol(protocol_t))))

NS_ASSUME_NONNULL_END
