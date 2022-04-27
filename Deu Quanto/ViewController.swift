//
//  ViewController.swift
//  Deu Quanto
//
//  Created by LoreVilaca on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var alcoholView: UIView!
    @IBOutlet weak var alcoholSwitch: UISwitch!
    @IBOutlet weak var alcoholTotalValue: UITextField!
    @IBOutlet weak var alcoholPeopleDividing: UITextField!
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var billTotalValue: UITextField!
    @IBOutlet weak var totalPeopleDividing: UITextField!
    @IBOutlet weak var resultValue: UILabel!
    @IBOutlet weak var alcoholDividedValue: UILabel!
    @IBOutlet weak var nalcoholDividedValue: UILabel!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        tipSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            super.viewDidLoad()
    }
    
    @IBAction func touchRecalculateButton(_ sender: Any) {
        changeView()
    }
    
    @IBAction func touchCalculateButton(_ sender: Any) {
        showResult()
        changeView()
    }
    
    func alcoholDivision () -> Double {
        //Pegar o valor das bebidas
        //Dividir pela quantidade de pessoas que beberam
        //Somar com o valor total da comida
        //Esse valor será o total para quem bebeu
        
        let alcoholValueAux : String = alcoholTotalValue.text ?? "0"
        let alcoholValue : Double = Double (alcoholValueAux) ?? 0
        let peopleAux : String = alcoholPeopleDividing.text ?? "0"
        let peopleDividing : Double = Double (peopleAux) ?? 0
        let tipPercentage : Double = getTipValue()
        
        let alcoholDivision = alcoholValue/peopleDividing * tipPercentage
        return alcoholDivision
    }
    
    func totalBillDivision () -> Double {
        //Dividir valor total entre a quantidade total de pessoas
        //Checar se houve ou não consumo de álcool
        //Se houve, diminuir do valor total a ser dividido
        //Esse valor será o total sem contar bebidas alcoolicas
        let totalValueAux : String = billTotalValue.text ?? "0"
        var totalFoodValue : Double = Double (totalValueAux) ?? 0
        let peopleAux = totalPeopleDividing.text ?? "0"
        let peopleDividing : Double = Double (peopleAux) ?? 0
        let dividedValue : Double
        
        if alcoholSwitch.isOn{
            let alcoholValueAux : String = alcoholTotalValue.text ?? "0"
            let alcoholValue : Double = Double (alcoholValueAux) ?? 0
            totalFoodValue -= alcoholValue
        }
        let tipPercentage : Double = getTipValue()
        dividedValue = (totalFoodValue/peopleDividing) * tipPercentage
        return dividedValue
        
    }
    
    func showResult (){
        let totalValueAux : String = billTotalValue.text ?? "0"
        let tipPercentage = getTipValue()
        let totalBillValue : Double = (Double (totalValueAux) ?? 0) * tipPercentage
        
        resultValue.text = String(format: "R$%.2f", totalBillValue)
        let nonAlcoholAux = totalBillDivision()
        let nonAlcoholTotal = String(format: "R$%.2f", nonAlcoholAux)
        let alcoholTotal = String(format: "R$%.2f", (alcoholDivision() + nonAlcoholAux))
        alcoholDividedValue.text = alcoholTotal
        nalcoholDividedValue.text = nonAlcoholTotal
    }
    
    func getTipValue () -> Double {
        //This function will return as Double the value selected on tipSegmentedControl
        //Return is double cause we need to multiply our total value and find how tip value
        let tipPercentage : Int = tipSegmentedControl.selectedSegmentIndex
        let tipMultiply : Double
        
        switch tipPercentage {
        case 0:
            //if the tip percentage is 0%, the bill value will be multiplied by 1
            tipMultiply = 1
            
        case 1:
            //if the tip percentage is 10%, the bill value will be multiplied by 1.1
            tipMultiply = 1.1
            
        case 2:
            //if the tip percentage is 15%, the bill value will be multiplied by 1.15
            tipMultiply = 1.15
            
        case 3:
            //if the tip percentage is 20%, the bill value will be multiplied by 1.20
            tipMultiply = 1.20
            
        case 4:
            //if the tip percentage is 30%, the bill value will be multiplied by 1.30
            tipMultiply = 1.30
            
        default:
            tipMultiply = 0
        }
        return tipMultiply
    }
    
    @IBAction func touchAlcoholSwitch(_ sender: Any) {
        if alcoholSwitch.isOn == false {
            alcoholView.isHidden = true
            alcoholTotalValue.text = ""
            alcoholPeopleDividing.text = ""
        } else if alcoholSwitch.isOn == true{
            alcoholView.isHidden = false
        }
    }
    
    func changeView () {
        //When touch calculateButton hide initialView and show resultView
        //When touch recalculateButton hide resultView and show initialView
        if initialView.isHidden == false {
            //Change views
            resultView.isHidden = false
            initialView.isHidden = true
        } else if initialView.isHidden == true {
            //Change views
            cleanTextFields()
            initialView.isHidden = false
            alcoholView.isHidden = true
            resultView.isHidden = true
        }
    }
    
    func cleanTextFields () {
        //Set Segmented Control to 10%, clean all text fields and set alcoohol switch off
        tipSegmentedControl.selectedSegmentIndex = 1
        alcoholTotalValue.text = ""
        alcoholPeopleDividing.text = ""
        totalPeopleDividing.text = ""
        billTotalValue.text = ""
        alcoholSwitch.isOn = false
    }
}




