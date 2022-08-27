//
//  ViewController.swift
//  Anchor
//
//  Created by Даша Волошина on 26.08.22.
//
import UIKit
//Верхнюю часть с изображением цветов вынести в отдельный контейнер, События в TextField передавать на viewController с помощью делегата/Closure
//
//Нижнюю часть с кнопками сделать также

protocol ButtonDelegate:AnyObject {

    func buttonTappedDelegate  (_ sender:UIButton)

}

class  ViewDelegate:UIStackView {
    
    weak var delegate: ButtonDelegate?
    
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
         
//        button1.translatesAutoresizingMaskIntoConstraints = false
//        button2.translatesAutoresizingMaskIntoConstraints = false
//        button3.translatesAutoresizingMaskIntoConstraints = false
//
//        button1.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        button1.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        button2.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        button2.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        button3.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        button3.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
        
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


class ViewController: UIViewController, UITextFieldDelegate,ButtonDelegate {
       
    var stackViewForTextField = UIStackView()
    var stackLabel = UIStackView()
    var stackTop =  UIStackView()
    var imageWithView = UIImageView()
    var label1 =  UILabel()
    var label2 = UILabel()
    var label3 = UILabel()
    var textFild1 = UITextField()
    var textFild2 = UITextField()
    var textFild3 = UITextField()
    var notes = UITextView()
    var stackViewBottom:ViewDelegate = ViewDelegate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFild1.delegate = self
        textFild2.delegate = self
        textFild3.delegate = self
        
        imageWithView.image = UIImage(named: "man")
        view.addSubview(stackTop)
        view.addSubview(stackViewBottom)
        view.addSubview(notes)
        makeTop()
        notes.makeNote()
        makeAnchorNotes()
        buttonStackmake()
        stackViewBottom.delegate = self
        
    }
    
    func buttonTappedDelegate(_ sender: UIButton) {
        print ("передача совершена")
    }
    
    func makeStackLabel1 () {
        
        stackLabel.addArrangedSubview(label1)
        stackLabel.addArrangedSubview(label2)
        stackLabel.addArrangedSubview(label3)
        label1.text = "First"
        label2.text = "Middle"
        label3.text = "Last"
        stackLabel.makeStackLabel()
        
    }
 
    func makeStackTextField2 () {
        
        stackViewForTextField.addArrangedSubview(textFild1)
        stackViewForTextField.addArrangedSubview(textFild2)
        stackViewForTextField.addArrangedSubview(textFild3)
        
        textFild1.placeholder = "Enter first ame"
        textFild2.placeholder = "Enter middle name"
        textFild3.placeholder = "Enter last name"
        
        textFild1.makeTextField()
        textFild2.makeTextField()
        textFild3.makeTextField()
         
        stackViewForTextField.makeStackTextField()
        
}
     
    func makeTop () {
        
        makeStackTextField2 ()
        makeStackLabel1()
        stackTop.makeStackTop()
        
        stackTop.addArrangedSubview(imageWithView)
        stackTop.addArrangedSubview(stackLabel)
        stackTop.addArrangedSubview(stackViewForTextField)
        stackViewForTextField.widthAnchor.constraint(equalTo: stackTop.widthAnchor,multiplier: 0.4).isActive = true
//        stackViewForTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackLabel.widthAnchor.constraint(equalTo: stackTop.widthAnchor,multiplier: 0.25).isActive = true

       
        
        stackTop.translatesAutoresizingMaskIntoConstraints = false
        stackTop.topAnchor .constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        stackTop.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackTop.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stackTop.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
//        imageWithView.widthAnchor.constraint(equalTo: stackTop.widthAnchor,multiplier: 0.25).isActive = true
        imageWithView.contentMode = .scaleToFill
    }
    
    func  makeAnchorNotes () {
        
        notes.translatesAutoresizingMaskIntoConstraints = false
        notes.topAnchor.constraint(equalTo: stackTop.bottomAnchor, constant: 10).isActive = true
        notes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        notes.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
//        notes.heightAnchor.constraint(equalToConstant: 500).isActive =  true
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
    


    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print ("textFieldShouldBeginEditing")
         return true
        
    }
   
  func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
      print ("началось редактирование")
      return true
        
    }

    func textFieldDidEndEditing(_ textField: UITextField)  -> Bool{
        print ("закончилось редактирование")
        return true
    }
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     print ("вы ввели \(string)")
     return true
    }

    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print ("клавиатура ощищается")
        return true
    }
        
   func textFieldShouldReturn(_ textField: UITextField)  -> Bool{
       print ("Клавиатура убрана")
       textFild1.resignFirstResponder()
        return true
    }
    
}
    

