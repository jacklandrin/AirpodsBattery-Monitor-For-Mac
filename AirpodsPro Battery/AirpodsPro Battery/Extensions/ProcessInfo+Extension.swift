//
//  ProcessInfo+Extension.swift
//  AirpodsPro Battery
//
//  Created by Mohamed Arradi on 07/04/2022.
//  Copyright © 2022 Mohamed Arradi. All rights reserved.
//

import Foundation

enum HardwareType: String {
    case x86_64 = "x86_64"
    case arm64 = "arm64"
}

extension ProcessInfo {
    /// Returns a `HardwareType` representing the machine hardware name or nil if there was an error invoking `uname(_:)` or decoding the response.
    ///
    /// Return value is the equivalent to running `$ uname -m` in shell.
    var machineHardwareName: HardwareType {
        var sysinfo = utsname()
        let result = uname(&sysinfo)
        guard result == EXIT_SUCCESS else { return .arm64 }
        let data = Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN))
        guard let identifier = String(bytes: data, encoding: .ascii) else { return .arm64 }
        let hardware = identifier.trimmingCharacters(in: .controlCharacters)
       
        if hardware == HardwareType.x86_64.rawValue {
            return .x86_64
        } else {
            return .arm64
        }
    }
}
