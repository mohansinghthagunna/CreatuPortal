//
//  NewsListVC.swift
//  CreatuPortal
//
//  Created by Developer8 on 5/16/16.
//  Copyright © 2016 Mohan. All rights reserved.
//

import UIKit

class NewsListVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,SWRevealViewControllerDelegate {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var busyIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblNewsMenuTitle: UILabel!
     @IBOutlet var videoWebView: UIWebView!
    @IBOutlet var videoVIew: UIView!
    var data = NSMutableData()
    var timer = NSTimer()
    @IBOutlet var button: UIButton!
    var titleNews:[String] = []
    var desNews:[String] = []
    var imageNews:[UIImage] = []
    
    override func viewDidLoad() {
        let urlPath: String = "http://tvannapurna.com/api/get_category_posts/?id=\(count)"
        busyIndicator.hidden = true;
        if(Offline.sharedInstance.menuSelect == 0 && Offline.sharedInstance.isFirst == 0){
                       busyIndicator.hidden = false;
            //let queue = NSOperationQueue()
            
//            queue.addOperationWithBlock() {
//                // do something in the background
//                
                    // when done, update your UI and/or model on the main queue
                    self.startConnection(urlPath)

  //
    //        }
        }
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
    }
    override func viewWillAppear(animated: Bool) {
        revealViewController().rearViewRevealWidth = UIScreen.mainScreen().bounds.width-62
         startVideo(Offline.sharedInstance.videoList[Offline.sharedInstance.selectedVideoIndex])
      
        tableView.reloadData()
        
        if(Offline.sharedInstance.menuSelect != 0){
            videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.stopVideo()");
          //  tableView.scrollEnabled = true
           // contentView.frame.size.height =  contentView.frame.size.height + 338

        }
        else{
       //   tableView.scrollEnabled = false
        }
    }
    
