//
//  ViewController.swift
//  Anchor
//
//  Created by Даша Волошина on 26.08.22.
//
import UIKit

protocol DelegateForButton:AnyObject {

    func buttonTappedDelegate  (_ sender:UIButton)

}

protocol TopViewDelegate:AnyObject {
    
    func textFieldEding(_ textField:UITextField)
    
}

class TopView: UIStackView, UITextFieldDelegate {

    weak var delegate: TopViewDelegate?
    
    var stackViewForTextField = UIStackView()
    var imageWithView = UIImageView()
    var stackLabel = UIStackView()
    var label1 =  UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var textFild1 = UITextField()
    var textFild2 = UITextField()
    var textFild3 = UITextField()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        addArrangedSubview(imageWithView)
        addArrangedSubview(stackLabel)
        addArrangedSubview(stackViewForTextField)
        imageWithView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageWithView.image = UIImage(named: "cat")
        imageWithView.contentMode = .scaleAspectFit
        imageWithView.frame = CGRect(x: 0, y: 0, width:80, height: 80)
        imageWithView.backgroundColor = .purple
        
        makeStackLabel1 ()
        makeStackTextField2 ()
        
        textFild1.delegate = self
        textFild2.delegate = self
        textFild3.delegate = self

        
        stackViewForTextField.translatesAutoresizingMaskIntoConstraints = false
        stackViewForTextField.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.45).isActive = true
        
        
        stackLabel.translatesAutoresizingMaskIntoConstraints = false
        stackLabel.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.2).isActive = true
        
    }
    
    func makeStackLabel1 () {
        
        stackLabel.addArrangedSubview(label1)
        stackLabel.addArrangedSubview(label2)
        stackLabel.addArrangedSubview(label3)
        stackLabel.makeStackLabel()
        
        label1.text = "First"
        label2.text = "Middle"
        label3.text = "Last"
        
    }
 
    func makeStackTextField2 () {
        
        stackViewForTextField.addArrangedSubview(textFild1)
        stackViewForTextField.addArrangedSubview(textFild2)
        stackViewForTextField.addArrangedSubview(textFild3)
        stackViewForTextField.makeStackTextField()
        
        textFild1.placeholder = "Enter first ame"
        textFild2.placeholder = "Enter middle name"
        textFild3.placeholder = "Enter last name"
        textFild1.resignFirstResponder()
        
        textFild1.makeTextField()
        textFild2.makeTextField()
        textFild3.makeTextField()
         
}
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
 func textFieldShouldBeginEditing(_ textField:UITextField) -> Bool {
        print ("началось редактирование")
     return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField)  -> Bool{
    
      print ("закончилось редактирование")
        return true
    }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print ("вы ввели \(string)")
     return true
    }

    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print ("поле ощищено")
        return true
    }
        
   func textFieldShouldReturn(_ textField: UITextField)  -> Bool{
       print ("клавиатура убрана")
       textFild1.resignFirstResponder()
       textFild2.resignFirstResponder()
       textFild3.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldEding(textField)
    }
}


class  Button: UIStackView {
    
    weak var delegate:DelegateForButton?
    
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        addArrangedSubview(button1)
        addArrangedSubview(button2)
        addArrangedSubview(button3)
        
        button1.backgroundColor = .orange
        button2.backgroundColor = .purple
        button3.backgroundColor = .yellow
        button1.setTitle("Save", for: .normal)
        button2.setTitle("Cancel", for: .normal)
        button3.setTitle("Clear", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button3.setTitleColor(.black, for: .normal)
        
        button1.addTarget(self, action: #selector(buttonTappedDelegate), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTappedDelegate), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTappedDelegate), for: .touchUpInside)
        
    }
    
    required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    
  @objc func buttonTappedDelegate(_ sender: UIButton) {
      delegate?.buttonTappedDelegate(sender)
  }
    
}


class ViewController: UIViewController, TopViewDelegate, DelegateForButton {

    var stackTop:TopView = TopView()
    var notes = UITextView()
    var stackViewBottom:Button = Button()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackTop)
        view.addSubview(stackViewBottom)
        view.addSubview(notes)
        makeTop()
        notes.makeNote()
        makeAnchorNotes()
        buttonStackmake()
        stackTop.makeStackTop()
        
        stackTop.delegate = self
        stackViewBottom.delegate = self
        
    }
    
    func buttonTappedDelegate(_ sender: UIButton) {
        print ("передача совершена")
    }
    
    func textFieldEding (_ textField: UITextField) {
        notes.text = textField.text
        
    }
    func makeTop () {
        
        stackTop.translatesAutoresizingMaskIntoConstraints = false
        stackTop.topAnchor .constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        stackTop.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackTop.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stackTop.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
    }
    
    func  makeAnchorNotes () {
        
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.topAnchor.constraint(equalTo: stackTop.bottomAnchor, constant: 10).isActive = true
        notes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        notes.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true

}

    func buttonStackmake() {

        stackViewBottom.makeStackBottom()
        stackViewBottom.translatesAutoresizingMaskIntoConstraints = false
        stackViewBottom.topAnchor.constraint(equalTo: notes.bottomAnchor, constant: 10).isActive = true
        stackViewBottom.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        stackViewBottom.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackViewBottom.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        stackViewBottom.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive =  true
        
    }
    
}


