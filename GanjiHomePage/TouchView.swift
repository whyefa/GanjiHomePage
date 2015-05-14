//
//  TouchView.swift
//  GanjiHomePage
//
//  Created by iOS on 15/5/14.
//  Copyright (c) 2015年 com.haitaolvyou. All rights reserved.
//

import UIKit

class TouchView: RCView {
    var touchTag:Int?
    var shadowLayer: UIView?
    convenience init(frame: CGRect, tag:Int) {
        self.init(frame:frame)
        touchTag = tag
        var label = UILabel(frame: self.bounds)
        var str = NSString(format: "    第%d 行", touchTag! - 99)
        label.text = str as String
        self.addSubview(label)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if shadowLayer == nil {
            shadowLayer = UIView(frame: self.bounds)
            shadowLayer?.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
            self .addSubview(shadowLayer!)
        }
        shadowLayer?.hidden = false
        self.bringSubviewToFront(shadowLayer!)
        
    }
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        shadowLayer?.hidden = true
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            shadowLayer?.hidden = true
        })
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
