import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel: ViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel(input: (email: emailField.rx.text.orEmpty.asDriver(),
                                      password: passwordField.rx.text.orEmpty.asDriver()))
        
        binding()
    }
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    private func binding() {
        viewModel?.output.validate
            .drive(registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        registerButton.rx.tap.asDriver().drive(onNext: {
            print("register")
        }).disposed(by: disposeBag)
    }


}

