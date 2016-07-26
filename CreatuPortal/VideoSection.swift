//
//  VideoSection.swift
//  CreatuPortal
//
//  Created by Developer8 on 7/15/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class VideoSection: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    //MARK: --Outlets
 @IBOutlet var videoWebView: UIWebView!
    
    //MARK: --Declarations
    var view:UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: --View Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(view)
        //Set Main Cell in Collection View
      
        startVideo(Offline.sharedInstance.videoList[Offline.sharedInstance.selectedVideoIndex])
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "VideoSection", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        self.collectionView.registerNib(UINib(nibName: "VideoSectionView", bundle: nil), forCellWithReuseIdentifier: "Item")
        return view
    }
    
    func startVideo(videoID:String) {
        
        videoWebView.allowsInlineMediaPlayback = true
        videoWebView.mediaPlaybackRequiresUserAction = false
        // Set up your HTML.  The key URL parameters here are playsinline=1 and autoplay=1
        // Replace the height and width of the player here to match your UIWebView's  frame rect
        
        let embededHTML = "<html><body bgcolor=\"#000000\" style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(videoWebView.frame.size.width)' height='\(videoWebView.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
        
        // Load your webView with the HTML we just set up
        videoWebView.loadHTMLString(embededHTML, baseURL: NSBundle.mainBundle().bundleURL)
        
    }
    //MARK:Collection View Deligate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Offline.sharedInstance.videoList.count-1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var Index:Int = 0
        if(Offline.sharedInstance.selectedVideoIndex > indexPath.row){
            Index = indexPath.row
            
        }
        else{
            Index = indexPath.row + 1
            
        }
        let youtubeUrl = "https://www.youtube.com/embed/\(Offline.sharedInstance.videoList[Index])"
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Item", forIndexPath: indexPath) as! CollectionViewCell
        //2
        cell.webview.loadHTMLString("<html><body bgcolor=\"#000000\"><iframe  width=\"\(cell.webview.frame.size.width-10)\" height=\"\(cell.webview.frame.size.height-10)\" src=\"\(youtubeUrl)\" frameborder=\"0\" allowfullscreen></iframe></body></html>", baseURL: nil)
        
        //   cell.lblVideoTitle.text = "mohan singh"
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(Offline.sharedInstance.selectedVideoIndex > indexPath.row){
            Offline.sharedInstance.selectedVideoIndex = indexPath.row
            startVideo(Offline.sharedInstance.videoList[Offline.sharedInstance.selectedVideoIndex])
        }
        else{
            Offline.sharedInstance.selectedVideoIndex = indexPath.row + 1
            startVideo(Offline.sharedInstance.videoList[Offline.sharedInstance.selectedVideoIndex])
        }
        collectionView.reloadData()
    }
    
    //MARK: --Custom Functions
    func stopPause(index:Int){
        if(index == 0){
            videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.pauseVideo()");

        }
        else{
            videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.stopVideo()");

        }
    }
    
    //MARK: --BUtton Actions
  
    

}
