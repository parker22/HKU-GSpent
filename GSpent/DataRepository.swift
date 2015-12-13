//
//  DataRepository.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/2/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import Foundation
import UIKit
import Parse

class DataRepository {
    let personDatabase   = PersonDatabase()
    let bookDatabase     = BookDatabase()
    let tallyDatabase    = TallyDatabase()
    let categoryDatabase = CategoryDatabase()
    
    func getCategory() -> [Category]{
        return self.categoryDatabase.getCategory()
    }
    
    func getBooks() -> [Book]{
        return self.bookDatabase.getBooks()
    }
    
    // used in Tally: to get book list by user ID
    func getBooks(user: PFUser, tableView: UITableView, activity: String){
        self.bookDatabase.getUserBookList(user, tableView: tableView, activity: activity)}
    
    // used in Tally: parse u_id list to participent description string
    func getPersons() -> [Person]{return self.personDatabase.getPersons()}
    
    // used in Tally: to get tally by user ID and book ID
    func getBookTally(user: PFUser, b_id: Int, tableView: UITableView, activity: String){
        self.tallyDatabase.getBookTally(user, b_id: b_id, tableView: tableView, activity: activity)}
    
    // used in Tally: to convert participant string
    func getPartStr(raw_s: String) -> String { return self.personDatabase.getPartStr(raw_s) }
    
    // used in Add Spent: to add a new spent(tally)
    func addSpent(t_brief: String, user: PFObject, u_id: Int, book: PFObject, b_id: Int, t_pic: UIImage?, t_time: NSDate, t_type: Int, t_amount: Double) {
        self.tallyDatabase.addTally(t_brief, user: user, u_id: u_id, book: book, b_id: b_id, t_pic: t_pic, t_time: t_time, t_type: t_type, t_amount: t_amount)
    }
}

class PersonDatabase {
    let peopleData = [
        Person(name: "Donald",    pid: 0,   avatar: UIImage(named: "user1")),  Person(name: "Edison", pid: 25,   avatar: UIImage(named: "user6")),
        Person(name: "August",    pid: 1,   avatar: UIImage(named: "user5")),  Person(name: "Aaron",  pid: 26,   avatar: UIImage(named: "user9")),
        Person(name: "Benson",    pid: 2,   avatar: UIImage(named: "user4")),  Person(name: "Charles",pid: 27,   avatar: UIImage(named: "user4")),
        Person(name: "Arnold",    pid: 3,   avatar: UIImage(named: "user3")),  Person(name: "Jesse",  pid: 28,   avatar: UIImage(named: "user6")),
        Person(name: "Apollo",    pid: 4,   avatar: UIImage(named: "user2")),  Person(name: "Isaac",  pid: 29,   avatar: UIImage(named: "user7")),
        Person(name: "Christophe",pid: 5,   avatar: UIImage(named: "user1")),  Person(name: "Owen",   pid: 30,   avatar: UIImage(named: "user8")),
        Person(name: "Darwin",    pid: 6,   avatar: UIImage(named: "user1")),  Person(name: "Matthew",pid: 31,   avatar: UIImage(named: "user1")),
        Person(name: "Nicholas",  pid: 7,   avatar: UIImage(named: "user1")),  Person(name: "Wisky",  pid: 32,   avatar: UIImage(named: "user1")),
        Person(name: "Randy",     pid: 8,   avatar: UIImage(named: "user1")),  Person(name: "Adrian", pid: 33,   avatar: UIImage(named: "user1")),
        Person(name: "Brown",     pid: 9,   avatar: UIImage(named: "user1")),  Person(name: "Lee",    pid: 34,   avatar: UIImage(named: "user1")),
        Person(name: "Peter",     pid: 10,   avatar: UIImage(named: "user1")), Person(name: "Gafield",pid: 35,   avatar: UIImage(named: "user1")),
        Person(name: "Jason",     pid: 11,   avatar: UIImage(named: "user1")), Person(name: "Solomon",pid: 36,   avatar: UIImage(named: "user1")),
        Person(name: "Marcus",    pid: 12,   avatar: UIImage(named: "user1")), Person(name: "Robert", pid: 37,   avatar: UIImage(named: "user1")),
        Person(name: "Elijah",    pid: 13,   avatar: UIImage(named: "user1")), Person(name: "Victor", pid: 38,   avatar: UIImage(named: "user1")),
        Person(name: "Anthony",   pid: 14,   avatar: UIImage(named: "user1")), Person(name: "Terence",pid: 39,   avatar: UIImage(named: "user1")),
        Person(name: "Parker",    pid: 15,   avatar: UIImage(named: "user1")), Person(name: "Wesley", pid: 40,   avatar: UIImage(named: "user1")),
        Person(name: "Cody",      pid: 16,   avatar: UIImage(named: "user1")), Person(name: "Zachary",pid: 41,   avatar: UIImage(named: "user1")),
        Person(name: "Howard",    pid: 17,   avatar: UIImage(named: "user1")), Person(name: "Abraham",pid: 42,   avatar: UIImage(named: "user1")),
        Person(name: "Samuel",    pid: 18,   avatar: UIImage(named: "user1")), Person(name: "Harry",  pid: 43,   avatar: UIImage(named: "user1")),
        Person(name: "Caspar",    pid: 19,   avatar: UIImage(named: "user1")), Person(name: "Bruce",  pid: 44,   avatar: UIImage(named: "user1")),
        Person(name: "Quentin",   pid: 20,   avatar: UIImage(named: "user1")), Person(name: "Eugene", pid: 45,   avatar: UIImage(named: "user1")),
        Person(name: "Thomas",    pid: 21,   avatar: UIImage(named: "user1")), Person(name: "Leslie", pid: 46,   avatar: UIImage(named: "user1")),
        Person(name: "Laurence",  pid: 22,   avatar: UIImage(named: "user1")), Person(name: "Bryan",  pid: 47,   avatar: UIImage(named: "user1")),
        Person(name: "Abelard",   pid: 23,   avatar: UIImage(named: "user1")), Person(name: "Joshua", pid: 48,   avatar: UIImage(named: "user1")),
        Person(name: "George",    pid: 24,   avatar: UIImage(named: "user1")), Person(name: "Dylan",  pid: 49,   avatar: UIImage(named: "user1")),
    ]
    
