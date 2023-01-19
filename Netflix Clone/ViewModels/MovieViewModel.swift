//
//  MovieViewModel.swift
//  Netflix Clone
//
//  Created by Mohamed Hany on 14/01/2023.
//

import Foundation

struct MovieViewModel {
    let titleName: String
    let posterURL: String
    let date: String
    
    var day: String {
        return date[date.count-2 ..< date.count]
    }
    var month: String {
        let month = date[5 ..< 7]

        switch month {
        case "01":
            return "JAN"
        case "02":
            return "FEB"
        case "03":
            return "MAR"
        case "04":
            return "APR"
        case "05":
            return "MAY"
        case "06":
            return "JUN"
        case "07":
            return "JUl"
        case "08":
            return "AUG"
        case "09":
            return "SEP"
        case "10":
            return "OCT"
        case "11":
            return "NOV"
        case "12":
            return "DEC"
        default:
            return ""
        }
    }
}
