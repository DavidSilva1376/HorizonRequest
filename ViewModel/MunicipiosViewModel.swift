import Foundation

class MunicipiosViewModel: ObservableObject {
    @Published var municipios: [Municipio] = [
        Municipio(nombre: "Monterrey"),
        Municipio(nombre: "Guadalupe"),
        Municipio(nombre: "San Nicolás de los Garza"),
        Municipio(nombre: "San Pedro Garza García"),
        Municipio(nombre: "Ciudad Apodaca"),
        Municipio(nombre: "Montemorelos"),
        Municipio(nombre: "Cadereyta Jiménez")
    ]
    
    @Published var municipioSeleccionado: Municipio?
}