    func getName(pid: String) -> String? {
        
        for person in peopleData{if person.pid == Int(pid) {return String(person.name)}}
        return nil
    }
    
    func getPartStr(raw_s: String) -> String {
        var part_r = raw_s.componentsSeparatedByString(";")
        var part_s: String!
        if     (part_r.count == 1){if(part_r[0] == "-1"){ part_s = "All people."} else {part_s = "\(getName(part_r[0])!)."}}
        else if(part_r.count == 2){part_s = "\(getName(part_r[0])!), \(getName(part_r[1])!)."}
        else if(part_r.count >  2){part_s = "\(getName(part_r[0])!), \(getName(part_r[1])!), and other \(part_r.count-2) people."}
        else   {part_s = ""}
        return part_s
    }
    
    
    func getStrMates(raw_s: [String]) -> String {
        var part_s: String!
        if     (raw_s.count == 1) {part_s = "\(raw_s)."}
        else if(raw_s.count == 2){part_s = "\(raw_s[0]), \(raw_s[1])."}
        else if(raw_s.count >  2){part_s = "\(raw_s[0]), \(raw_s[1]), and other \(raw_s.count-2) people."}
        else   {part_s = ""}
        return part_s
    }
    
    func getPersons() -> [Person]{
        return self.peopleData
    }
    
    // use userSignup first and then use the addBooks
    func userSignup(){
        for tmp in peopleData {
            let user = PFUser()
            user.setObject(tmp.pid, forKey: "u_id")
            user.username = tmp.name
            user.password = "666666"
            user.setObject(PFFile(data:UIImagePNGRepresentation(tmp.avatar!)!)!, forKey: "u_icon")
            user.setObject([PFObject](), forKey: "u_books")
            
            user.signUpInBackgroundWithBlock { (success, error) -> Void in
                if error == nil {print("Well done bro! Amazing!")}
                else            {print("You suck.")}
            }
        }
    }
    
