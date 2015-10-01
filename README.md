# ACEDrawingViewを使ったサンプル

写真の上に線を描く。  
ただし、写真自体に書き込むのではなく、描いたものを背景が透明な.pngとして保存する。  
描いて保存した画像にたいして、再描画ができることの確認のためのサンプル。

- 線の描画
- 消しゴム
- 保存（Documents/Sample.png）
- 表示／非表示

## 注意
保存される画像は、Viewの２倍のサイズ（Retina仕様？）  
保存した画像を表示する際に、素直にloadImage(image)しただけでは、アスペクト比を保った状態でViewに表示されてない。  
**.drawMode = ACEDrawingMode.Scale**してから、loadImageすること。  

```swift
// モード設定
drawView.drawMode = ACEDrawingMode.Scale
// 画像取得
let path = FileManager.pathOfHomeDirectory()
let lastPath = (path as NSString).stringByAppendingPathComponent("sample.png")
let image = UIImage(contentsOfFile: lastPath)
// Viewに表示
drawView.loadImage(image)
```
