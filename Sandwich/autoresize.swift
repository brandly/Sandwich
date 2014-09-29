//
//  autoresize.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/28/14.
//
//

import UIKit

extension UILabel {
    func autoresize() {
        if let textNSString: NSString = self.text {
            let rect = textNSString.boundingRectWithSize(CGSizeMake(self.frame.size.width, CGFloat.max),
                options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                attributes: [NSFontAttributeName: self.font],
                context: nil)
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.height)
        }
    }
}
