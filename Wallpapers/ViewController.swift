//
//  ViewController.swift
//  Wallpapers
//
//  Created by Ming Wang on 6/27/16.
//  Copyright © 2016 Mingsin. All rights reserved.
//

import Cocoa
import Moya_ObjectMapper
import SnapKit
import Moya

class ViewController: NSViewController {
    var wallpapers = [Wallpaper]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionView = NSCollectionView()
        self.view.addSubview(collectionView)
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        Api.allWallpapers { (e) in
            switch e {
            case .Next(let r):
                self.wallpapers = r.response
                self.downloadFiles()
            case .Error(let err):
                print(err)
                break
            case .Completed:
                break
            }
        }
    }
    
    func downloadFiles() {
        self.wallpapers.forEach { wp in
            let path = "/Users/wangming/Pictures/wallpapers/\(wp.id).jpg"
            if NSFileManager.defaultManager().fileExistsAtPath(path) {
               return
            }
            print((path,wp.image.url))
            Manager.sharedInstance.download(.GET, wp.image.url, destination: { (url, res) -> NSURL in
                return NSURL(fileURLWithPath: path)
            })
        }
    }
    
    func setWallpapers() {
        var index = 0
        NSScreen.screens()?.forEach({ (screen) in
            let i = index % self.wallpapers.count
            let url = self.wallpapers[i].image.url
            _ = try? NSWorkspace.sharedWorkspace().setDesktopImageURL(NSURL(string: url)!, forScreen: screen, options: [:])
            index += 1
        })
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
}

extension ViewController:NSCollectionViewDataSource {
    func collectionView(collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wallpapers.count
    }
    
    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
        let cell = NSCollectionViewItem()
        return cell
    }
}