//
//  ViewController.swift
//  GanjiHomePage
//
//  Created by iOS on 15/5/14.
//  Copyright (c) 2015年 com.haitaolvyou. All rights reserved.
//

import UIKit
let indentifier = "Cell indentifier"
class ViewController: UITableViewController,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate {
    var headerView: UIView?
    var isShowing: Bool?
    var isLoading: Bool?
    var ego: EGORefreshTableHeaderView?
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowing = false
        isLoading = false

        tableView?.registerClass(UITableViewCell.self , forCellReuseIdentifier: indentifier)

        
        self.configTableHeaderView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func configTableHeaderView() {
        headerView = UIView(frame: CGRectMake(0, -150, 375, 300))
        headerView?.backgroundColor = UIColor.orangeColor()
        for var i = 0; i < 4; i++ {
            var touchView:TouchView = TouchView(frame:CGRectMake(0,CGFloat(i * 75), 375, 75), tag:100 + i)
            var line = UIView(frame: CGRectMake(0, 74, 375, 1))
            line.backgroundColor = UIColor.whiteColor()
            touchView.addSubview(line)
            headerView?.addSubview(touchView)
        }
        ego = EGORefreshTableHeaderView(frame: CGRectMake(0, -360, 375, 60))
        ego?.delegate = self
        self.tableView.addSubview(ego!)
        self.tableView.insertSubview(headerView!, atIndex:0 )
    }
    override  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView?.dequeueReusableCellWithIdentifier(indentifier, forIndexPath: indexPath) as! UITableViewCell
        var str = NSString(format: "中国结 %d", (indexPath.row + 1))
        cell.textLabel!.text = str as String
        return cell
    }
    
        //MARK: scrollView delegate

   override func scrollViewDidScroll(scrollView: UIScrollView) {
    println("\(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y > -300 {
            if isLoading == false {
                scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
            }
            headerView?.frame = CGRectMake(0, -150 + (scrollView.contentOffset.y ) / 2, 375, 300)
            
        }else {
            if isLoading == false {
                scrollView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
            }
            headerView?.frame = CGRectMake(0, -300, 375, 300)
        }
        ego?.egoRefreshScrollViewDidScroll(scrollView)
        

    }
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -150 {
            scrollView.setContentOffset(CGPointMake(0, -300), animated: true)
        }else {
            scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        }
        ego?.egoRefreshScrollViewDidEndDragging(scrollView)
    }

    //MARK:
    func egoRefreshTableHeaderDataSourceIsLoading(view: EGORefreshTableHeaderView!) -> Bool {
        return isLoading!
    }

    func egoRefreshTableHeaderDidTriggerRefresh(view: EGORefreshTableHeaderView!) {
        isLoading! = true
        self .refreshData()
    }
    func refreshData() {
        let minseconds = 2 * Double(NSEC_PER_SEC)
        let dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
        
        dispatch_after(dtime,dispatch_get_main_queue() , {
            self.ego?.egoRefreshScrollViewDataSourceDidFinishedLoading(self.tableView)
            
            self.isLoading! = false
        })




        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

