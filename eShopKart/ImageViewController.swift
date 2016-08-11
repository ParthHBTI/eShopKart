//
//  ImageViewController.swift
//  CategoryViewController
//
//  Created by mac on 01/08/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var cellDescriptors: NSMutableArray!
    var visibleRowsPerSection = [[Int]]()
    var checkFlag = false
    var productQnty: String!
    var productImageArr:AnyObject = []
    var getProductInfoDic = Dictionary<String,AnyObject>()
    var myOrders = NSArray()
    var i = 0
    var htmlString: String?
    var pageId: Int?
    var myCell = ProductDetailCell()
    var myCell1 = ProductDetailCell()
    var frame = CGRect()
    var bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "back_NavIcon"), style: .Plain, target: self, action: #selector(MyOrdersTableVC.backAction))
        self.navigationItem.setLeftBarButtonItem(backBarButtonItem, animated: true)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        productImageArr = getProductInfoDic["Gallery"] as! Array<AnyObject>
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if cellDescriptors != nil {
            return cellDescriptors!.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleRowsPerSection[section].count
    }
    
    override func viewWillAppear(animated: Bool) {
        configureTableView()
        loadCellDescriptors()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.registerNib(UINib(nibName: "ImageView", bundle: nil), forCellReuseIdentifier: "IdImageCellI")
        tableView.registerNib(UINib(nibName: "productDetails", bundle: nil), forCellReuseIdentifier: "IDProductDetail")
        tableView.registerNib(UINib(nibName: "KeyAndFeatures", bundle: nil), forCellReuseIdentifier: "IdKeyAndFeatures")
        tableView.registerNib(UINib(nibName: "Normal", bundle: nil), forCellReuseIdentifier: "IdNormalCell")
        tableView.registerNib(UINib(nibName: "SeeMore", bundle: nil), forCellReuseIdentifier: "SeeMoreID")
    }
    
    func loadCellDescriptors() {
        if let path = NSBundle.mainBundle().pathForResource("ProductDetails", ofType: "plist") {
            cellDescriptors = NSMutableArray(contentsOfFile: path)
            getIndicesOfVisibleRows()
            tableView.reloadData()
        }
    }
    
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        for currentSectionCells in cellDescriptors! {
            var visibleRows = [Int]()
            for row in 0...((currentSectionCells as! [[String: AnyObject]]).count - 1) {
                if currentSectionCells[row]["isVisible"] as! Bool == true {
                    visibleRows.append(row)
                }
            }
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(currentCellDescriptor["cellIdentifier"] as! String, forIndexPath: indexPath) as! ProductDetailCell
        if currentCellDescriptor["cellIdentifier"] as! String == "IdImageCellI" {
            let swipeRightOrange: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.slideToRightWithGestureRecognizer))
            swipeRightOrange.direction = .Right
            let swipeLeftOrange: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.slideToLeftWithGestureRecognizer))
            swipeLeftOrange.direction = .Left
            cell.imageViewPhoto.addGestureRecognizer(swipeRightOrange)
            cell.imageViewPhoto.addGestureRecognizer(swipeLeftOrange)
            cell.imageViewPhoto.userInteractionEnabled = true
            cell.pageViewCon.currentPage = indexPath.row
            cell.pageViewCon.numberOfPages = productImageArr.count
            let url = NSURL(string:(imageURL + (productImageArr[i]["images"] as? String)!))
            myCell.imageViewPhoto?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
            myCell = cell
        } else if currentCellDescriptor["cellIdentifier"] as! String == "IDProductDetail" {
            bool = true
            cell.productName?.text = getProductInfoDic["name"] as? String
            cell.productMat?.text = getProductInfoDic["material"] as? String
            cell.productQty.text = getProductInfoDic["quantity"] as? String
            cell.productDetail.text = getProductInfoDic["product_description"] as? String
            myCell1 = cell
            myCell1.productDetail.sizeToFit()
        } else if currentCellDescriptor["cellIdentifier"] as! String == "IdNormalCell" {
            
        } else if currentCellDescriptor["cellIdentifier"] as! String == "SeeMoreID" {
        } else if currentCellDescriptor["cellIdentifier"] as! String == "IdKeyAndFeatures" {
            webViewDidFinishLoad(cell.productWebView)
            cell.contentView.addSubview(cell.productWebView)
            let	url = NSString(format: "%@/1", contentURL) as String
            htmlString = url
            pageId = 2
            cell.productWebView.loadRequest(NSURLRequest(URL: NSURL(string: htmlString!)!))
            cell.contentView.addSubview(cell.productWebView)
        }
        return cell
    }
    
    func slideToRightWithGestureRecognizer(gestureRecognizer: UISwipeGestureRecognizer) {
        let imageCount = productImageArr.count
        myCell.imageViewPhoto = gestureRecognizer.view as! UIImageView
        if imageCount != i {
            if i == 0 {
                i = imageCount - 1
                myCell.pageViewCon.currentPage = i
                let url = NSURL(string:(imageURL + (productImageArr[i]["images"] as? String)!))
                myCell.imageViewPhoto?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
            } else {
                myCell.pageViewCon.currentPage = i - 1
                let url = NSURL(string:(imageURL + (productImageArr[i - 1]["images"] as? String)!))
                myCell.imageViewPhoto?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
                i -= 1
            }
        }
    }
    
    func slideToLeftWithGestureRecognizer(gestureRecognizer: UISwipeGestureRecognizer) {
        let imageCount = productImageArr.count
        myCell.imageViewPhoto = gestureRecognizer.view as! UIImageView
        if imageCount != i {
            if i == imageCount - 1 {
                i = 0
                myCell.pageViewCon.currentPage = i
                let url = NSURL(string:(imageURL + (productImageArr[i]["images"] as? String)!))
                myCell.imageViewPhoto?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
            } else {
                myCell.pageViewCon.currentPage = i + 1
                let url = NSURL(string:(imageURL + (productImageArr[i + 1]["images"] as? String)!))
                myCell.imageViewPhoto?.setImageWithURL(url!, placeholderImage: UIImage(named:"Kloudrac-Logo"))
                i += 1
            }
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.scrollView.scrollEnabled = false
        frame = webView.frame
        print(frame.height)
        frame.size.height = 1
        webView.frame = frame
        let fittingSize: CGSize = webView.sizeThatFits(CGSizeZero)
        frame.size = fittingSize
        webView.frame = frame
        print(frame.height)
        print(frame.origin.x)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let currentCellDescriptor = getCellDescriptorForIndexPath(indexPath)
        switch currentCellDescriptor["cellIdentifier"] as! String {
        case "IdImageCellI":
            return 260.0
            
        case "IDProductDetail":
            return 200.0
            
        case "IdNormalCell":
            return 80.0
            
        case "SeeMoreID":
            return 40.0
            
        default:
            return frame.height
        }
    }
    
    func getCellDescriptorForIndexPath(indexPath: NSIndexPath) -> [String: AnyObject]  {
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let descriptor = cellDescriptors!.objectAtIndex(indexPath.section).objectAtIndex(indexOfVisibleRow)
        return descriptor as! [String: AnyObject]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpandable"] as! Bool == true {
            var shouldExpandAndShowSubRows = false
            if cellDescriptors[indexPath.section][indexOfTappedRow]["isExpanded"] as! Bool == false {
                shouldExpandAndShowSubRows = true
            }
            cellDescriptors[indexPath.section][indexOfTappedRow].setValue(shouldExpandAndShowSubRows, forKey: "isExpanded")
            
            for i in (indexOfTappedRow + 1)...(indexOfTappedRow + (cellDescriptors[indexPath.section][indexOfTappedRow]["additionalRows"] as! Int)) {
                cellDescriptors[indexPath.section][i].setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
            }
        }
        getIndicesOfVisibleRows()
        tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    override func viewWillLayoutSubviews() {
        if bool {
            tableView.reloadData()
        }
    }
    
    func backAction() {
        for controller: UIViewController in self.navigationController!.viewControllers {
            if (controller is MyOrdersTableVC) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
}
