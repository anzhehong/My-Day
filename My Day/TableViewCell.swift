//
//  TableViewCell.swift
//  My Day
//
//  Created by FOWAFOLO on 15/6/14.
//  Copyright (c) 2015年 Fowafolo. All rights reserved.
//

import UIKit
import QuartzCore

// A protocol that the TableViewCell uses to inform its delegate of state change
protocol TableViewCellDelegate {
    // indicates that the given item has been deleted
    func toDoItemDeleted(todoItem: TodoModel)
    func toDoItemCompleted(todoItem: TodoModel)
}

class TableViewCell: UITableViewCell {

    var lll1 = UILabel()
    var lll2 = UILabel()
    var lll3 = UILabel()
    
    var originalCenter = CGPoint()
    var deleteOnDragRelease = false, completeOnDragRelease = false
    
    let label: StrikeThroughText
    let label2: StrikeThroughText
    let label3: StrikeThroughText
    
    var itemCompleteLayer = CALayer()
    
    // The object that acts as delegate for this cell.
    var delegate: TableViewCellDelegate?
    // The item that this cell renders.
    var toDoItem: TodoModel?{
        didSet {
//            label.text = toDoItem?.title
            label.text = toDoItem?.title
            label2.text = toDoItem?.type
            label3.text = toDoItem?.date
            
            label.strikeThrough = toDoItem!.completed!
            itemCompleteLayer.hidden = !label.strikeThrough
        }
    }
    
    let gradientLayer = CAGradientLayer()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        // create a label that renders the to-do item text
        label = StrikeThroughText(frame: CGRect.nullRect)
        label2 = StrikeThroughText(frame: CGRect.nullRect)
        label3 = StrikeThroughText(frame: CGRect.nullRect)
        
        
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.boldSystemFontOfSize(18)
        label.backgroundColor = UIColor.clearColor()
        
        label2.textColor = UIColor.whiteColor()
        label2.font = UIFont.boldSystemFontOfSize(18)
        label2.backgroundColor = UIColor.clearColor()
        label3.textColor = UIColor.whiteColor()
        label3.font = UIFont.boldSystemFontOfSize(18)
        label3.backgroundColor = UIColor.clearColor()

        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(label)
        addSubview(label2)
        addSubview(label3)
        // remove the default blue highlight for selected cells
        selectionStyle = .None
        
        // gradient layer for cell
        gradientLayer.frame = bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).CGColor as CGColorRef
        let color2 = UIColor(white: 1.0, alpha: 0.1).CGColor as CGColorRef
        let color3 = UIColor.clearColor().CGColor as CGColorRef
        let color4 = UIColor(white: 0.0, alpha: 0.1).CGColor as CGColorRef
        gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.locations = [0.0, 0.01, 0.95, 1.0]
        layer.insertSublayer(gradientLayer, atIndex: 0)
        
        // add a pan recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        // add a layer that renders a green background when an item is complete
        itemCompleteLayer = CALayer(layer: layer)
        itemCompleteLayer.backgroundColor = UIColor(red: 0.0, green: 0.6, blue: 0.0,
            alpha: 1.0).CGColor
        itemCompleteLayer.hidden = true
        layer.insertSublayer(itemCompleteLayer, atIndex: 0)

    }
    
    let kLabelLeftMargin: CGFloat = 15.0
    override func layoutSubviews() {
        super.layoutSubviews()
        // ensure the gradient layer occupies the full bounds
        gradientLayer.frame = bounds
        itemCompleteLayer.frame = bounds
        label.frame = CGRect(x: kLabelLeftMargin, y: 0,
            width: bounds.size.width - kLabelLeftMargin,
            height: bounds.size.height/3)
        label2.frame = CGRect(x: kLabelLeftMargin, y: bounds.size.height/3, width: bounds.size.width - kLabelLeftMargin, height: bounds.size.height/3)
        label3.frame = CGRect(x: kLabelLeftMargin, y: bounds.size.height*2/3, width: bounds.size.width - kLabelLeftMargin, height: bounds.size.height/3)
    }
    
    //MARK: - horizontal pan gesture methods
    func handlePan(recognizer: UIPanGestureRecognizer) {
        // 1
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        // 2
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            // has the user dragged the item far enough to initiate a delete/complete?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
        }
        // 3
        if recognizer.state == .Ended {
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                width: bounds.size.width, height: bounds.size.height)
            
            if !deleteOnDragRelease {
                // if the item is not being deleted, snap back to the original location
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
            
            if deleteOnDragRelease {
                if delegate != nil && toDoItem != nil {
                    // notify the delegate that this item should be deleted
                    delegate!.toDoItemDeleted(toDoItem!)
                }
            }else if completeOnDragRelease {
                if toDoItem != nil && delegate != nil{
                    toDoItem?.completed = true
                    delegate!.toDoItemCompleted(toDoItem!)
                }
                
                label.strikeThrough = true
                label.strikeThrough = true
                itemCompleteLayer.hidden = false
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
                
            else {
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
        }
    }
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
}