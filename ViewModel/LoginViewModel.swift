import Foundation

class LoginViewModel: ObservableObject {
    @Published var nombre: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    func ingresar() {
        guard !nombre.isEmpty else {
            errorMessage = "El nombre es obligatorio."
            return
        }
        isLoggedIn = true
        errorMessage = nil
    }
}

