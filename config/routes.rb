Rails.application.routes.draw do

  devise_for :users
  #todo lo que que se pueda consultar en el sitio web pasa por las rutas
  #todo lo que tenga que ver con algo que mostrar pasa por las rutas y se definen aquí
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "bienvenida", to: "home#index" #1"bienvenida" es un recurso en terminología rails y to: nos permite indicar un controlador y ua acción que nos da una respuesta al tipo de petición realizada
                        #home controlador
                        #index acción
  get "perfil", to: "users#edit"

  resources :users, only: [:update] # genera una ruta como ésta: patch "articles/:id", to: "articles#update", as: :article
  root to: "home#index"#ruta base, la ruta base es adonde tenemos que ir cuando voy a la página sin ningu diagonal, path en términos técnicos.
  #no colocamos root "/" porque se asume que el root es ése diagonal, es la ruta base, y no tiene ningún diagonal.
  
  #8get "articles/user/:user_id", to: "articles#from_author" va como línea adicional a resources.
  resources :categories #1
  resources :articles do #9ésta misma línea acepta un bloque para colocar rutas adicionales que no vienen en los resources como la línea de arriba inmediata.
    get "user/:user_id", to: "articles#from_author", on: :collection # on colecction lo que hace es que ésta ruta ..user/:user_id.. se va a generar para una colección como get "articles/user/:user_id"..
                                                                      #la alternativa a on colecction es, on member. get "articles/:id/user/:user_id"..
    resources :comments

  end

  #7 get "articles", to: "articles#index" #render de colecciones, muestrame todos, no así uno por uno. El nombre index es arbitrario.
  #2 get "articles/new", to: "articles#new", as: :new_articles
  #3 get "articles/:id", to: "articles#show" #en show podemos usar @article = Article.find(4) por ejemplo. id se regresa via el objeto params
  #4 get "articles/:id/edit", to: "articles#edit"


  #5 patch "articles/:id", to: "articles#update", as: :article #convención: cuando pasamos a form_with un objeto que ya esta guardado en la db es tratar de enviar el formulario a una ruta como "/article/2" con el verbo PUT o verbo PATCH de HTTP
  #as: :article para que sepa que la ruta que definimos (patch..) es esta que va a buscar
  #2 post "articles", to:"articles#create" #esto es tomar el plural de la Clase del objeto en el formulario) Article y mandar la petición post.
                                        #asumiendo del objeto que le enviamos al form model: @article, poreso sabe a donde mandar la petición.
  #6 delete "articles/:id", to: "articles#destroy" #lo id deben decirte cuál es el recurso con el que vamos a trabajar, no deberían decirte qué quiero hacer con ése recurso.
  #lo que viene el verbo es lo que quiero hacer con ése recurso, eliminar, actualizar, lo quiero ver, etc.
  end
