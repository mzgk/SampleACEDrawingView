//
//  FileManager.swift
//  FormCheckerNeo
//
//  Created by Mizugaki on 2015/08/17.
//  Copyright (c) 2015年 TAMA PROJECT. All rights reserved.
//

/**
* 当アプリで使用するディレクトリ・ファイル管理を担当するクラス
*
*
*/

import Foundation

class FileManager: NSObject {
    /**
     * アプリのホームディレクトリのパスを取得する（~/Documents/FormCheckerNeo）
     *
     * :return: String（~/Documents/FormCheckerNeo）
     */
    class func pathOfHomeDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = paths[0]
        return path
    }


    /**
     * アプリのデータを保存するHomeディレクトリの確認と作成（iCloudバックアップ対象外）
     */
    class func makeHomeDirectory() {
        let path = self.pathOfHomeDirectory()
        let fileManager = NSFileManager.defaultManager()
        var isError = NSError?()

        // 確認（あれば作成不要）
        if (fileManager.fileExistsAtPath(path)) {
            return
        }

        // 作成
        var ret: Bool
        do {
            try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
            ret = true
        } catch let error as NSError {
            isError = error
            ret = false
        }
        if (ret) {
            // iCloudバックアップ対象外
            let pathURL = NSURL.fileURLWithPath(path)
            do {
                try pathURL.setResourceValue(true, forKey: NSURLIsExcludedFromBackupKey)
                ret = true
            } catch let error as NSError {
                isError = error
                ret = false
            }
            if (!ret) {
                print("ERROR: iCloud対象外設定: \(isError?.description)")
            }
        }
        else {
            print("ERROR: Homeディレクトリ作成: \(isError?.description)")
        }
    }


    /**
     * ホームディレクトリの直下に、引数で指定したディレクトリを作成する
     *
     * - parameter name:: String（作成するディレクトリの名前）
     * - returns: String?（作成したディレクトリのパス。エラーの場合はnil）
     */
    class func makeDirectory(name name: String) -> String? {
        let home = self.pathOfHomeDirectory()
        let path = (home as NSString).stringByAppendingPathComponent(name)

        let fileManager = NSFileManager.defaultManager()
        var isError = NSError?()
        let ret: Bool
        do {
            try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
            ret = true
        } catch let error as NSError {
            isError = error
            ret = false
        }
        if (!ret) {
            print("ERROR: \(name)ディレクトリ作成: \(isError?.description)")
            return nil
        }
        return path
    }


    /**
     * ファイルの移動を行う
     *
     * - parameter #from:: String（移動元のパス）
     * - parameter to:: String（移動先のパス）
     */
    class func moveFile(from from: String, to: String) {
        let fileManager = NSFileManager.defaultManager()
        var isError = NSError?()

        let ret: Bool
        do {
            try fileManager.moveItemAtPath(from, toPath: to)
            ret = true
        } catch let error as NSError {
            isError = error
            ret = false
        }
        if (!ret) {
            print("ERROR: ファイル移動: \(from) -> \(to) INFO: \(isError?.description)")
        }
    }

    /**
     * 指定したパスのオブジェクトを削除する
     *
     * - parameter path:: String（削除したいオブジェクトのパス）
     */
    class func deletePathObject(path path: String) {
        let fileManager = NSFileManager.defaultManager()
        var isError = NSError?()
        let ret: Bool
        do {
            try fileManager.removeItemAtPath(path)
            ret = true
        } catch let error as NSError {
            isError = error
            ret = false
        }
        if (!ret) {
            print("ERROR: \(path)オブジェクト削除: \(isError?.description)")
        }
    }



    /**
     * 指定したディレクトリ名のディレクトリをホーム配下から削除する
     *
     * - parameter #dirName:: String（ディレクトリ名）
     */
    class func deleteDirectory(dirName dirName: String) {
        let path = getSaveDirPath(dirName: dirName)
        deletePathObject(path: path)
    }

    /**
     * 引数で指定した保存ディレクトリ名のパスを取得する（~/Documents/FormCheckerNeo/引数）
     *
     * - parameter #dirName:: String（保存ディレクトリ名）
     *
     * - returns: String（~/Documents/FormCheckerNeo/引数）
     */
    class func getSaveDirPath(dirName dirName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsPath = paths[0] 
        let path = (documentsPath as NSString).stringByAppendingPathComponent("Sample")
        let savePath = (path as NSString).stringByAppendingPathComponent(dirName)
        return savePath
    }


    /**
    指定したディレクトリの存在確認を行う
    - parameter: dirName: String
    - returns: Bool（true:存在）
    */
    class func isDirectoryExists(dirName name: String) -> Bool {
        if (name == "") {
            return false
        }

        let path = getSaveDirPath(dirName: name)
        let isExist = NSFileManager.defaultManager().fileExistsAtPath(path)
        return isExist
    }
}