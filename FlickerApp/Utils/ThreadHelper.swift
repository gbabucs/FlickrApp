//
//  ThreadHelper.swift
//  FlickerApp
//
//  Created by Babu on 18/10/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import UIKit

public class ThreadHelper {

    //--------------------------------------------------------------------------
    // MARK: - Methods
    //--------------------------------------------------------------------------

    class func mainThread(_ closure: () -> Void) {
        if Thread.current == Thread.main {
            closure()
        } else {
            DispatchQueue.main.sync(execute: closure)
        }
    }

    class func mainThreadAsync(_ closure: @escaping () -> Void) {
        if Thread.current == Thread.main {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}
