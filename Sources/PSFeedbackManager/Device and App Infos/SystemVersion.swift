//
//  SystemVersion.swift
//  PSFeedbackManager
//
//  Created by Peter Salz on 19.12.23.
//

import Foundation

/**
 Adapted from Luminous.

 Here is the Github [Link](https://github.com/andrealufino/Luminous)

 License:

 Copyright (c) 2016 Andrea Mario Lufino <andrea.lufino@21ilab.com>

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
struct SystemVersion: Equatable, Comparable {

    var major: Int
    var minor: Int
    var patch: Int

    var stringValue: String

    init() {

        major = 0
        minor = 0
        patch = 0
        stringValue = "\(major).\(minor).\(patch)"
    }

    /**
     Init with a string version.

     This will fail if the version is not formatted in the correct way, with at least a dot inside it.

     - Parameter version: The version used to initialize the structure.
     */
    init?(withVersion version: String) {

        guard version.contains(".") else {
            return nil
        }

        stringValue = version
        let components = version.components(separatedBy: ".")

        guard components.count >= 2 && components.count <= 3 else {
            return nil
        }

        major = components.count > 0 ? Int(components[0])! : 0
        minor = components.count > 1 ? Int(components[1])! : 0
        patch = components.count > 2 ? Int(components[2])! : 0
    }

    static func == (lhs: SystemVersion, rhs: SystemVersion) -> Bool {
        lhs.stringValue == rhs.stringValue
    }

    static func < (lhs: SystemVersion, rhs: SystemVersion) -> Bool {

        if lhs.major < rhs.major {

            return true

        } else if lhs.major == rhs.major {

            if lhs.minor < rhs.minor {

                return true

            } else if lhs.minor == rhs.minor {

                return lhs.patch < rhs.patch
            }
        }

        return false
    }
}
