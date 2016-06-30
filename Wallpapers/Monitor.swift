//
//  Monitor.swift
//  Wallpapers
//
//  Created by Ming Wang on 6/30/16.
//  Copyright © 2016 Mingsin. All rights reserved.
//

import Cocoa
import RxSwift
//https://source.unsplash.com/random/
class Monitor {
    static func hello() {
        NSScreen.screens()?.forEach { screen  in
            print(screen.deviceDescription)
        }
        Observable<Int>.just(1).subscribe {
            switch $0 {
            case .Next(let e):
                print(e)
            default:
                break
            }
        }
    }
}


