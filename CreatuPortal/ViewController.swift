//
//  ViewController.swift
//  Paging_Swift
//
//  Created by Olga Dalton on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    var titleNews:[String] = ["इराकको मोसुल बाँध फुट्ने खतरा, १५ लाख मानिसको ज्यान जोखिममा","२०१६ मा नेपालको अर्थतन्त्रले गति लिने राष्ट्रसंघको विश्वास","सय किलोवाट सोलार बिजुली केन्द्रीय प्रसारण लाइनमा जोडिँदै","आज घोडेजात्रा मनाइँदै","यस बर्षको एस.एल.सी परिक्षा आजबाट शुरु पहिलो दिन अनिवार्य अंग्रेजीको परीक्षा हुँदै"]
    var imgI:[UIImage] = [UIImage(named: "n1.jpg")!,UIImage(named: "n2.jpg")!,UIImage(named: "n3.jpg")!,UIImage(named: "n4.jpg")!,UIImage(named: "n5.jpg")!]
    // Initialize it right away here
    private let contentImages = ["n1.jpg",
        "n2.jpg",
        "n3.jpg",
        "n4.jpg","n5.jpg","n5.jpg"];
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as! [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
     //   let appearance = UIPageControl.appearance()
      //  appearance.pageIndicatorTintColor = UIColor.grayColor()
      //  appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
      //  appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
          //  pageItemController.img = imgI[itemIndex]
            pageItemController.imageName = contentImages[itemIndex]
            pageItemController.tle = titleNews[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