    func updateBooks(){
        let bookDatabase = BookDatabase()
        for tmp in peopleData {
            do {try PFUser.logInWithUsername(tmp.name, password:"666666")
                if let currentUser = PFUser.currentUser(){
                    let books = bookDatabase.getBooks(currentUser["u_id"].integerValue)
                    currentUser["u_books"] = books
                    do    {try currentUser.save()}
                    catch {print("Master indicated me to do nothing.")}
                }
                PFUser.logOut()
            }
            catch {print("Master indicated me to do nothing.")}
        }
    }
}

class CategoryDatabase {
    let categoryData=[
        Category(name: "Tran", cid: 1, icon: UIImage(named: "transportation")!),
        Category(name: "Shop", cid: 2, icon: UIImage(named: "shopping")!),
        Category(name: "Film", cid: 3, icon: UIImage(named: "movie")!),
        Category(name: "Fit",  cid: 4, icon: UIImage(named: "fitness")!),
        Category(name: "Food", cid: 5, icon: UIImage(named: "food")!),
        Category(name: "Inn",  cid: 6, icon: UIImage(named: "hotel")!),
        Category(name: "Rent", cid: 7, icon: UIImage(named: "rent")!),
        Category(name: "Baby", cid: 8, icon: UIImage(named: "baby")!),
        Category(name: "Pet",  cid: 9, icon: UIImage(named: "pet")!),
        Category(name: "Mend", cid: 10, icon: UIImage(named: "auto_repair")!),
        Category(name: "Edu",  cid: 11, icon: UIImage(named: "education")!),
        Category(name: "Pub",  cid: 12, icon: UIImage(named: "bar")!),
        Category(name: "Drug", cid: 13, icon: UIImage(named: "doctor")!),
        Category(name: "Park", cid: 14, icon: UIImage(named: "parking")!),
    ]
    func getCategory() -> [Category]{
        return self.categoryData
    }
    
    func insertCategory(){
        for tmp in categoryData {
            let cate = PFObject(className: "Category")
            cate.setObject(tmp.cid, forKey: "c_id")
            cate.setObject(tmp.name, forKey: "c_name")
            cate.setObject(PFFile(data:UIImagePNGRepresentation(tmp.icon)!)!, forKey: "c_icon")
            cate.saveInBackgroundWithBlock { (success, error) -> Void in
                if error == nil {print("Well done bro! Amazing!")}
                else            {print("You suck.")}
            }
        }
    }
}

