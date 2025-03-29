import SwiftUI
import PhotosUI

struct DetallePostView: View {
    var post: Post
    var municipio: Municipio
    @State private var nuevoComentario = ""
    @State private var imagenSeleccionada: UIImage?
    @State private var mostrarSelectorImagen = false
    @EnvironmentObject var viewModel: FeedViewModel
    @EnvironmentObject var currentUser: CurrentUser
    @Environment(\.presentationMode) var presentationMode
    
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
                    
                    Text(post.title)
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // Espacio para balancear
                    Text("").hidden()
                }
                .padding(.horizontal)
                .navigationBarBackButtonHidden(true)
                
                // Contenido del post
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Imagen del post si existe
                        if let imageData = post.imagenData, let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        }
                        
                        // Información del post
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Created by: \(post.autor) \(formattedDate(post.fecha))")
                                .font(Font.custom("Inria Sans", size: 16))
                                .foregroundColor(.white)
                            
                            Text(post.contenido)
                                .font(Font.custom("Inria Sans", size: 18))
                                .foregroundColor(.white)
                                .padding(.top, 10)
                            
                            HStack {
                                Text("Colonia: \(post.colonia)")
                                    .font(Font.custom("Inria Sans", size: 16))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("Calle: \(post.calle)")
                                    .font(Font.custom("Inria Sans", size: 16))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                        .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                        .cornerRadius(10)
                        
                        // Sección de comentarios
                        Text("Comentarios:")
                            .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        ForEach(post.comentarios) { comentario in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(comentario.autor)
                                        .font(Font.custom("Inria Sans", size: 16).weight(.bold))
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text(formattedDate(comentario.fecha))
                                        .font(Font.custom("Inria Sans", size: 14))
                                        .foregroundColor(.gray)
                                }
                                
                                Text(comentario.contenido)
                                    .font(Font.custom("Inria Sans", size: 16))
                                    .foregroundColor(.white)
                                
                                if let imagenData = comentario.imagenData, let imagen = UIImage(data: imagenData) {
                                    Image(uiImage: imagen)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .cornerRadius(10)
                                        .padding(.top, 5)
                                }
                            }
                            .padding()
                            .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Área para nuevo comentario
                VStack(spacing: 10) {
                    HStack {
                        TextField("Escribe un comentario...", text: $nuevoComentario)
                            .font(Font.custom("Inria Sans", size: 20).weight(.bold))
                            .foregroundColor(.white)
                            .padding()
                            .frame(height: 50)
                            .background(Color(red: 0.35, green: 0.35, blue: 0.35))
                            .cornerRadius(10)
                        
                        Button(action: {
                            mostrarSelectorImagen = true
                        }) {
                            Image(systemName: "photo")
                                .font(.title)
                                .foregroundColor(Color(red: 1, green: 0.74, blue: 0.35))
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(width: 330)
                    
                    // Vista previa de imagen seleccionada
                    if let imagen = imagenSeleccionada {
                        Image(uiImage: imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .cornerRadius(10)
                    }
                    
                    // Botones de acción
                    HStack(spacing: 20) {
                        Button("Cancelar") {
                            nuevoComentario = ""
                            imagenSeleccionada = nil
                        }
                        .font(Font.custom("Inria Sans", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .frame(width: 140, height: 60)
                        .background(Color(red: 1, green: 0.32, blue: 0.32))
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(.black, lineWidth: 0.5)
                        )
                        
                        Button("Enviar") {
                            let comentario = Comentario(
                                autor: currentUser.nombre,
                                contenido: nuevoComentario,
                                fecha: Date(),
                                imagenData: imagenSeleccionada?.jpegData(compressionQuality: 0.8)
                            )
                            viewModel.agregarComentario(comentario, al: post.id, en: municipio)
                            nuevoComentario = ""
                            imagenSeleccionada = nil
                        }
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
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 20)
        }
        .sheet(isPresented: $mostrarSelectorImagen) {
            ImagePicker(image: $imagenSeleccionada)
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    let samplePost = Post(
        title: "Ejemplo de Post",
        contenido: "Este es un ejemplo de contenido de post",
        autor: "Usuario Ejemplo",
        colonia: "Centro",
        calle: "Principal",
        tipo: .request
    )
    
    return DetallePostView(
        post: samplePost,
        municipio: Municipio(nombre: "Monterrey")
    )
    .environmentObject(FeedViewModel())
    .environmentObject(CurrentUser())
}
