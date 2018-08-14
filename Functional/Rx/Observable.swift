//
//  Observable.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/7/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

public protocol ObservableType {
    associatedtype E
    
    func subscribe<O: ObserverType>(observer: O) -> Disposable where O.E == E
}

public class Observable<Element>: ObservableType {
    public typealias E = Element
    private let _subscribeHandler: (Observer<Element>) -> Disposable
    
    public init(subscribtionClosure: @escaping (Observer<Element>) -> Disposable) {
        _subscribeHandler = subscribtionClosure
    }
    
    public func subscribe<O : ObserverType>(observer: O) -> Disposable where O.E == E {
        let composite = CompositeDisposable()
        let subscription = _subscribeHandler(Observer { (event) in
            observer.on(event: event)
            switch event {
            case .error, .completed:
                composite.dispose()
            default:
                break
            }
        })
        composite.add(disposable: subscription)
        
        return composite
    }
}

public class MyObservable<Element> {
    public typealias E = Element
    private let _subscribeHandler: (MyObserver<Element>) -> ()
    
    init(subscribtionClosure: @escaping (MyObserver<Element>) -> ()) {
        _subscribeHandler = subscribtionClosure
    }
    
    func subscribe(observer: MyObserver<Element>) -> () {
        _ = _subscribeHandler(MyObserver { (event) in
            observer.on(event: event)
            switch event {
            case .completed:
                print("subscribe event completed")
            default:
                break
            }
        })
    }
    
    func subscribe(onNext: @escaping (E) -> ()) -> () {
        return subscribe(observer: MyObserver { (event) in
            switch event {
            case .next(let element):
                onNext(element)
            default:
                print("subscribeOnNext event completed")
                break
            }
        })
    }
    
    func map<U>(_ transform: @escaping (E) -> U) -> MyObservable<U> {
        return MyObservable<U> { observer in
            return self.subscribe(observer: MyObserver<Element> { (cookingEvent) in
                switch cookingEvent {
                case .next(let element):
                    observer.on(event: .next(transform(element)))
                case .completed:
                    observer.on(event: .completed)
                }
            })
        }
    }
    
    func just(_ value: E) -> MyObservable<E> {
        return MyObservable { (observer) -> () in
            observer.on(event: .next(value))
            observer.on(event: .completed)
        }
    }
}



extension ObservableType {
    public func subscribeOnNext(_ onNext: @escaping (E) -> Void) -> Disposable {
        return subscribe(observer: Observer { (event) in
            switch event {
            case .next(let element):
                onNext(element)
            default:
                break
            }
        })
    }
    
    public static func just(_ value: E) -> Observable<E> {
        return Observable { (observer) -> Disposable in
            observer.on(event: .next(value))
            observer.on(event: .completed)
            return NopeDisposable()
        }
    }
    
    public func map<U>(_ transform: @escaping (E) throws -> U) -> Observable<U> {
        return Observable<U> { observer in
            return self.subscribe(observer: Observer { (event) in
                switch event {
                case .next(let element):
                    do {
                        try observer.on(event: .next(transform(element)))
                    } catch {
                        observer.on(event: .error(error))
                    }
                case .error(let e):
                    observer.on(event: .error(e))
                case .completed:
                    observer.on(event: .completed)
                }
            })
        }
    }
    
    public func flatMap<U>(_ transfrom: @escaping (E) -> Observable<U>) -> Observable<U> {
        return Observable(subscribtionClosure: { (observer) -> Disposable in
            return self.subscribe(observer: Observer { (event) in
                let composite = CompositeDisposable()
                switch event {
                case .next(let element):
                    let transformed = transfrom(element)
                    let disposable = transformed.subscribe(observer: Observer { _event in
                        switch _event {
                        case .next(let e):
                            observer.on(event: .next(e))
                        case .error(let err):
                            observer.on(event: .error(err))
                            composite.dispose()
                        case .completed:
                            observer.on(event: .completed)
                            composite.dispose()
                        }
                    })
                    composite.add(disposable: disposable)
                case .error(let e):
                    observer.on(event: .error(e))
                    composite.dispose()
                case .completed:
                    observer.on(event: .completed)
                    composite.dispose()
                }
            })
        })
    }
    
}
