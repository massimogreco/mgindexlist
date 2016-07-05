//
//  MGIndexListView.swift
//  MGIndexListContainer
//
//  Created by Massimo Greco on 04/07/16.
//  Copyright © 2016 Massimo Greco. All rights reserved.
//

import UIKit

protocol MGIndexListDelegate {
    func didSelectItem(itemSelected: String, sectionNumber: Int)
}

class MGIndexListView: UIView {

    private var _stackView : UIStackView?
    
    var stackView : UIStackView? {
        get {
            return self._stackView
        }
    }
    
    //Model
    private var _sections : [String]?
    
    var sections : [String]?{
        set{
            self._sections = newValue
        }
        get{
            return self._sections
        }
    }
    
    //Delegate
    var delegate: MGIndexListDelegate?
    
    //Colours
    var backgroudColorForIndexList = UIColor.clearColor()
    var backgroundColorForSelectedButton = UIColor.lightGrayColor()
    var backgroundColorForUnselectedButton = UIColor.clearColor()
    var foreColorForSelectedButton = UIColor.darkGrayColor()
    var foreColorForUnselectedButton = UIColor.lightGrayColor()
    
    //Fonts
    var fontForUnselectedButton = UIFont.systemFontOfSize(12.0)
    var fontForSelectedButton = UIFont.boldSystemFontOfSize(18.0)
   
    //Need this initializer for use the control in a Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createStackView()
        
    }
    
    func buildStackView(){
        self.createButtonsForIndexList()
    }
    
    private func createStackView(){
        _stackView = UIStackView()
        _stackView!.axis = .Vertical
        _stackView!.distribution = .FillEqually
        _stackView!.alignment = .Fill
        _stackView!.spacing = 5
        _stackView!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(_stackView!)
        
        //autolayout
        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
        let viewsDictionary = ["stackView":_stackView!]
        let stackView_H = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-5-[stackView]-5-|",  //horizontal constraint 5 points from left and right side
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-5-[stackView]-5-|", //vertical constraint 5 points from top and bottom
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil,
            views: viewsDictionary)
        self.addConstraints(stackView_H)
        self.addConstraints(stackView_V)
        
    }
    
    private func createButtonsForIndexList(){
        if _stackView != nil {
            for subview in _stackView!.arrangedSubviews{
                let view = subview as! UIButton
                view.removeTarget(nil , action: nil , forControlEvents: UIControlEvents.AllEvents)
                _stackView!.removeArrangedSubview(view)
            }
        }
        
        if(_sections == nil || _stackView == nil){
            return
        }
        
        var i = 0
        for title in _sections!{
            let button   = UIButton(type: UIButtonType.System) as UIButton
            button.frame = CGRectMake(10,10,20,20)
            button.setTitleColor(foreColorForUnselectedButton, forState: .Normal)
            button.titleLabel!.font = fontForUnselectedButton
            button.setTitle(title, forState: UIControlState.Normal)
            button.addTarget(self, action: #selector(self.buttonInStackViewPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i //uso il tag per tenere traccia comoda del numero sezione
            i += 1
            _stackView!.addArrangedSubview(button)
        }
    }
    
    func buttonInStackViewPressed(sender: UIButton){
        for subview in _stackView!.arrangedSubviews{
            let view = subview as! UIButton
            view.titleLabel!.font = fontForUnselectedButton
            view.setTitleColor(foreColorForUnselectedButton, forState: .Normal)
        }
        sender.titleLabel!.font = fontForSelectedButton
        sender.setTitleColor(foreColorForSelectedButton, forState: .Normal)
        
        if self.delegate != nil {
            self.delegate!.didSelectItem(sender.titleLabel!.text!, sectionNumber: sender.tag)
        }
        
    }
    
}
