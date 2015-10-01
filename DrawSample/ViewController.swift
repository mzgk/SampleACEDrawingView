//
//  ViewController.swift
//  DrawSample
//
//  Created by Mizugaki on 2015/10/01.
//  Copyright © 2015年 TAMA PROJECT. All rights reserved.
//

import UIKit
import ACEDrawingView

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var drawView: ACEDrawingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func displaySwitch(sender: UISwitch) {
        if sender.on {
            drawView.hidden = false

//            // 画像をリサイズ（２倍で保存されるが、loadするとViewに収まってくれないので）
//            // 弊害としては、線がだんだんとボヤけてくる
//            let path = FileManager.pathOfHomeDirectory()
//            let lastPath = (path as NSString).stringByAppendingPathComponent("sample.png")
//            let image = UIImage(contentsOfFile: lastPath)
//            let size = CGSize(width: 900, height: 600)
//            UIGraphicsBeginImageContext(size)
//            image?.drawInRect(CGRectMake(0, 0, size.width, size.height))
//            let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//
//            // 画像を表示
//            drawView.loadImage(resizeImage)

            // モードをViewに合わせる☆重要☆
            drawView.drawMode = ACEDrawingMode.Scale
            let path = FileManager.pathOfHomeDirectory()
            let lastPath = (path as NSString).stringByAppendingPathComponent("sample.png")
            let image = UIImage(contentsOfFile: lastPath)
            drawView.loadImage(image)
        }
        else {
            drawView.hidden = true
        }
    }

    @IBAction func tapSaveButton(sender: UIButton) {
        // .png形式にする
        let data = UIImagePNGRepresentation(drawView.image!)

        // 名前をつけてDocumentディレクトリへ保存
        let path = FileManager.pathOfHomeDirectory()
        let lastPath = (path as NSString).stringByAppendingPathComponent("sample.png")
        data?.writeToFile(lastPath, atomically: true)
    }

    @IBAction func tapEraserButton(sender: UIButton) {
        drawView.lineWidth = 15.0
        drawView.drawTool = ACEDrawingToolTypeEraser
    }

    @IBAction func tapLineButton(sender: UIButton) {
        drawView.lineWidth = 10.0
        drawView.drawTool = ACEDrawingToolTypePen
    }
}

