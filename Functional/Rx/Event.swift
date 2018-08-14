//
//  Event.swift
//  Functional
//
//  Created by Nguyễn Đức Thọ on 8/7/18.
//  Copyright © 2018 Nguyễn Đức Thọ. All rights reserved.
//

import Foundation

public enum Event<T> {
    case next(T)
    case error(Error)
    case completed
}

public enum CookingEvent<T> {
    case next(T)
    case completed
}
