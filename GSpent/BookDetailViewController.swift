//
//  BookDetailViewController.swift
//  GSpent
//
//  Created by Jiahe Liu on 2/12/15.
//  Copyright © 2015年 LIU Jiahe. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var bookMemberCV: UICollectionView!
    @IBOutlet weak var bookMemberSelected: UIImageView!
    
    @IBOutlet weak var bookTallyTV: UITableView!
    
    var members = [Person]()
    var dataRepository = DataRepository()
    
    let bookMemberCellIdentifier = "bookMemberCell"
    let bookTallyCellIdentifier = "bookTallyCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        bookMemberCV.delegate = self
        bookMemberCV.dataSource = self
        bookTallyTV.delegate = self
        bookTallyTV.dataSource = self
        // Do any additional setup after loading the view.
        members = self.dataRepository.getPersons()
        bookMemberSelected.layer.cornerRadius = bookMemberSelected.frame.size.width/2
        bookMemberSelected.clipsToBounds = true
        bookMemberSelected.image = members[0].avatar
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = bookMemberCV.dequeueReusableCellWithReuseIdentifier(bookMemberCellIdentifier, forIndexPath: indexPath) as! bookMemberCollectionViewCell
        cell.bookMemberAvatar.image = members[indexPath.row].avatar
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        bookMemberSelected.image = members[indexPath.row].avatar
    }
    
    
    
    //the tabelview displaying detailed tally list for each person
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:BookTallyTableViewCell = bookTallyTV.dequeueReusableCellWithIdentifier(bookTallyCellIdentifier, forIndexPath: indexPath) as! BookTallyTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
