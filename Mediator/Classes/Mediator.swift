//
//  Mediator.h
//  Mediator
//
//  Created by zhaoshouwen on 2024/7/1.
//

public func MT<P>(_ type: P.Type) -> P? {
    return Mediator.shared() as? P
}
