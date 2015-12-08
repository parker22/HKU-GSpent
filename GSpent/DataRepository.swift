//
//  DataRepository.swift
//  GSpent
//
//  Created by HUI ZHAN on 12/2/15.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import Foundation
import UIKit

class DataRepository {
    let personDatabase = PersonDatabase()
    let bookDatabase   = BookDatabase()
    let tallyDatabase  = TallyDatabase()
    let categoryDatabase = CategoryDatabase()
    
    func getCategory() -> [Category]{
        return self.categoryDatabase.getCategory()
    }
    func getBooks() -> [Book]{
        return self.bookDatabase.getBooks()
    }
    
    func getPersons() -> [Person]{
        return self.personDatabase.getPersons()
    }
    
    func getBookTally(bid: Int) -> [Tally]?{
        if self.bookDatabase.bookIDs.contains(bid){return self.tallyDatabase.getBookTally(bid)}
        else {return nil}
    }
    
    func getPartStr(raw_s: String) -> String {
        return self.personDatabase.getPartStr(raw_s)
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
    
    func getPersons() -> [Person]{
        return self.peopleData
    }
}
class CategoryDatabase {
    let categoryData=[
        Category(name: "交通", cid: 1, icon: UIImage(named: "transportation")!),
        Category(name: "购物", cid: 2, icon: UIImage(named: "shopping")!),
        Category(name: "娱乐", cid: 3, icon: UIImage(named: "movie")!),
        Category(name: "健身", cid: 4, icon: UIImage(named: "fitness")!),
        Category(name: "餐饮", cid: 5, icon: UIImage(named: "food")!),
        Category(name: "酒店", cid: 6, icon: UIImage(named: "hotel")!),
        Category(name: "房租", cid: 7, icon: UIImage(named: "rent")!),
        Category(name: "宝贝", cid: 8, icon: UIImage(named: "baby")!),
        Category(name: "宠物", cid: 9, icon: UIImage(named: "pet")!),
        Category(name: "修车", cid: 10, icon: UIImage(named: "auto_repair")!),
        Category(name: "教育", cid: 11, icon: UIImage(named: "education")!),
        Category(name: "酒吧", cid: 12, icon: UIImage(named: "bar")!),
        Category(name: "医疗", cid: 13, icon: UIImage(named: "doctor")!),
        Category(name: "停车", cid: 14, icon: UIImage(named: "parking")!),
    ]
    func getCategory() -> [Category]{
        return self.categoryData
    }
}

class BookDatabase {
    let bookData = [
        Book(bid: -1, icon: UIImage(named: "bookIconSample00"), name: "All books", part: "-1"),
        Book(bid: 0,  icon: UIImage(named: "bookIconSample01"), name: "My family", part: "0;1;2;3"),
        Book(bid: 1,  icon: UIImage(named: "bookIconSample02"), name: "Happy hiking", part: "4;5;6;7;8;9;10;11;12;13;14;15;16"),
        Book(bid: 2,  icon: UIImage(named: "bookIconSample03"), name: "Ladies party", part: "17;18;19;20;21"),
        Book(bid: 3,  icon: UIImage(named: "bookIconSample04"), name: "7-days Sanya shirt trip", part: "22;23;24"),
        Book(bid: 4,  icon: UIImage(named: "bookIconSample05"), name: "Pilgrimage to Guanyin", part: "25;26"),
        Book(bid: 5,  icon: UIImage(named: "bookIconSample06"), name: "TFBoys hardcore-fans Republic", part: "27;28;29;30;31;32;33"),
        Book(bid: 6,  icon: UIImage(named: "bookIconSample07"), name: "Movies watching plan", part: "34;35;36;37;38;39"),
        Book(bid: 7,  icon: UIImage(named: "bookIconSample08"), name: "Picnic prepare", part: "40;41;42;43"),
        Book(bid: 8,  icon: UIImage(named: "bookIconSample09"), name: "HKU 6A Flat", part: "45;46;47;48"),
        Book(bid: 9,  icon: UIImage(named: "bookIconSample10"), name: "GSpent International, Ltd.", part: "15;22;26;32")
    ]
    let bookIDs = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    func getBooks() -> [Book]{
        return self.bookData
    }
}

class TallyDatabase {
    let tallyData = [
        Tally(bid: 0, tid: 0,  time: "2015-11-20 07:31", brief: "The Three-Body Problem",     amount: rAmount()),
        Tally(bid: 0, tid: 1,  time: "2015-11-21 08:32", brief: "is a science",               amount: rAmount()),
        Tally(bid: 0, tid: 2,  time: "2015-11-22 09:27", brief: "fiction",                    amount: rAmount()),
        Tally(bid: 0, tid: 3,  time: "2015-11-23 06:11", brief: "novel",                      amount: rAmount()),
        Tally(bid: 0, tid: 4,  time: "2015-11-24 13:56", brief: "by the Chinese",             amount: rAmount()),
        Tally(bid: 0, tid: 5,  time: "2015-11-25 12:29", brief: "writer",                     amount: rAmount()),
        Tally(bid: 0, tid: 6,  time: "2015-11-26 14:37", brief: "Liu Cixin",                  amount: rAmount()),
        Tally(bid: 0, tid: 7,  time: "2015-11-27 18:30", brief: "It is the first",            amount: rAmount()),
        Tally(bid: 0, tid: 8,  time: "2015-11-28 22:10", brief: "of a trilogy",               amount: rAmount()),
        Tally(bid: 0, tid: 9,  time: "2015-11-29 23:33", brief: "titled",                     amount: rAmount()),
        Tally(bid: 0, tid: 10, time: "2015-11-30 19:17", brief: "Remembrance of Earth’s Past",amount: rAmount()),
        Tally(bid: 0, tid: 11, time: "2015-12-01 08:25", brief: "but",                        amount: rAmount()),
        Tally(bid: 0, tid: 12, time: "2015-12-02 09:30", brief: "Chinese readers",            amount: rAmount()),
        Tally(bid: 0, tid: 13, time: "2015-12-03 11:25", brief: "generally refer ",           amount: rAmount()),
        Tally(bid: 0, tid: 14, time: "2015-12-04 16:43", brief: "to the series",              amount: rAmount()),
        Tally(bid: 1, tid: 0,  time: "2015-11-20 07:31", brief: "by the title",               amount: rAmount()),
        Tally(bid: 1, tid: 1,  time: "2015-11-21 08:32", brief: "of the first novel",         amount: rAmount()),
        Tally(bid: 1, tid: 2,  time: "2015-11-22 09:27", brief: "The title",                  amount: rAmount()),
        Tally(bid: 1, tid: 3,  time: "2015-11-23 06:11", brief: "refers to",                  amount: rAmount()),
        Tally(bid: 1, tid: 4,  time: "2015-11-24 13:56", brief: "the three-body",             amount: rAmount()),
        Tally(bid: 1, tid: 5,  time: "2015-11-25 12:29", brief: "problem",                    amount: rAmount()),
        Tally(bid: 1, tid: 6,  time: "2015-11-26 14:37", brief: "in orbital",                 amount: rAmount()),
        Tally(bid: 1, tid: 7,  time: "2015-11-27 18:30", brief: "mechanics",                  amount: rAmount()),
        Tally(bid: 1, tid: 8,  time: "2015-11-28 22:10", brief: "The work was",               amount: rAmount()),
        Tally(bid: 1, tid: 9,  time: "2015-11-29 23:33", brief: "serialized",                 amount: rAmount()),
        Tally(bid: 1, tid: 10, time: "2015-11-30 19:17", brief: "in",                         amount: rAmount()),
        Tally(bid: 1, tid: 11, time: "2015-12-01 08:25", brief: "Science Fiction World",      amount: rAmount()),
        Tally(bid: 1, tid: 12, time: "2015-12-02 09:30", brief: "in 2006",                    amount: rAmount()),
        Tally(bid: 1, tid: 13, time: "2015-12-03 11:25", brief: "published",                  amount: rAmount()),
        Tally(bid: 1, tid: 14, time: "2015-12-04 16:43", brief: "as a book",                  amount: rAmount()),
        Tally(bid: 2, tid: 0,  time: "2015-11-20 07:31", brief: "in 2008",                    amount: rAmount()),
        Tally(bid: 2, tid: 1,  time: "2015-11-21 08:32", brief: "and",                        amount: rAmount()),
        Tally(bid: 2, tid: 2,  time: "2015-11-22 09:27", brief: "became",                     amount: rAmount()),
        Tally(bid: 2, tid: 3,  time: "2015-11-23 06:11", brief: "one of",                     amount: rAmount()),
        Tally(bid: 2, tid: 4,  time: "2015-11-24 13:56", brief: "the most ",                  amount: rAmount()),
        Tally(bid: 2, tid: 5,  time: "2015-11-25 12:29", brief: "popular",                    amount: rAmount()),
        Tally(bid: 2, tid: 6,  time: "2015-11-26 14:37", brief: "science fiction",            amount: rAmount()),
        Tally(bid: 2, tid: 7,  time: "2015-11-27 18:30", brief: "novels",                     amount: rAmount()),
        Tally(bid: 2, tid: 8,  time: "2015-11-28 22:10", brief: "in China",                   amount: rAmount()),
        Tally(bid: 2, tid: 9,  time: "2015-11-29 23:33", brief: "It received",                amount: rAmount()),
        Tally(bid: 2, tid: 10, time: "2015-11-30 19:17", brief: "the Chinese",                amount: rAmount()),
        Tally(bid: 2, tid: 11, time: "2015-12-01 08:25", brief: "Science",                    amount: rAmount()),
        Tally(bid: 2, tid: 12, time: "2015-12-02 09:30", brief: "Fiction",                    amount: rAmount()),
        Tally(bid: 2, tid: 13, time: "2015-12-03 11:25", brief: "Galaxy",                     amount: rAmount()),
        Tally(bid: 2, tid: 14, time: "2015-12-04 16:43", brief: "Award",                      amount: rAmount()),
        Tally(bid: 3, tid: 0,  time: "2015-11-20 07:31", brief: "in 2006",                    amount: rAmount()),
        Tally(bid: 3, tid: 1,  time: "2015-11-21 08:32", brief: "A film",                     amount: rAmount()),
        Tally(bid: 3, tid: 2,  time: "2015-11-22 09:27", brief: "adaptation",                 amount: rAmount()),
        Tally(bid: 3, tid: 3,  time: "2015-11-23 06:11", brief: "of the ",                    amount: rAmount()),
        Tally(bid: 3, tid: 4,  time: "2015-11-24 13:56", brief: "same name",                  amount: rAmount()),
        Tally(bid: 3, tid: 5,  time: "2015-11-25 12:29", brief: "is scheduled",               amount: rAmount()),
        Tally(bid: 3, tid: 6,  time: "2015-11-26 14:37", brief: "for release",                amount: rAmount()),
        Tally(bid: 3, tid: 7,  time: "2015-11-27 18:30", brief: "in July",                    amount: rAmount()),
        Tally(bid: 3, tid: 8,  time: "2015-11-28 22:10", brief: "2016",                       amount: rAmount()),
        Tally(bid: 3, tid: 9,  time: "2015-11-29 23:33", brief: "An English",                 amount: rAmount()),
        Tally(bid: 3, tid: 10, time: "2015-11-30 19:17", brief: "translation",                amount: rAmount()),
        Tally(bid: 3, tid: 11, time: "2015-12-01 08:25", brief: "by Ken Liu",                 amount: rAmount()),
        Tally(bid: 3, tid: 12, time: "2015-12-02 09:30", brief: "was published",              amount: rAmount()),
        Tally(bid: 3, tid: 13, time: "2015-12-03 11:25", brief: "by Tor Books",               amount: rAmount()),
        Tally(bid: 3, tid: 14, time: "2015-12-04 16:43", brief: "in 2014",                    amount: rAmount()),
        Tally(bid: 4, tid: 0,  time: "2015-11-20 07:31", brief: "It won",                     amount: rAmount()),
        Tally(bid: 4, tid: 1,  time: "2015-11-21 08:32", brief: "the 2015",                   amount: rAmount()),
        Tally(bid: 4, tid: 2,  time: "2015-11-22 09:27", brief: "Hugo",                       amount: rAmount()),
        Tally(bid: 4, tid: 3,  time: "2015-11-23 06:11", brief: "Award",                      amount: rAmount()),
        Tally(bid: 4, tid: 4,  time: "2015-11-24 13:56", brief: "for",                        amount: rAmount()),
        Tally(bid: 4, tid: 5,  time: "2015-11-25 12:29", brief: "Best",                       amount: rAmount()),
        Tally(bid: 4, tid: 6,  time: "2015-11-26 14:37", brief: "Novel",                      amount: rAmount()),
        Tally(bid: 4, tid: 7,  time: "2015-11-27 18:30", brief: "and was",                    amount: rAmount()),
        Tally(bid: 4, tid: 8,  time: "2015-11-28 22:10", brief: "nominated",                  amount: rAmount()),
        Tally(bid: 4, tid: 9,  time: "2015-11-29 23:33", brief: "for the 2014",               amount: rAmount()),
        Tally(bid: 4, tid: 10, time: "2015-11-30 19:17", brief: "Nebula",                     amount: rAmount()),
        Tally(bid: 4, tid: 11, time: "2015-12-01 08:25", brief: "Award",                      amount: rAmount()),
        Tally(bid: 4, tid: 12, time: "2015-12-02 09:30", brief: "for",                        amount: rAmount()),
        Tally(bid: 4, tid: 13, time: "2015-12-03 11:25", brief: "Best",                       amount: rAmount()),
        Tally(bid: 4, tid: 14, time: "2015-12-04 16:43", brief: "Novel",                      amount: rAmount()),
        Tally(bid: 5, tid: 0,  time: "2015-11-20 07:31", brief: "The Three-Body Problem",     amount: rAmount()),
        Tally(bid: 5, tid: 1,  time: "2015-11-21 08:32", brief: "is a science",               amount: rAmount()),
        Tally(bid: 5, tid: 2,  time: "2015-11-22 09:27", brief: "fiction",                    amount: rAmount()),
        Tally(bid: 5, tid: 3,  time: "2015-11-23 06:11", brief: "novel",                      amount: rAmount()),
        Tally(bid: 5, tid: 4,  time: "2015-11-24 13:56", brief: "by the Chinese",             amount: rAmount()),
        Tally(bid: 5, tid: 5,  time: "2015-11-25 12:29", brief: "writer",                     amount: rAmount()),
        Tally(bid: 5, tid: 6,  time: "2015-11-26 14:37", brief: "Liu Cixin",                  amount: rAmount()),
        Tally(bid: 5, tid: 7,  time: "2015-11-27 18:30", brief: "It is the first",            amount: rAmount()),
        Tally(bid: 5, tid: 8,  time: "2015-11-28 22:10", brief: "of a trilogy",               amount: rAmount()),
        Tally(bid: 5, tid: 9,  time: "2015-11-29 23:33", brief: "titled",                     amount: rAmount()),
        Tally(bid: 5, tid: 10, time: "2015-11-30 19:17", brief: "Remembrance of Earth’s Past",amount: rAmount()),
        Tally(bid: 5, tid: 11, time: "2015-12-01 08:25", brief: "but",                        amount: rAmount()),
        Tally(bid: 5, tid: 12, time: "2015-12-02 09:30", brief: "Chinese readers",            amount: rAmount()),
        Tally(bid: 5, tid: 13, time: "2015-12-03 11:25", brief: "generally refer ",           amount: rAmount()),
        Tally(bid: 5, tid: 14, time: "2015-12-04 16:43", brief: "to the series",              amount: rAmount()),
        Tally(bid: 6, tid: 0,  time: "2015-11-20 07:31", brief: "by the title",               amount: rAmount()),
        Tally(bid: 6, tid: 1,  time: "2015-11-21 08:32", brief: "of the first novel",         amount: rAmount()),
        Tally(bid: 6, tid: 2,  time: "2015-11-22 09:27", brief: "The title",                  amount: rAmount()),
        Tally(bid: 6, tid: 3,  time: "2015-11-23 06:11", brief: "refers to",                  amount: rAmount()),
        Tally(bid: 6, tid: 4,  time: "2015-11-24 13:56", brief: "the three-body",             amount: rAmount()),
        Tally(bid: 6, tid: 5,  time: "2015-11-25 12:29", brief: "problem",                    amount: rAmount()),
        Tally(bid: 6, tid: 6,  time: "2015-11-26 14:37", brief: "in orbital",                 amount: rAmount()),
        Tally(bid: 6, tid: 7,  time: "2015-11-27 18:30", brief: "mechanics",                  amount: rAmount()),
        Tally(bid: 6, tid: 8,  time: "2015-11-28 22:10", brief: "The work was",               amount: rAmount()),
        Tally(bid: 6, tid: 9,  time: "2015-11-29 23:33", brief: "serialized",                 amount: rAmount()),
        Tally(bid: 6, tid: 10, time: "2015-11-30 19:17", brief: "in",                         amount: rAmount()),
        Tally(bid: 6, tid: 11, time: "2015-12-01 08:25", brief: "Science Fiction World",      amount: rAmount()),
        Tally(bid: 6, tid: 12, time: "2015-12-02 09:30", brief: "in 2006",                    amount: rAmount()),
        Tally(bid: 6, tid: 13, time: "2015-12-03 11:25", brief: "published",                  amount: rAmount()),
        Tally(bid: 6, tid: 14, time: "2015-12-04 16:43", brief: "as a book",                  amount: rAmount()),
        Tally(bid: 7, tid: 0,  time: "2015-11-20 07:31", brief: "in 2008",                    amount: rAmount()),
        Tally(bid: 7, tid: 1,  time: "2015-11-21 08:32", brief: "and",                        amount: rAmount()),
        Tally(bid: 7, tid: 2,  time: "2015-11-22 09:27", brief: "became",                     amount: rAmount()),
        Tally(bid: 7, tid: 3,  time: "2015-11-23 06:11", brief: "one of",                     amount: rAmount()),
        Tally(bid: 7, tid: 4,  time: "2015-11-24 13:56", brief: "the most ",                  amount: rAmount()),
        Tally(bid: 7, tid: 5,  time: "2015-11-25 12:29", brief: "popular",                    amount: rAmount()),
        Tally(bid: 7, tid: 6,  time: "2015-11-26 14:37", brief: "science fiction",            amount: rAmount()),
        Tally(bid: 7, tid: 7,  time: "2015-11-27 18:30", brief: "novels",                     amount: rAmount()),
        Tally(bid: 7, tid: 8,  time: "2015-11-28 22:10", brief: "in China",                   amount: rAmount()),
        Tally(bid: 7, tid: 9,  time: "2015-11-29 23:33", brief: "It received",                amount: rAmount()),
        Tally(bid: 7, tid: 10, time: "2015-11-30 19:17", brief: "the Chinese",                amount: rAmount()),
        Tally(bid: 7, tid: 11, time: "2015-12-01 08:25", brief: "Science",                    amount: rAmount()),
        Tally(bid: 7, tid: 12, time: "2015-12-02 09:30", brief: "Fiction",                    amount: rAmount()),
        Tally(bid: 7, tid: 13, time: "2015-12-03 11:25", brief: "Galaxy",                     amount: rAmount()),
        Tally(bid: 7, tid: 14, time: "2015-12-04 16:43", brief: "Award",                      amount: rAmount()),
        Tally(bid: 8, tid: 0,  time: "2015-11-20 07:31", brief: "in 2006",                    amount: rAmount()),
        Tally(bid: 8, tid: 1,  time: "2015-11-21 08:32", brief: "A film",                     amount: rAmount()),
        Tally(bid: 8, tid: 2,  time: "2015-11-22 09:27", brief: "adaptation",                 amount: rAmount()),
        Tally(bid: 8, tid: 3,  time: "2015-11-23 06:11", brief: "of the ",                    amount: rAmount()),
        Tally(bid: 8, tid: 4,  time: "2015-11-24 13:56", brief: "same name",                  amount: rAmount()),
        Tally(bid: 8, tid: 5,  time: "2015-11-25 12:29", brief: "is scheduled",               amount: rAmount()),
        Tally(bid: 8, tid: 6,  time: "2015-11-26 14:37", brief: "for release",                amount: rAmount()),
        Tally(bid: 8, tid: 7,  time: "2015-11-27 18:30", brief: "in July",                    amount: rAmount()),
        Tally(bid: 8, tid: 8,  time: "2015-11-28 22:10", brief: "2016",                       amount: rAmount()),
        Tally(bid: 8, tid: 9,  time: "2015-11-29 23:33", brief: "An English",                 amount: rAmount()),
        Tally(bid: 8, tid: 10, time: "2015-11-30 19:17", brief: "translation",                amount: rAmount()),
        Tally(bid: 8, tid: 11, time: "2015-12-01 08:25", brief: "by Ken Liu",                 amount: rAmount()),
        Tally(bid: 8, tid: 12, time: "2015-12-02 09:30", brief: "was published",              amount: rAmount()),
        Tally(bid: 8, tid: 13, time: "2015-12-03 11:25", brief: "by Tor Books",               amount: rAmount()),
        Tally(bid: 8, tid: 14, time: "2015-12-04 16:43", brief: "in 2014",                    amount: rAmount()),
        Tally(bid: 9, tid: 0,  time: "2015-11-20 07:31", brief: "It won",                     amount: rAmount()),
        Tally(bid: 9, tid: 1,  time: "2015-11-21 08:32", brief: "the 2015",                   amount: rAmount()),
        Tally(bid: 9, tid: 2,  time: "2015-11-22 09:27", brief: "Hugo",                       amount: rAmount()),
        Tally(bid: 9, tid: 3,  time: "2015-11-23 06:11", brief: "Award",                      amount: rAmount()),
        Tally(bid: 9, tid: 4,  time: "2015-11-24 13:56", brief: "for",                        amount: rAmount()),
        Tally(bid: 9, tid: 5,  time: "2015-11-25 12:29", brief: "Best",                       amount: rAmount()),
        Tally(bid: 9, tid: 6,  time: "2015-11-26 14:37", brief: "Novel",                      amount: rAmount()),
        Tally(bid: 9, tid: 7,  time: "2015-11-27 18:30", brief: "and was",                    amount: rAmount()),
        Tally(bid: 9, tid: 8,  time: "2015-11-28 22:10", brief: "nominated",                  amount: rAmount()),
        Tally(bid: 9, tid: 9,  time: "2015-11-29 23:33", brief: "for the 2014",               amount: rAmount()),
        Tally(bid: 9, tid: 10, time: "2015-11-30 19:17", brief: "Nebula",                     amount: rAmount()),
        Tally(bid: 9, tid: 11, time: "2015-12-01 08:25", brief: "Award",                      amount: rAmount()),
        Tally(bid: 9, tid: 12, time: "2015-12-02 09:30", brief: "for",                        amount: rAmount()),
        Tally(bid: 9, tid: 13, time: "2015-12-03 11:25", brief: "Best",                       amount: rAmount()),
        Tally(bid: 9, tid: 14, time: "2015-12-04 16:43", brief: "Novel",                      amount: rAmount())
    ]
    
    func getBookTally(bid: Int) -> [Tally]{
        if bid == -1 {return self.tallyData}
        else {
            var tallys: [Tally] = []
            for tally in self.tallyData {
                if tally.bid == bid { tallys.append(tally)}
            }
            return tallys
        }
    }
}

func rAmount() -> Double {
    let max = 100000
    let min = 0
    return Double(arc4random_uniform(UInt32(max-min)) + UInt32(min))/pow(10.0, 2)
}

struct Book {
    var bid : Int
    var icon: UIImage?
    var name: String
    var part: String
}

struct Tally {
    var bid   : Int
    var tid   : Int
    var time  : String
    var brief : String
    var amount: Double
}

struct Person {
    var name: String
    var pid : Int
    var avatar : UIImage?
}

struct Category {
    var name: String
    var cid : Int
    var icon : UIImage
}