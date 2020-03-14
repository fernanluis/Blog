class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles #User tiene muchos articles

  # Active Storage: Agreguemos una foto de perfil al usuario.
  has_one_attached :avatar # avatar es el nombre con el que vamos a identificar el archivo.
  # El Active Storage sirve para lo que sea, img, pdf, doc, lo que sea. No solo fotos.
  # Lo que hace has_one_attached es asociar un recurso al identificador avatar.
  # Cómo sabemos si la foto se guarda bien?
  # Vamos a las rutas y creamos una nueva ruta que va a un contrador y una acción edit.
  # get "perfil", to: "users#edit"
end
