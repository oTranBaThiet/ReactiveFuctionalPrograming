//
//  Disposable.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/7/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation
public protocol Disposable {
    func dispose()
}

public final class AnonimousDisposable: Disposable {
    private let _diposeHandler: () -> Void
    
    public init(_ diposeClosure: @escaping () -> Void) {
        _diposeHandler = diposeClosure
    }
    
    public func dispose() {
        _diposeHandler()
    }
}

public final class CompositeDisposable: Disposable {
    private var isDisposed: Bool = false
    private var disposables: [Disposable] = []
    
    public init() {}
    
    public func add(disposable: Disposable) {
        if isDisposed {
            disposable.dispose()
            return
        }
        disposables.append(disposable)
    }
    
    public func dispose() {
        if isDisposed { return }
        disposables.forEach {
            $0.dispose()
        }
        isDisposed = true
    }
}

public final class NopeDisposable: Disposable {
    public init() {}
    
    public func dispose() {}
}
