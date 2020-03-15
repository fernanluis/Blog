class Article < ApplicationRecord
  has_rich_text :content #content es un arbitrario, puede ser el body el articulo, etc. Luego colocar el control de action_text en el formulario.
  belongs_to :user #Article pertenece a user
  has_many :has_categories
  has_many :categories, through: :has_categories, dependent: :destroy
  attr_accessor :category_elements #agregando una propiedad al objeto. Los modelos son simples y sencillas clases, que cuentan con algunas cosas adicionales ya que estan heredando del ActiveRecord que es el ORM.
                                   #attr_accessor permite definir una propiedad que podemos leer y que podemos escribir.
                                   #attr_accessor es como agregarle una propiedad al objeto, en éste ejemplo category_elements
  has_many :comments, dependent: :destroy
  validates :title, presence:true, length:{minimum:5}

  def save_categories
    #1category_elements 1,2,3 (strings de ids separadas por comas)
    #2Debemos convertirlo enun arreglo.1,2,3 => [1,2,3]
    #3Luego iterar ése arreglo.
    #4Luego por cada elemento que hay en el arreglo crear u n elemento de la tabla asociativa, un HasCategory para que se establezca la relación.
    #5Es decir, HasCategory<article_id:1, category_id:2>

    #1categories_array = category_elements.split(",") #2 el método split permite separar un string para convertirlo en un eleento del arreglo.

    #comentamos la línea anterior ya que incorporamos la configuración de html multiple para el areglo correspondiente.

    #2categories_array.each do |category_id|
    #     HasCategory.create(article:self, category_id: category_id) #self hace referencia al artículo actual. Entonces, creamos un registro de la tabla asociativa para el artículo que en ése momento esta guardado en sus categorías y guardamos el category_id.
    # Cuándo mandamos a llamar éste método?
    # Después de crear el artículo? en def create...@article.save_categories.. Pero también cuando actulizamos. en def.. update end
    # Así se crean duplicados.. Cómo lo resolvemos?.. Vea a continuación..

    #3 Validemos si el registro existe.
    # if HasCategory.where(article:self, category_id: category_id).any? Si trajo un o más devuelve true sino false entonces algo.
    # se ejecuta algo
    # else
    #   HasCategory.create(article:self, category_id: category_id) # self hace referencia al artículo actual. Entonces, creamos un registro de la tabla asociativa para el artículo que en ése momento esta guardado en sus categorías y guardamos el category_id.
    # end


    #4 O, podemos utilizar el inverso
    #  unless HasCategory.where(article:self, category_id: category_id).any?
    #    HasCategory.create(article:self, category_id: category_id)
    # end

    # en el form <%=form.check_box :category_elements, {multiple: true}, category.id, nil %>. {multiple: true} es una configuración de html que permite seleccionar más de un check box y que lo manda todo en un arrelgo.
    # Entones como category_elements va ir como un arreglo, ya no va a ser un string, por ende no es necesario convertirlo en un arreglo porque ya viene como un arreglo.
    # Entonces categories_array.each do |category_id| ya no.

    # método nil? para saber si es nulo la variable y tiene un método empty? de los arreglos para saber si esta vacío o no.
    return has_categories.destroy_all if category_elements.nil? || category_elements.empty? # Así conserva lo que ya tenía

    # Si ya no viene activo, eliminar de lo que ya tenemos.
    # Y para ello tomamos los recurso de la tabla asociativa has_categories.
    # el has_categories dentro de un article devuelve todos los recursos de la tabla asociativa que le pertencen a éste artículo.
    # Recuerden; relación: uno a muchos.

    has_categories.where.not(category_id: category_elements).destroy_all # Inverso de where y devuelve los elementos que no coincidan con los elementos enviados en (..)

    category_elements.each do |category_id|

      #Ésta es la mejor forma de hacerlo. Si hay algún registro que cumpla ambas condiciones lo retorna, lo encuentra y sino exite,lo crea.
      HasCategory.find_or_create_by(article: self, category_id: category_id)

    end
  end
end
