import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var currentUser: CurrentUser
    
    var body: some View {
        ZStack {
            // Fondo general
            Color(red: 0.19, green: 0.19, blue: 0.19)
                .edgesIgnoringSafeArea(.all)
            
            // Contenedor principal
            VStack(spacing: 20) {
                // Título LOGIN
                Text("LOGIN")
                    .font(Font.custom("Inria Sans", size: 40).weight(.bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Contenedor del formulario
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.12, green: 0.12, blue: 0.12))
                        .cornerRadius(10)
                        .frame(height: 280)
                    
                    VStack(spacing: 30) {
                        // Campo de nombre de usuario
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            
                            TextField("", text: $viewModel.nombre)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                                .frame(height: 60)
                                .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        
                        // Mensaje de error
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .font(Font.custom("Inria Sans", size: 16))
                                .foregroundColor(.red)
                        }
                        
                        // Botón de entrar
                        Button(action: {
                            viewModel.ingresar()
                            if !viewModel.nombre.isEmpty {
                                currentUser.nombre = viewModel.nombre
                            }
                        }) {
                            Text("Entrar")
                                .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                                .frame(width: 140, height: 60)
                                .background(viewModel.nombre.isEmpty ? Color.gray : Color(red: 1, green: 0.74, blue: 0.35))
                                .foregroundColor(.black)
                                .cornerRadius(30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(.black, lineWidth: 0.50)
                                )
                        }
                        .disabled(viewModel.nombre.isEmpty)
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            NavigationStack{
                SeleccionMunicipioView()
            }
            .environmentObject(currentUser)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(CurrentUser())
}

