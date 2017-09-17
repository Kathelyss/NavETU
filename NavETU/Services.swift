//
//  Services.swift
//  NavETU
//
//  Created by Екатерина Рыжова on 17.09.17.
//  Copyright © 2017 Екатерина Рыжова. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        guard let range = self.range(of: ".") else { return self }
        
        return NSLocalizedString(self,
                                 tableName: String(self[..<range.lowerBound]),
                                 comment: self)
    }
    
    func localized(_ arguments: CVarArg...) -> String {
        let template = localized
        return String(format: template, arguments: arguments)
    }
}
