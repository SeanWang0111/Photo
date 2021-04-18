//
//  paintVC.swift
//  paint_test
//
//  Created by Sean Wang on 2021/3/29.
//

import UIKit

class paintVC: UIViewController
{
    var colorNameArr : [String]?
    
    
    @IBOutlet var paintNumber: UILabel!
    @IBOutlet var tColor: UILabel!
    
    
    @IBOutlet var backView: UIView!
    @IBOutlet var canvas: Canvas!
    @IBOutlet var image: UIImageView!
    @IBOutlet var clearB: UIButton!
    {
        didSet
        {
            clearB.layer.cornerRadius = 15.0
            clearB.layer.masksToBounds = true
        }
    }
    @IBOutlet var undoB: UIButton!
    {
        didSet
        {
            undoB.layer.cornerRadius = 15.0
            undoB.layer.masksToBounds = true
        }
    }
    @IBOutlet var saveB: UIButton!
    {
        didSet
        {
            saveB.layer.cornerRadius = 15.0
            saveB.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    var image11 = UIImage()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let userDefault = UserDefaults.standard
        colorNameArr = userDefault.value(forKey: "fruitName") as? [String]
        
        image.image = image11
        
        canvas.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        canvas.clipsToBounds = true
        canvas.isMultipleTouchEnabled = false
        
        collectionViewInit()
    }
    
    func collectionViewInit()
    {
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: "headerView")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "reuseCell")
        let cellNib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "myCollectionViewCell")
    }
    
    @IBAction func clear(_ sender: UIButton)
    {
        let alertController = UIAlertController(title: "--清除--", message: "確定要清除所有繪畫？！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default)
        {
            (action) in
            self.canvas.clear()
        }
        let notAction = UIAlertAction(title: "取消", style: .destructive)
        alertController.addAction(okAction)
        alertController.addAction(notAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func undo(_ sender: Any)
    {
        canvas.undo()
    }
    
    @IBAction func save(_ sender: Any)
    {
        let alertController = UIAlertController(title: "--儲存--", message: "確定要儲存圖片？！", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "確定", style: .default)
        {
            (action) in
            UIGraphicsBeginImageContext(self.backView.bounds.size) // 開始擷取畫圖板
            self.backView.layer.render(in: UIGraphicsGetCurrentContext()!)
            let img : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext() // 結束擷取
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
            self.showLogin()
        }
        let notAction = UIAlertAction(title: "取消", style: .destructive)
        alertController.addAction(okAction)
        alertController.addAction(notAction)
        present(alertController, animated: true, completion: nil)
    }
    func showLogin()
    {
        let msgView = UIAlertController(title: "儲存成功", message: "已將圖片存入手機相簿裡", preferredStyle: .alert)
        let determineAvtion = UIAlertAction(title: "確定", style: .default)
        msgView.addAction(determineAvtion)
        present(msgView, animated: true)
    }
    
    @IBAction func valueChanged(_ sender: UISlider)
    {
        paintNumber.text = String(format: "%.2f/10", sender.value*10)
        canvas.setStrokeWidth(width: sender.value*10)
    }
    
}

extension paintVC: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return colorNameArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionViewCell", for: indexPath) as! myCollectionViewCell
        cell.setCell(imgName: colorNameArr?[indexPath.row] ?? "")
        return cell
    }
    
}

extension paintVC:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
            
            let width = Int((collectionView.bounds.size.width-30)/4)
            return CGSize(width: width, height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
}

extension paintVC:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath)
    {
        if(indexPath.row == 0)
        {
            tColor.text = "黑色"
            tColor.textColor = UIColor.black
        }
        if(indexPath.row == 1)
        {
            tColor.text = "灰色"
            tColor.textColor = UIColor.gray
        }
        if(indexPath.row == 2)
        {
            tColor.text = "銀色"
            tColor.textColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        }
        if(indexPath.row == 3)
        {
            tColor.text = "白色"
            tColor.textColor = UIColor.white
        }
        if(indexPath.row == 4)
        {
            tColor.text = "桃紅色"
            tColor.textColor = UIColor(red: 1, green: 20/255, blue: 147/255, alpha: 1)
        }
        if(indexPath.row == 5)
        {
            tColor.text = "紅色"
            tColor.textColor = UIColor.red
        }
        if(indexPath.row == 6)
        {
            tColor.text = "橘色"
            tColor.textColor = UIColor.orange
        }
        if(indexPath.row == 7)
        {
            tColor.text = "膚色"
            tColor.textColor = UIColor(red: 244/255, green: 164/255, blue: 96/255, alpha: 1)
        }
        if(indexPath.row == 8)
        {
            tColor.text = "咖啡色"
            tColor.textColor = UIColor.brown
        }
        if(indexPath.row == 9)
        {
            tColor.text = "金色"
            tColor.textColor = UIColor(red: 1, green: 215/255, blue: 0, alpha: 1)
        }
        if(indexPath.row == 10)
        {
            tColor.text = "黃色"
            tColor.textColor = UIColor.yellow
        }
        if(indexPath.row == 11)
        {
            tColor.text = "淺綠色"
            tColor.textColor = UIColor(red: 189/255, green: 252/255, blue: 201/255, alpha: 1)
        }
        if(indexPath.row == 12)
        {
            tColor.text = "綠色"
            tColor.textColor = UIColor.green
        }
        if(indexPath.row == 13)
        {
            tColor.text = "深綠色"
            tColor.textColor = UIColor(red: 46/255, green: 128/255, blue: 87/255, alpha: 1)
        }
        if(indexPath.row == 14)
        {
            tColor.text = "天藍色"
            tColor.textColor = UIColor(red: 230/255, green: 1, blue: 1, alpha: 1)
        }
        if(indexPath.row == 15)
        {
            tColor.text = "藍綠色"
            tColor.textColor = UIColor.systemTeal
        }
        if(indexPath.row == 16)
        {
            tColor.text = "藍色"
            tColor.textColor = UIColor.blue
        }
        if(indexPath.row == 17)
        {
            tColor.text = "靛色"
            tColor.textColor = UIColor.systemIndigo
        }
        if(indexPath.row == 18)
        {
            tColor.text = "紫色"
            tColor.textColor = UIColor.purple
        }
        if(indexPath.row == 19)
        {
            tColor.text = "粉色"
            tColor.textColor = UIColor(red: 1, green: 0, blue: 230/255, alpha: 1)
        }
        canvas.setColor(color: indexPath.row)
    }
}