class BookDatabase {
    let bookData = [
        Book(bid: -1, icon: UIImage(named: "bookIconSample00"), name: "All books", part: "-1"),
        Book(bid: 0,  icon: UIImage(named: "bookIconSample01"), name: "My family", part: "22;0;1;2;3"),
        Book(bid: 1,  icon: UIImage(named: "bookIconSample02"), name: "Happy hiking", part: "22;4;5;6;7;8;9;10;11;12;13;14;15;16"),
        Book(bid: 2,  icon: UIImage(named: "bookIconSample03"), name: "Ladies party", part: "22;17;18;19;20;21"),
        Book(bid: 3,  icon: UIImage(named: "bookIconSample04"), name: "7-days Sanya short trip", part: "22;23;24"),
        Book(bid: 4,  icon: UIImage(named: "bookIconSample05"), name: "Pilgrimage to Guanyin", part: "22;25;26"),
        Book(bid: 5,  icon: UIImage(named: "bookIconSample06"), name: "TFBoys hardcore-fans Republic", part: "22;27;28;29;30;31;32;33"),
        Book(bid: 6,  icon: UIImage(named: "bookIconSample07"), name: "Movies watching plan", part: "22;34;35;36;37;38;39"),
        Book(bid: 7,  icon: UIImage(named: "bookIconSample08"), name: "Picnic prepare", part: "22;40;41;42;43"),
        Book(bid: 8,  icon: UIImage(named: "bookIconSample09"), name: "HKU 6A Flat", part: "22;45;46;47;48;49"),
        Book(bid: 9,  icon: UIImage(named: "bookIconSample10"), name: "GSpent International, Ltd.", part: "15;22;26;32")
    ]
    let bookIDs = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    func getUserBookList(user: PFUser, tableView: UITableView, activity: String){
        let userQuery = PFQuery(className: "_User")
        userQuery.whereKey("objectId", equalTo: user.objectId!)
        userQuery.includeKey("u_books")
        userQuery.includeKey("u_books.b_participant")
        
        userQuery.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil || object == nil { print("Find user error.")}
            else {
                //                var bookList = [self.bookData[0]]
                //                print(object!["u_books"])
                //                for bItem in object!["u_books"] as! [PFObject]{
                //                    print (bItem["b_participant"])
                //                }
                //                    let b_id = bItem["b_id"].integerValue!
                //                    let b_name = bItem["b_name"] as! String
                //                    let b_part: String
                //                    let b_icon = UIImage()
                //
                //                    var p_ids = [String]()
                //                    for pItem in bItem["b_participant"] as! [PFObject]{p_ids.append(String(pItem["u_id"].integerValue!))}
                //                    b_part = p_ids.joinWithSeparator(";")
                //
                //                    bookList.append(Book(bid: b_id, icon: b_icon, name: b_name, part: b_part))
                //                }
                switch(activity){
                case "PersonalTally" :
                    let allBook = PFObject(className: "Book")
                    allBook["b_name"] = "All books"
                    allBook["b_icon"] = PFFile(data:UIImagePNGRepresentation(UIImage(named: "bookIconSample00")!)!)
                    allBook["b_id"]   = -1
                    let allUser = PFUser()
                    allUser["username"] = "All people"
                    allBook["b_participant"] = [allUser]
                    PersonalTallyViewController.books = [PFObject]()
                    PersonalTallyViewController.books += [allBook]
                    print(object!["u_books"])
                    PersonalTallyViewController.books += object!["u_books"] as! [PFObject]
                    tableView.reloadData()
                    break
                case "AddSpent" :
                    SpentBookSelectionTableViewController.books = object!["u_books"] as! [PFObject]
                    tableView.reloadData()
                    break
                default: break;
                }
            }
        }
    }
    
    func getBooks() -> [Book]{
        return self.bookData
    }
    
    func getBookPFObjects(user: PFUser, tableView: UITableView, activity: String){
        let bookQuery = PFQuery(className: "Book")
        bookQuery.whereKey("b_participant", containsAllObjectsInArray: [user])
        bookQuery.includeKey("b_participant")
        bookQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                switch(activity){
                case "BookList":
                    let relationQuery = PFQuery(className: "User_Book_Relation")
                    relationQuery.whereKey("u_id", equalTo: user.objectId!)
                    relationQuery.findObjectsInBackgroundWithBlock({
                        (relations: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            BookTableViewController.bookData = objects!
                            BookTableViewController.relationData = relations!
                            
                            tableView.reloadData()
                        }
                        
                    })
                    break
                default: break;}
            } else { print("Error: \(error!) \(error!.userInfo)") }
        }
    }
    
    func getBooks(p_id: Int) -> [PFObject]{
        var books = [PFObject]()
        var b_ids = [Int]()
        for book in bookData {
            let parts = book.part.componentsSeparatedByString(";")
            if parts.contains(String(p_id)) { b_ids.append(book.bid) }
        }
        let bookQuery = PFQuery(className: "Book")
        bookQuery.whereKey("b_id", containedIn: b_ids)
        do { books += try bookQuery.findObjects() }
        catch {print("Master indicated me to do nothing.")}
        
        return books
    }
    
    func insertBook(){
        for(var i = 1; i < bookData.count; i++){
            let tmp = bookData[i]
            
            // get user object array
            var b_part = [PFObject]()
            var p_ids = [Int]()
            print(tmp.part.componentsSeparatedByString(";"))
            for p_id_string in tmp.part.componentsSeparatedByString(";"){ p_ids.append(Int(p_id_string)!) }
            let query = PFQuery(className: "_User")
            query.whereKey("u_id", containedIn: p_ids)
            do { b_part += try query.findObjects() }
            catch {print("Master indicated me to do nothing.")}
            
            /* A simple bad solution
            for p_id in p_ids{
            let query = PFQuery(className: "_User")
            query.whereKey("u_id", equalTo: Int(p_id)!)
            do { b_part += try query.findObjects() }
            catch {print("Master indicated me to do nothing.")}
            }*/
            
            // generate a new book object
            let book = PFObject(className: "Book")
            book["b_id"] = tmp.bid
            book["b_name"] = tmp.name
            book["b_icon"] = PFFile(data:UIImagePNGRepresentation(tmp.icon!)!)!
            book["b_participant"] = b_part
            
            // save the object
            book.saveInBackgroundWithBlock { (success, error) -> Void in
                if error == nil {print("Well done bro! Amazing!")}
                else            {print("You suck.")}
            }
        }
    }
    
    func updateUserbooks(){
        for(var i = 1; i < bookData.count; i++){
            let tmp = bookData[i]
            var book: PFObject
            let bookQuery = PFQuery(className: "Book")
            bookQuery.whereKey("b_id", equalTo: tmp.bid)
            do { book = try bookQuery.findObjects()[0] }
            catch {print("Master indicated me to do nothing."); return}
            
            var users = [PFObject]()
            var p_ids = [Int]()
            for p_id_string in tmp.part.componentsSeparatedByString(";"){ p_ids.append(Int(p_id_string)!) }
            let userQuery = PFQuery(className: "_User")
            userQuery.whereKey("u_id", containedIn: p_ids)
            do { users += try userQuery.findObjects() }
            catch {print("Master indicated me to do nothing.")}
            
            for user in users{
                user["u_books"] = [PFObject]()
                user.saveInBackgroundWithBlock { (success, error) -> Void in
                    if error == nil {print("Well done bro! Amazing!")}
                    else            {print("You suck.")}
                }
            }
        }
    }
}

