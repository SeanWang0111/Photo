//
//  myCollectionViewCell.swift
//  paint_test
//
//  Created by Sean Wang on 2021/4/2.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell
{
    @IBOutlet var imgView: UIImageView!
    {
        didSet
        {
            imgView.layer.cornerRadius = 20.0
            imgView.layer.masksToBounds = true
        }
    }
    @IBOutlet var view: UIView!
    {
        didSet
        {
            view.layer.cornerRadius = 30.0
            view.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func setCell(imgName:String)
    {
        imgView.image = UIImage(named: imgName)
    }

}
