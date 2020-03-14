class ArticlesController < ApplicationController
  before_action :find_article, except: [:new, :create, :index, :from_author] #obviamente hay definir ése médoto find_article
                #métodos dentro de un controlador en Rails, métodos que se llaman a nivel de la clase, normalmente se colocan al inicio del controlador.
                #nos permite ejecutar un método antes de que se pase a la acción de un controlador.
                #después del before_action :nombre_del_método_a_ejecutar normalmente escrito como un símbolo.
                #podemos pasar una config only en la que en un arreglo cuáles son las acciones que queremos se mande a llamar antes de find_article y las acciones que aparezcan aqui no van a llamar a find_article. only: [:show, :edit, :update, :destroy]
                #alternativamente podemos hacer el inverso con except: donde, find_article se va a mandar a llamar en todas excepto en las que aparezcan en el arreglo. except: [:new, :create]
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy,:show, :index]
  #after_action #métodos dentro de un controlador en Rails, métodos que se llaman a nivel de la clase, normalmente se colocan al inicio del controlador. Se ejectua después de que los métodos del controlador se hayan ejectuado.
  #after_action es el inverso de before_action.

  def index # except find_article
    @articles = Article.all #método que nos da todo lo que hay en la tabla. Es una colección de todos los artículos.
  end
  # nota que para la vista
  #CRUD, módulo que nos permite create, read, update and delete de una misma tabla.
  def show #permitirá buscar un artículo
    #1@article = Article.find(params[:id])
    #reciclado en find_article para no @article = Article.find_by(params[:id]) y cambiarlos en todas las veces que hacemos una búsqueda.
  end

  def edit #todas las secciones por defecto muestran una vista con el mismo nombre del método.
    #3@article = Article.find(params[:id]) reciclando en find_article
    #1@article = Article.new Cambiamos por; @article = Article.find(params[:id])
    #2puts "\n\n\n #{@article.id}\n\n\n" #imprimir algo en consola,que recargando la página vemos en consola que no hay nada.
    #otra manera e saber si una instancia de modelo esta guardada en una base de datos es utilizar el metodo persisted
    #3puts "\n\n\n #{@article.persisted?}\n\n\n" #consola arroja falso, porque no esta guardada en la base de datos.
    #entonces, al nosotros enviarle un objeto en el model: @article que no esta guardada en al bae de datos, lo que va a hacer es crear un nuevo registro.
    #entonces, aquí, en lugar de eso vamos a buscar el artículo con el id correspondiente de la ruta.
    @categories = Category.all #para poder mostrar los check boxes necesito todas las categorías eliminando <%=form.text_field :category_elements %> del _form.html.erb y cambiandoló e iterando las categorías.
    #@categories = Category.all en new y edit, ya que son las acciones que muestran los formularios.
  end

  def update #acción que va a recibir el formulario y update es muy parecida a create.
    #1@article = Article.find(params[:id]) #lo traemos de la bae de datos y actualizamos ése registro.
    #línea anterior reciclada para find_article
    #1@article.update(title: params[:article][:title],
                              #content: params[:article][:content]
    @article.update(article_params) #la forma en que como se envian los argumentos es igual, es un hash en la que tengo que pasarle los capos que quiero actualizar y con qué valores los quiero actualiar.
    #update es un método del objeto y create de la clase
    #render json: @article aquí no redireccionamos a un json sino al artículo
    @article.save_categories #Podríamos mandarlo a llamar cuando creamos el artíclo pero tambíen cuando actualizamos. con @article.save_categories
    redirect_to @article #1
  end

  def new
    @article = Article.new #crear un articulo
    #@article.title = "Demo" a modo de demostracíon
    @categories = Category.all #para poder mostrar los check boxes necesito todas las categorías eliminando <%=form.text_field :category_elements %> del _form.html.erb y cambiandoló e iterando las categorías.
    #@categories = Category.all en new y edit, ya que son las acciones que muestranlos formularios.
  end

  def create #guarda lo que hayamos recibido del formulario que inicialmente se haya mostrado.
    @article = current_user.articles.create(article_params)
    #create es un método de la clase y update un metodo del objeto.
    #1,2@article.user = current_user # decirle al usuario cuál es su propiedad y luego guardarlo con save
    #2@article.user_id = current_user_id
    #2@article.save #aquí lo guardamos con save luego de decirle su propiedad. Sin embargo, bajo ésta misma lógica estaríamos guardando el articulo dos veces. Una al crearlo, porque al crearlo lo instancía el objeto en la memoria virtual y luego lo guarda en la db.
    #1,2@article = Article.create(title: params[:article][:title],
                              #content: params[:article][:content],#accedemos a content y title a traves de article, porque así construimos el formulario de creación de artículos.
                            #user: current_user)# así no habría un gurdado duplicado. Sin embargo, hay otra manera de guardarlo y es la que prima en cogido realizado.
    #3@article.category_elements #propiedad con lo que sea que se haya agregardo en el formulario en category_elements cuando generamos una categoría al artículo.
    #1render json: @article redireccionaremos hacia el artículo.  #para no crear la vista lo mostramos en json
    @article.save_categories ##Podríamos mandarlo a llamar cuando creamos el artíclo pero tambíen cuando actualizamos. con @article.save_categories
    redirect_to @article
  end

  def destroy
    #1@article = Article.find(params[:id]) reciclando en find_article
    @article.destroy
    redirect_to root_path
  end

  def from_author
    @user = User.find(params[:user_id]) #user_id debede coincidir con el get "articles/user/:user_id.. de routes
  end

  def find_article #before_action
    puts "HOLA!! AQUÍ!!!. ESTAMOS FIND_ARTICLE. VER EN TERMINAL" #ejemplo, vemos en la terminal cuando ejecutamos una acción show por ejemplo
    @article = Article.find(params[:id]) #reciclando código
  end

  def article_params #nombre arbitrario, por convención se escribe el nombre_del_modelo_params
    #params.require(:article).permit(:title, :content, :category_elements)#primero tomamos el objeto params que tiene un método require con parámetro obligatorio article, ya que a partir de él obtenemos lo demás. Y sobre éste parámetro que nos devuelve un hash, le decimos cuál de los atributos estan permitidos y cuales no. Lo que no está como permitido se ignora y elimina.
    #los strong_params requieren que específicamente le digamos cuándo van a recibir un arreglo, y en éste caso de los check_box no esta esperando un arreglo para decirle que el campo :category_elements es un arreglo y lo modificamos a category_elements: [].
    params.require(:article).permit(:title, :content, category_elements: [])
  end

end
