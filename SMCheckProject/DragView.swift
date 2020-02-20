//
//  DragView.swift
//  SMCheckProject
//
//  Created by didi on 2016/11/1.
//  Copyright © 2016年 Starming. All rights reserved.
//

import Cocoa

protocol DragViewDelegate {
    func dragEnter();
    func dragExit();
    func dragFileOk(filePath:String);
}

class DragView: NSView {
    var delegate : DragViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(OSX 10.13, *) {
            self.registerForDraggedTypes([.URL, .tiff, .fileURL])
        } else {
            // Fallback on earlier versions
        }
//        self.register(forDraggedTypes: [NSFilenamesPboardType, NSURLPboardType, NSPasteboardTypeTIFF])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if let delegate = self.delegate {
            delegate.dragEnter()
        }
        return NSDragOperation.generic
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        if let delegate = self.delegate {
            delegate.dragExit()
        }
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
//        var files = [URL]()
        var filePath = ""
        if #available(OSX 10.13, *) {
            if let board = sender.draggingPasteboard.propertyList(forType: .fileURL) as? String {
                let fileURL = URL.init(fileURLWithPath: board)
                filePath = fileURL.standardized.absoluteString
            }
        } else {
            // Fallback on earlier versions
        }
        if let delegate = self.delegate {
            delegate.dragFileOk(filePath: filePath)
        }
        return true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
}
