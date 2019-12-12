//
//  CurrencyTableViewCell.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 31.10.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    func fillData(viewModel:String) {
        currencyLabel.text = viewModel
        currencyImageView.backgroundColor = UIColor.black
    }
}
