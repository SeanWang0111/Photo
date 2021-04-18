//
//  Canvas.swift
//  paint_test
//
//  Created by Sean Wang on 2021/3/29.
//

import UIKit

struct Line
{
    let strokeWidth : Float
    let color : UIColor
    var points : [CGPoint]
}

class Canvas: UIView
{
    var strokeWidth:Float = 5
    var strokeColor = UIColor.blue
    
    override func draw(_ rect: CGRect)
    {
        super.draw(rect)
            
        guard let context = UIGraphicsGetCurrentContext()
        else
        {
            return
        }
        
        lines.forEach
        {
            (line) in
            
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(CGFloat(line.strokeWidth))
            context.setLineCap(.round)
            
            for (i,p) in line.points.enumerated()
            {
                if i == 0
                {
                    context.move(to: p)
                }
                else
                {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
            
    }
        
    var lines = [Line]()
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let point = touches.first?.location(in: self)
        else
        {
            return
        }
        
        guard var lastLine = lines.popLast()
        else
        {
            return
        }
        lastLine.points.append(point)
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    func undo()
    {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear()
    {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStrokeWidth(width:Float)
    {
        strokeWidth = width
    }
    
    func setColor(color:Int)
    {
        if(color == 0)
        {
            strokeColor = UIColor.black
        }
        if(color == 1)
        {
            strokeColor = UIColor.gray
        }
        if(color == 2)
        {
            strokeColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        }
        if(color == 3)
        {
            strokeColor = UIColor.white
        }
        if(color == 4)
        {
            strokeColor = UIColor(red: 1, green: 20/255, blue: 147/255, alpha: 1)
        }
        if(color == 5)
        {
            strokeColor = UIColor.red
        }
        if(color == 6)
        {
            strokeColor = UIColor.orange
        }
        if(color == 7)
        {
            strokeColor = UIColor(red: 244/255, green: 164/255, blue: 96/255, alpha: 1)
        }
        if(color == 8)
        {
            strokeColor = UIColor.brown
        }
        if(color == 9)
        {
            strokeColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
        }
        if(color == 10)
        {
            strokeColor = UIColor.yellow
        }
        if(color == 11)
        {
            strokeColor = UIColor(red: 189/255, green: 252/255, blue: 201/255, alpha: 1)
        }
        if(color == 12)
        {
            strokeColor = UIColor.green
        }
        if(color == 13)
        {
            strokeColor = UIColor(red: 46/255, green: 128/255, blue: 87/255, alpha: 1)
        }
        if(color == 14)
        {
            strokeColor = UIColor(red: 230/255, green: 1, blue: 1, alpha: 1)
        }
        if(color == 15)
        {
            strokeColor = UIColor.systemTeal
        }
        if(color == 16)
        {
            strokeColor = UIColor.blue
        }
        if(color == 17)
        {
            strokeColor = UIColor.systemIndigo
        }
        if(color == 18)
        {
            strokeColor = UIColor.purple
        }
        if(color == 19)
        {
            strokeColor = UIColor(red: 1, green: 0, blue: 230/255, alpha: 1)
        }
    }
}
