
# Blog
Hola, mi nombre es Luis Fernando y en mi proceso de aprendizaje, con ayuda de herramientas varias, quiero mostrar las diferentes vistas de los diferentes recursos consultados en el Blog. Quiero aclarar que es necesaria la implementación de varias funcionalidades pero aquí intento mostrar el avance hasta el momento.

Las herramientas utilizadas para la creación del Blog se detallan a continuación;
- webpacker con la expulsión en terminal de: paquete ejecutivo rails webpacker: instalar (lo cual instala webpacker, un módulo de RoR que nos permite utilizar webpack, la forma moderna de usar javascript. Instalar dependencias utilizando hilo o npm, lo cual lo hace hace es manejar o controlar toda la parte de nuestros activos, toda la parte que está en la aplicación> javascript, todo lo que va a ser compilado por webpack. Y aunque, no tenemos necesidad de webpacker, sólo para iniciar el servidor lo tenemos que instalar.
- Integramos Bootstrap como dependencia del front-end a traves de webpacker ejecutando en terminal: yarn add bootstrap. Lo cual descarga Bootstrap y lo guarda en la carpeta node_modules, actualización el archivo package.json para indicar que cuando alguien quiera volver a instalar éste proyecto tiene ue descargar, además de bootstrap, todas las dependencias que existe.
- Para inciar el servidor únicamente de los archivos de webpack , ejectuar en terminal: ./bin/webpack-dev-server
- Utilizar los ayudantes, métodos de ayuda de la vista de Ruby on Rails, métodos  de Ruby definidos en el frameworks que nos permite construir HTML.
- Una forma de guardar texto enriquecido es action_text. Ejecutar en terminal: rails action_text:install.
Action-text provee dos cosas, un editor de txto-trix, y un lugar para guardar el texto enriquecido.
- Para autenticación: gema 'idear'
- Aplicando strong_params
-  Arquitetura REST
- Utilizando Scaffold de Categorías. los rieles generan andamios, es un generador para el CRUD de un recurso llamado categorías.
- Versión Ruby '2.7.0'
- DB: sqlit3, pronto configurar PostgreeSQL.

El Blog presenta un inicio, artículos, comentarios de los artículos, perfil con imagen, escribir, editar, actualizar. Un perfil de usuario, autenticación para modificar, crear, actualizar, etc., Inicio de sesión, Cierres de sesión, Registro, etc.
- A continuación, Home;

![captura1](https://github.com/fernanluis/Blog/blob/master/home.png)

-  Articles, index:
![captura2](https://github.com/fernanluis/Blog/blob/master/articles.png)

- Ecribir articulos:
![captura3](https://github.com/fernanluis/Blog/blob/master/create_article.png)

- Perfil:
![captura4](https://github.com/fernanluis/Blog/blob/master/perfil.png)

- Crear Usuario:
![captura5](https://github.com/fernanluis/Blog/blob/master/create_user.png)

- Iniciar sesión:
![captura6](https://github.com/fernanluis/Blog/blob/master/iniciar_sesion.png)

- Mostrar articulos:
![captura 7](https://github.com/fernanluis/Blog/blob/master/show.png)

-  Categorias:
![captura8](https://github.com/fernanluis/Blog/blob/master/categories.png)

- Categoria_id:
![captura9](https://github.com/fernanluis/Blog/blob/master/categories_id.png)

- Crear categoria:
![captura11](https://github.com/fernanluis/Blog/blob/master/category_new.png)

- Editar categoríaías;
![captura 12](https://github.com/fernanluis/Blog/blob/master/category_edit.png)

# Aún quedan funcionalidas por desarrollar y mucho por aprender cláramente.