    @IBOutlet var webView: UIWebView!
    @IBAction func btnSideMenuTapped(sender: AnyObject) {
        
        // self.revealViewController()
        revealViewController().revealToggle(sender)
        revealViewController().delegate = self
        
    }
    //MARK:SCROLL view deligate
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let scrollPos = scrollView.contentOffset.y
//        print(scrollPos)
//        if(scrollPos >= 237.0){
//           
//            tableView.scrollEnabled = true
//            
//        }
//        else{
//            
//             tableView.scrollEnabled = false
//            
//        }
        
    }
    
    //MARK:TABLE VIEW DELIGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if( Offline.sharedInstance.menuSelect == 0){
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as! nameListCell
        if(Offline.sharedInstance.menuSelect != 0)
        {
        let postItem =  Offline.sharedInstance.category[Offline.sharedInstance.menuSelect-1].posts[indexPath.row]
        cell.lblTitle.text = postItem.title
        cell.lblDescription.text = "date: " + postItem.date
        cell.imgLayer.image = postItem.thumbnail_image
        }
        else
        {
            if(indexPath.section == 0){
                let postItem =  Offline.sharedInstance.recent[indexPath.row]
                cell.lblTitle.text = postItem.title
                cell.lblDescription.text = "date: " + postItem.date
                cell.imgLayer.image = postItem.thumbnail_image
            }
            else{
                if(Offline.sharedInstance.category.count > 1){
                            let postItem =  Offline.sharedInstance.category[1].posts[indexPath.row]
                            cell.lblTitle.text = postItem.title
                            cell.lblDescription.text = "date: " + postItem.date
                            cell.imgLayer.image = postItem.thumbnail_image
                }
            }

        }
        //cell.videoView.removeFromSuperview()
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 97
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clearColor()
        if(Offline.sharedInstance.menuSelect != 0)
        {
             return Offline.sharedInstance.category[Offline.sharedInstance.menuSelect-1].posts.count
        }
        if(section == 0)
        {
            if( Offline.sharedInstance.recent.count > 5){
            return 5
            }
            else{
                return  Offline.sharedInstance.recent.count
            }
        }
        else{
            if Offline.sharedInstance.category.count > 1{
            if( Offline.sharedInstance.category[1].posts.count > 5){
                return 5
            }
            else{
                return  Offline.sharedInstance.category[1].posts.count
            }
        }
        }
        return 5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      //            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! nameListCell
            //            cell.videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.pauseVideo()");
             videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.pauseVideo()");
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newsDetails") as! NewsDetailsVC
        if(Offline.sharedInstance.menuSelect == 0){
            if(indexPath.section == 0)
            {
               secondViewController.post = Offline.sharedInstance.recent[indexPath.row]
            }
            else{
                    secondViewController.post = Offline.sharedInstance.category[1].posts[indexPath.row]
            }
          
        }
        else{
              secondViewController.post = Offline.sharedInstance.category[Offline.sharedInstance.menuSelect-1].posts[indexPath.row]
        }
        
            self.navigationController?.pushViewController(secondViewController, animated: true)
        
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(Offline.sharedInstance.menuSelect != 0)
        {
            return 0;
        }
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView =  UIView(frame: CGRectMake(0, 0,self.tableView.frame.width, 40))
        let lblView = UILabel(frame: CGRectMake(15, 0,self.tableView.frame.width, 40))
        if( Offline.sharedInstance.menuSelect != 0){
            return nil
        }
        if(section == 0){
           lblView.text = "Recent News"
        }
        else{
            if(Offline.sharedInstance.category.count > 1){
            lblView.text = Offline.sharedInstance.category[1].title
            }
        }
       
        lblView.textColor = UIColor.whiteColor()
        sectionView.addSubview(lblView)
        sectionView.backgroundColor = UIColor(red: (43.0 / 255.0), green: (113.0 / 255.0), blue: (230.0 / 255.0), alpha: 1.0)
        
        return sectionView
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
      
        let more = UITableViewRowAction(style: .Normal, title: "More") { action, index in
            print("more button tapped")
            if(indexPath.section != 0 && Offline.sharedInstance.menuSelect == 0 )
            {
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newsDetails") as! NewsDetailsVC
                if(Offline.sharedInstance.menuSelect == 0){
                    secondViewController.post = Offline.sharedInstance.category[indexPath.section].posts[indexPath.row]
                }
                else{
                    secondViewController.post = Offline.sharedInstance.category[Offline.sharedInstance.menuSelect-1].posts[indexPath.row]
                }
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            else if(Offline.sharedInstance.menuSelect > 0){
                let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("newsDetails") as! NewsDetailsVC
                if(Offline.sharedInstance.menuSelect == 0){
                    secondViewController.post = Offline.sharedInstance.category[indexPath.section].posts[indexPath.row]
                }
                else{
                    secondViewController.post = Offline.sharedInstance.category[Offline.sharedInstance.menuSelect-1].posts[indexPath.row]
                }
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            
        }
   
        let share = UITableViewRowAction(style: .Normal, title: "Share") { action, index in
            print("share button tapped")
            var post = Posts()
            if(indexPath.section != 0 && Offline.sharedInstance.menuSelect == 0 )
            {
                
                post = Offline.sharedInstance.category[indexPath.section].posts[indexPath.row]
                
            }
            else if(Offline.sharedInstance.menuSelect > 0){
                
                post = Offline.sharedInstance.category[indexPath.section].posts[indexPath.row]
                
            }
            let textToShare: String = post.title + "\n date: "+post.date
            let myWebsite: NSURL = NSURL(string: post.url)!
            let objectsToShare: [AnyObject] = [textToShare, myWebsite]
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            let excludeActivities: [String] = [UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypeMessage,UIActivityTypeAirDrop, UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo]
            activityVC.excludedActivityTypes = excludeActivities
            self.presentViewController(activityVC, animated: true, completion: { _ in })
            
        }
        share.backgroundColor = UIColor.grayColor()
        
        return [share, more]
    }
    //MARK: COllection VIew Deligates
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
    
    // MARK: -- reveal view controller deligate button tapped
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
        
        if(position == FrontViewPositionLeft) {
            if(Offline.sharedInstance.menuSelect >= 0){
                if(Offline.sharedInstance.menuSelect == 0)
                {
                    videoVIew.hidden = false
                   //  contentView.frame.size.height =  contentView.frame.size.height + 338
                  //   tableView.scrollEnabled = false
                    navigationItem.title = "HOME"
                    var frame =  tableView.frame
                    frame.origin.y = 465.0
                    tableView.frame = frame
                    videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.playVideo()");
                    
                }
                else{
                  //  contentView.frame.size.height =  contentView.frame.size.height - 338
                  //   tableView.scrollEnabled = true
                      videoVIew.hidden = true
                    videoWebView.stringByEvaluatingJavaScriptFromString("ytplayer.stopVideo()");
                    var frame =  tableView.frame
                    frame.origin.y = 0
                    tableView.frame = frame
                    navigationItem.title = Offline.sharedInstance.category[Offline.sharedInstance.menuSelect - 1].title
                }
               
                tableView.reloadData()
            }
            
        }
    }
    
    //MARK:CUSTOM FUNCTION
    func startVideo(videoID:String) {
        if(Offline.sharedInstance.menuSelect == 0){
        videoWebView.allowsInlineMediaPlayback = true
        videoWebView.mediaPlaybackRequiresUserAction = false
        // Set up your HTML.  The key URL parameters here are playsinline=1 and autoplay=1
        // Replace the height and width of the player here to match your UIWebView's  frame rect
        
        let embededHTML = "<html><body bgcolor=\"#000000\" style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){a.target.playVideo();}</script><iframe id='playerId' type='text/html' width='\(videoWebView.frame.size.width)' height='\(videoWebView.frame.size.height)' src='http://www.youtube.com/embed/\(videoID)?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'></body></html>"
        
        // Load your webView with the HTML we just set up
        videoWebView.loadHTMLString(embededHTML, baseURL: NSBundle.mainBundle().bundleURL)
        }
    }
    //MARK: JSON NSURLOPERASTION
    func startConnection(urlPath:String){
        
        
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
        
    }
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    var count:Int = 1
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        //        let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        if(count < 11){
        let jsonObject: [String:AnyObject]!
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data,
                                                                    options: NSJSONReadingOptions(rawValue: 0)) as! [String : AnyObject]
        } catch var error1 as NSError {
            err = error1
            jsonObject = nil
        }
        
        connection.cancel()
        print(jsonObject)
        let jsonPareseObj = JSONParsing()
        jsonPareseObj.categoryParse(jsonObject)
        }
                if(count<11 && count > 1)
        {
            //    connection.finalize()
              connection.cancel()
            data = NSMutableData()
            count += 1
            let urlPath: String = "http://tvannapurna.com/api/get_category_posts/?id=\(count)"
            startConnection(urlPath)
        }
                else{
                    count += 1
                      connection.cancel()
                     data = NSMutableData()
                    let urlPath: String = "http://tvannapurna.com/api/get_recent_posts/"
                    startConnection(urlPath)

                    
        }
        
      

        if(count == 11){
           connection.cancel()
              tableView.reloadData()
            busyIndicator.hidden = true;
 
        }
        
    }
    
    
}