class TallyDatabase {
    //    let tallyData = [
    //        Tally(bid: 0, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "The Three-Body Problem",     amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "is a science",               amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "fiction",                    amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "novel",                      amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "by the Chinese",             amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "writer",                     amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "Liu Cixin",                  amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "It is the first",            amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "of a trilogy",               amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "titled",                     amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "Remembrance of Earth’s Past",amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "but",                        amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "Chinese readers",            amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "generally refer ",           amount: rAmount()),
    //        Tally(bid: 0, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "to the series",              amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "by the title",               amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "of the first novel",         amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "The title",                  amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "refers to",                  amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "the three-body",             amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "problem",                    amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "in orbital",                 amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "mechanics",                  amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "The work was",               amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "serialized",                 amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "in",                         amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Science Fiction World",      amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "in 2006",                    amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "published",                  amount: rAmount()),
    //        Tally(bid: 1, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "as a book",                  amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "in 2008",                    amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "and",                        amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "became",                     amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "one of",                     amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "the most ",                  amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "popular",                    amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "science fiction",            amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "novels",                     amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "in China",                   amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "It received",                amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "the Chinese",                amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Science",                    amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "Fiction",                    amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "Galaxy",                     amount: rAmount()),
    //        Tally(bid: 2, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "in 2006",                    amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "A film",                     amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "adaptation",                 amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "of the ",                    amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "same name",                  amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "is scheduled",               amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "for release",                amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "in July",                    amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "2016",                       amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "An English",                 amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "translation",                amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "by Ken Liu",                 amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "was published",              amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "by Tor Books",               amount: rAmount()),
    //        Tally(bid: 3, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "in 2014",                    amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "It won",                     amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "the 2015",                   amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "Hugo",                       amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "for",                        amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "Best",                       amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "Novel",                      amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "and was",                    amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "nominated",                  amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "for the 2014",               amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "Nebula",                     amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "for",                        amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "Best",                       amount: rAmount()),
    //        Tally(bid: 4, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "Novel",                      amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "The Three-Body Problem",     amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "is a science",               amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "fiction",                    amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "novel",                      amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "by the Chinese",             amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "writer",                     amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "Liu Cixin",                  amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "It is the first",            amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "of a trilogy",               amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "titled",                     amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "Remembrance of Earth’s Past",amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "but",                        amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "Chinese readers",            amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "generally refer ",           amount: rAmount()),
    //        Tally(bid: 5, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "to the series",              amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "by the title",               amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "of the first novel",         amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "The title",                  amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "refers to",                  amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "the three-body",             amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "problem",                    amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "in orbital",                 amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "mechanics",                  amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "The work was",               amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "serialized",                 amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "in",                         amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Science Fiction World",      amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "in 2006",                    amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "published",                  amount: rAmount()),
    //        Tally(bid: 6, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "as a book",                  amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "in 2008",                    amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "and",                        amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "became",                     amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "one of",                     amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "the most ",                  amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "popular",                    amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "science fiction",            amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "novels",                     amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "in China",                   amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "It received",                amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "the Chinese",                amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Science",                    amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "Fiction",                    amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "Galaxy",                     amount: rAmount()),
    //        Tally(bid: 7, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "in 2006",                    amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "A film",                     amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "adaptation",                 amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "of the ",                    amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "same name",                  amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "is scheduled",               amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "for release",                amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "in July",                    amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "2016",                       amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "An English",                 amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "translation",                amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "by Ken Liu",                 amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "was published",              amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "by Tor Books",               amount: rAmount()),
    //        Tally(bid: 8, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "in 2014",                    amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 0,  time: "2015-11-20 07:31", brief: "It won",                     amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 1,  time: "2015-11-21 08:32", brief: "the 2015",                   amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 2,  time: "2015-11-22 09:27", brief: "Hugo",                       amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 3,  time: "2015-11-23 06:11", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 4,  time: "2015-11-24 13:56", brief: "for",                        amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 5,  time: "2015-11-25 12:29", brief: "Best",                       amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 6,  time: "2015-11-26 14:37", brief: "Novel",                      amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 7,  time: "2015-11-27 18:30", brief: "and was",                    amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 8,  time: "2015-11-28 22:10", brief: "nominated",                  amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 9,  time: "2015-11-29 23:33", brief: "for the 2014",               amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 10, time: "2015-11-30 19:17", brief: "Nebula",                     amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 11, time: "2015-12-01 08:25", brief: "Award",                      amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 12, time: "2015-12-02 09:30", brief: "for",                        amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 13, time: "2015-12-03 11:25", brief: "Best",                       amount: rAmount()),
    //        Tally(bid: 9, uid: 22, tid: 14, time: "2015-12-04 16:43", brief: "Novel",                      amount: rAmount())
    //    ]
    
