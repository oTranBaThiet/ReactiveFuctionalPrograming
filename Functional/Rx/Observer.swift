//
//  Observer.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/7/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation
public protocol ObserverType {
    associatedtype E
    
    func on(event: Event<E>)
}

public extension ObserverType {
    func asObserver() -> Observer<E> {
        return Observer(handler: on)
    }
}

public final class Observer<E>: ObserverType {
    private let _handler: (Event<E>) -> Void
    
    public init(handler: @escaping (Event<E>) -> Void) {
        _handler = handler
    }
    
    public func on(event: Event<E>) {
        _handler(event)
    }
}

class MyObserver<E> {
    private let _callBacklosure : (CookingEvent<E>)->()
    public init(initClosure:@escaping (CookingEvent<E>)->()) {
        _callBacklosure = initClosure
    }
    public func on(event: CookingEvent<E>) {
        _callBacklosure(event)
    }
}



public struct AnyObserver<E>: ObserverType {
    private let handler: (Event<E>) -> Void
    
    public init(handler: @escaping (Event<E>) -> Void) {
        self.handler = handler
    }
    
    public init(observer: Observer<E>) {
        self.handler = observer.on
    }
    
    public func on(event: Event<E>) {
        handler(event)
    }
}
