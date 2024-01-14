//
//  Thread.swift
//  MyWhatsApp
//
//  Created by Shah Md Imran Hossain on 14/1/24.
//

import Foundation

func synchronized(_ lock: AnyObject, _ closure: () -> Void) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

/// Queues a block to be performed on main queue. If the block is called
/// on the main thread and no work is queued, no scheduling takes place and
/// the block is called instantly.
///
/// - Parameter block: block that to be executed
func onMain(block: @escaping () -> Void) {
    DispatchQueue.main.async {
        block()
    }
}

/// Executes code block on main thread asynchronously in deadline.
///
/// Parameters:
///     - after: deadline to execute block of code
///     - block: block to be executed
func onMainAfter(after: Double, block: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        block()
    }
}
