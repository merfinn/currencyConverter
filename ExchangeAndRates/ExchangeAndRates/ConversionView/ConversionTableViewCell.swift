//
//  ConversionTableViewCell.swift
//  ExchangeAndRates
//
//  Created by merve kavaklioglu on 01.11.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

class ConversionTableViewCell: UITableViewCell {
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var fromCurrencyDescriptionLabel: UILabel!
    @IBOutlet weak var conversionSignificantLabel: UILabel!
    @IBOutlet weak var conversionSecondSignificantLabel: UILabel!
    @IBOutlet weak var toCurrencyDescription: UILabel!
    
    func fillData(viewModel:Conversion) {
        fromCurrencyLabel.text = "1 " + viewModel.fromCurrency
        fromCurrencyDescriptionLabel.text = viewModel.fromCurrency
        conversionSignificantLabel.text = viewModel.conversionSignificant
        conversionSecondSignificantLabel.text = viewModel.conversionSecondSignificant
        toCurrencyDescription.text = viewModel.toCurrency
    }
}