    func getBookTally(user: PFUser, b_id: Int, tableView: UITableView, activity: String){
        var tallys = [Tally]()
        let tallyQuery = PFQuery(className: "Tally")
        if user["u_id"].integerValue != -1 {tallyQuery.whereKey("user", equalTo: user)}
        if b_id != -1 {tallyQuery.whereKey("b_id", equalTo: b_id)}
        
        tallyQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // Do something with the found objects
                if let objects = objects {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    
                    for tItem in objects {
                        let bid     = tItem["b_id"].integerValue
                        let tid     = 001//tItem["t_id"].integerValue
                        let uid     = tItem["u_id"].integerValue
                        let time    = dateFormatter.stringFromDate(tItem["t_time"] as! NSDate)
                        let brief   = tItem["t_brief"] as! String
                        let amount  = tItem["t_amount"].doubleValue
                        tallys.append(Tally(bid: bid, uid: uid, tid: tid, time: time, brief: brief, amount: amount))
                    }
                    
                    switch(activity){
                    case "PersonalTally": PersonalTallyViewController.tallys = tallys; tableView.reloadData(); break;
                    default: break;
                    }
                }
            }
            else { print("Error: \(error!) \(error!.userInfo)") }
        }
    }
    
    
    func getBookDetailTally(user: PFUser, book: PFObject, tableView: UITableView, activity: String){
        let tallyQuery = PFQuery(className: "Tally")
        //        tallyQuery.whereKey("user", equalTo: user)
        tallyQuery.whereKey("book", equalTo: book)
        
        tallyQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // Do something with the found objects
                if let objects = objects {
                    //                    let dateFormatter = NSDateFormatter()
                    //                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    //
                    //                    for tItem in objects {
                    //                        let bid     = tItem["b_id"].integerValue
                    //                        let tid     = tItem["t_id"].integerValue
                    //                        let uid     = tItem["u_id"].integerValue
                    //                        let time    = dateFormatter.stringFromDate(tItem["t_time"] as! NSDate)
                    //                        let brief   = tItem["t_brief"] as! String
                    //                        let amount  = tItem["t_amount"].doubleValue
                    //                        tallys.append(Tally(bid: bid, uid: uid, tid: tid, time: time, brief: brief, amount: amount))
                    //                    }
                    
                    switch(activity){
                    case "getBookDetailTally":
                        BookDetailViewController.tallys = objects
                        var ta = 0.0
                        for object in objects{
                            ta +=  object["t_amount"].doubleValue
                        }
                        BookDetailViewController.totalAmount = ta
                        tableView.reloadData()
                        
                        break
                    default: break;
                    }
                }
            }
            else { print("Error: \(error!) \(error!.userInfo)") }
        }
    }
    /*
    func insertTally(){
    let user_id = 22
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let user: PFObject
    let userQuery = PFQuery(className: "_User")
    userQuery.whereKey("u_id", equalTo: user_id)
    do { user = try userQuery.findObjects()[0] }
    catch {print("Master indicated me to do nothing."); return;}
    
    for tmp in tallyData {
    let tally = PFObject(className: "Tally")
    tally["t_id"]     = tmp.tid
    tally["t_brief"]  = tmp.brief
    tally["t_time"]   = dateFormatter.dateFromString(tmp.time)
    tally["t_type"]   = rTallyType()
    tally["b_id"]     = tmp.bid
    tally["u_id"]     = user_id
    tally["t_amount"] = tmp.amount
    
    let book: PFObject
    let bookQuery = PFQuery(className: "Book")
    bookQuery.whereKey("b_id", equalTo: tmp.bid)
    do { book = try bookQuery.findObjects()[0] }
    catch {print("Master indicated me to do nothing."); return;}
    tally["book"]     = book
    tally["user"]     = user
    
    tally.saveInBackgroundWithBlock { (success, error) -> Void in
    if error == nil {print("Well done bro! Amazing!")}
    else            {print("You suck.")}
    }
    }
    }
    */
    
    func addTally(t_brief: String, user: PFObject, u_id: Int, book: PFObject, b_id: Int, t_pic: UIImage?, t_time: NSDate, t_type: Int, t_amount: Double){
        let tally = PFObject(className: "Tally")
        tally["t_brief"]  = t_brief
        tally["user"]     = user
        tally["u_id"]     = u_id
        tally["book"]     = book
        tally["b_id"]     = b_id
        tally["t_time"]   = t_time
        tally["t_type"]   = t_type
        tally["t_amount"] = t_amount
        if let t_pic = t_pic { tally["t_pic"] = PFFile(data:UIImageJPEGRepresentation((t_pic), 0.5)!) }
        
        tally.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {print("Well done bro! Amazing!")}
            else            {print("You suck.")}
        }
    }
}

func rAmount() -> Double {
    let max = 100000
    let min = 0
    return Double(arc4random_uniform(UInt32(max-min)) + UInt32(min))/pow(10.0, 2)
}

func rTallyType() -> Int {
    let max = 14
    let min = 1
    return Int(arc4random_uniform(UInt32(max-min)) + UInt32(min))
}

struct Book {
    var bid : Int
    var icon: UIImage?
    var name: String
    var part: String
}

struct Tally {
    var bid   : Int
    var uid   : Int
    var tid   : Int
    var time  : String
    var brief : String
    var amount: Double
}

struct Person {
    var name: String
    var pid : Int
    var avatar : UIImage?
    
    static func randomPerson() -> Person{
        let nameList:[String]=["Adam","Bob","Claudia","David","Eva"]
        let nameCount = Int(arc4random_uniform(UInt32(nameList.count)))
        let newPerson:Person=self.init(name: nameList[nameCount], pid: 2, avatar: UIImage(named: "user1"))
        return newPerson
    }
    
    static func isSame(person1:Person, and person2:Person) -> Bool{
        if (person1.name == person2.name) && (person1.pid==person2.pid){
            return true
        }
        return false
    }
    
}

struct Category {
    var name: String
    var cid : Int
    var icon : UIImage
}