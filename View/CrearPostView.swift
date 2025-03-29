import SwiftUI
import PhotosUI

struct CrearPostView: View {
    @StateObject private var viewModel = CrearPostViewModel()
    @Environment(\.presentationMode) var presentationMode
    var usuario: String
    var onPostCreated: (Post) -> Void
    
    @State private var selectedImage: PhotosPickerItem?
    
    var body: some View {
        ZStack {
            // Fondo
            Color(red: 0.19, green: 0.19, blue: 0.19)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Comunidad")
                                .font(Font.custom("Inria Sans", size: 20).weight(.bold))
                        }
                        .foregroundColor(Color(red: 1, green: 0.74, blue: 0.35))
                    }
                    
                    Spacer()
                    
                    Text("Nuevo Post")
                        .font(Font.custom("Inria Sans", size: 32).weight(.bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Espacio para balancear
                    Text("").hidden()
                }
                .padding(.horizontal)
                
                // Selector de tipo (Request/Anuncio)
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.tipo = .request
                    }) {
                        Text("Request")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 140, height: 40)
                            .background(viewModel.tipo == .request ? Color(red: 1, green: 0.74, blue: 0.35) : Color(red: 0.35, green: 0.35, blue: 0.35))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.tipo == .request ? .white : .black, lineWidth: viewModel.tipo == .request ? 1.5 : 0.5)
                            )
                    }
                    
                    Button(action: {
                        viewModel.tipo = .anuncio
                    }) {
                        Text("Anuncio")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 140, height: 40)
                            .background(viewModel.tipo == .anuncio ? Color(red: 1, green: 0.74, blue: 0.35) : Color(red: 0.35, green: 0.35, blue: 0.35))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(viewModel.tipo == .anuncio ? .white : .black, lineWidth: viewModel.tipo == .anuncio ? 1.5 : 0.5)
                            )
                    }
                }
                
                // Campos del formulario
                Group {
                    TextField("Titulo...", text: $viewModel.title)
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .cornerRadius(10)
                    
                    TextField("Descripcion...", text: $viewModel.description, axis: .vertical)
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(minHeight: 150)
                        .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .cornerRadius(10)
                    
                    TextField("Colonia...", text: $viewModel.colonia)
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .cornerRadius(10)
                    
                    TextField("Calle...", text: $viewModel.calle)
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Selector de imagen
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    Text("Seleccionar Imagen")
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 330, height: 70)
                        .background(Color(red: 0.07, green: 0.07, blue: 0.07))
                        .cornerRadius(10)
                }
                .onChange(of: selectedImage) { _ in
                    loadImage()
                }
                
                // Vista previa de la imagen
                if let image = viewModel.imagen {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // Botones de acción
                HStack(spacing: 20) {
                    Button(action: {
                        if let nuevoPost = viewModel.crearPost(autor: usuario) {
                            onPostCreated(nuevoPost)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Publicar")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 140, height: 60)
                            .background(Color(red: 1, green: 0.74, blue: 0.35))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black, lineWidth: 0.5)
                            )
                    }
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancelar")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .frame(width: 140, height: 60)
                            .background(Color(red: 1, green: 0.32, blue: 0.32))
                            .cornerRadius(30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(.black, lineWidth: 0.5)
                            )
                    }
                }
                .padding(.bottom, 20)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(Font.custom("Inria Sans", size: 16))
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }
            }
            .padding(.top, 20)
        }
    }
    
    func loadImage() {
        guard let selectedImage else { return }
        Task {
            if let data = try? await selectedImage.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                viewModel.imagen = uiImage
            }
        }
    }
}

#Preview {
    CrearPostView(usuario: "Usuario Ejemplo") { _ in }
}
