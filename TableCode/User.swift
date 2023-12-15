//
//  User.swift
//  TableCode
//
//  Created by Vitali on 14/12/2023.
//

import UIKit

struct User: Hashable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let age: Int
    let avatar: UIImage? = UIImage(systemName: "checkmark.seal.fill")
}
