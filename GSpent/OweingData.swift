//
//  OweingData.swift
//  GSpent
//
//  Created by Laurence on 8/12/2015.
//  Copyright © 2015 LIU Jiahe. All rights reserved.
//

import Foundation
import UIKit

class AllOweingRelationships{
    var oweRecords:[OweRecord]=[]
    var creditorRecords:[String]=[]
    var debtorRecords:[String]=[]
    
    required init(){
        for var index=0;index<100;index++ {
            oweRecords.append(OweRecord.randomRecord())
        }
    }
    
    func getOweRecords() -> [OweRecord]{
        return oweRecords
    }
    
    //    func allCreditors() -> [Person]{
    //        var creditorRecords:[Person]=[]
    //        var creditors:[Person]=[]
    //
    //        for oweRecord in oweRecords{
    //            creditorRecords.append(oweRecord.creditor)
    //        }
    //
    //        for creditorRecord in creditorRecords{
    //            if creditors.isEmpty {
    //                creditors.append(creditorRecord)
    //            }
    //
    //            for creditor in creditors{
    //
    //            }
    //        }
    //    }
    
    func allCreditors()-> [String] {
        for oweRecord in oweRecords{
            creditorRecords.append(oweRecord.creditor.name)
            //will be replaced by an ID which is also a String
        }
        let theSet = Set<String>(creditorRecords)
        return [String](theSet)
    }
    
    func allDebtors()-> [String] {
        for oweRecord in oweRecords{
            debtorRecords.append(oweRecord.debtor.name)
            //will be replaced by an ID which is also a String
        }
        let theSet = Set<String>(debtorRecords)
        return [String](theSet)
    }
    
    func recordsRelatedToCertainCreditor(who certainPerson:String) -> [OweRecord]{
        var relatedRecords:[OweRecord]=[]
        for oweRecord in oweRecords{
            if oweRecord.creditor.name == certainPerson{
                relatedRecords.append(oweRecord)
            }
        }
        return relatedRecords
    }
    
    func recordsRelatedToCertainDebtor(who certainPerson:String) -> [OweRecord]{
        var relatedRecords:[OweRecord]=[]
        for oweRecord in oweRecords{
            if oweRecord.debtor.name == certainPerson{
                relatedRecords.append(oweRecord)
            }
        }
        return relatedRecords
    }
    
    func toString() ->String{
        var string:String=""
        for oweRecord in oweRecords{
            string.appendContentsOf(oweRecord.toString())
        }
        return string
    }
}

class OweRecord {
    var debtor:Person //欠款者
    var creditor:Person //债主
    var amount:Int
    var currency:String
    
    //default owes 500 HKD
    required init(_ debtor:Person,owes creditor:Person,_ howMuch:Int=500,_ currency:String="HKD"){
        self.creditor=creditor
        self.debtor=debtor
        self.amount=howMuch
        self.currency=currency
    }
    
    class func randomRecord() -> OweRecord{
        let newRecord=self.init(Person.randomPerson(),owes: Person.randomPerson())
        return newRecord
    }
    
    func toString() -> String{
        let string="\(creditor.name) owes \(debtor.name) \(amount) HKD; "
        return string
    }
}
