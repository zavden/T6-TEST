git clone https://github.com/zavden/docs-static.git docs
rm -rf docs/.git
mkdir -p src/ejercicios/ docs/ejercicios/ templates/ejemplo src/markdown/
mkdir -p templates/markdown docs/markdown/ src/static
mkdir -p modules/pug/blocks modules/pug/functions modules/pug/mixins modules/pug/static
npm install --save-dev jstransformer-markdown-it pug-cli typescript live-server sass
echo 'node_modules/' > .gitignore
# Templates
echo '-
    const n_ej = 1

    const range = (start, end) => {
        if(start >= end) return [start]
        return [start, ...range(start + 1, end)]
    }
    const zeroPad = (num, places) => String(num).padStart(places, 0)

    const list_ej = range(1,n_ej)
    let lista_ejercicios = []
    list_ej.forEach(e => lista_ejercicios.push(zeroPad(e,2)))

    const zip_arrs = (arr1, arr2) =>{
        const new_arr = []
        for(let i=0; i<arr1.length; i++){
            let ar = [arr1[i], arr2[i]]
            new_arr.push(ar)
        }
        return new_arr
    }
' > modules/pug/functions/functions.pug
echo 'extends /modules/pug/blocks/ejercicios
block pug_javascript
    -
        let titulo = "Ejemplo NL",
            formato = ""
        let codepen_list = [
            "vYEPxPX",
            "BaybRKr",
        ]
        nej = NL // <== EXERCISE NUMBER - REPLACE IT
block pug_styles
    +new_style(`../styles.css`)
block html_javascript
    +new_script(`../scripts.js`)
block pug_contenido
    +codepen(1)
    +codepen_url("jONXGLy",2,height_window=600)
    +html_emb_ej("ej-01")
//-
    p=String.raw`$$ x^5 $$`
    each url in codepen_list
        +codepen_url(url,`${codepen_list.indexOf(url)+1}`,height_window=600)
' > templates/ejercicios.pug

echo 'doctype
html
    head
        title Ejemplo
        link(rel="stylesheet" href="styles.css")

    body
        p.title.
            Este es un iframe, debe ser rojo y grande,
            los estilos vienen de SASS.
        p#subtitle.
            Este es un subtítulo, debe ser rosa,
            el estilo debe venir de TS.

        script(src="script.js")
'> templates/ejemplo/index.pug

echo '.title {
    color: red;
    font-size: 2em;
}
'> templates/ejemplo/styles.scss

echo '(function() {
    const subtitle = document.getElementById("subtitle")
    subtitle.style.color= "pink"
})()
'> templates/ejemplo/script.ts
# src files
echo '* {
    box-sizing: border-box;
}
#titulo{
    border: 2px dotted black;
    margin-left: auto;
    text-align: center;
    margin-right: auto;
}
body{
    background: #ff9966; 
    background: linear-gradient(to right, rgba(217,89,0,1), rgba(255,179,107,1));
    font-size: 1.3rem;
    font-family: Arial, Helvetica, sans-serif;
}
.contenido{
    background-color: white;
    min-height: calc( 100vh - 20px );
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 30px 0 30px;
}
a {
    text-decoration: none;
    color: white;
}
[href^="http"]{
    background-color: red;
    padding: 10px;
    border-radius: 10px 30px;
}
.link-ejercicios{
    background-color: teal;
    padding: 10px;
    border-radius: 10px 30px;
}
.menu-nav{
    display: flex;
    justify-content: center;
    text-align: center;
    & a{
       flex:1;
       background-color: steelblue;
       //padding-top: 20px;
       //padding-bottom: 20px;
       padding: 20px;
    }
    & a:hover {
        background-color: purple;
    }
}
code{
    background-color: rgba(254,209,206,1);
    display: inline-block;
    font-size: 0.9em;
    padding: 0.2rem 0.2rem;
    border: thin solid red;
    pre & {
        background-color: black;
        color:white;
        display:block;
        padding: 20px 40px;
        border: thin dotted black;
        border-radius: 0;
    }
}
.header{
    background-color: #fb6f66;
    border-radius: 0;
    font-size:2.5rem
}
.formula {
    font-size: 150%;
}
.ejercicio {
    font-size: 140%;
    font-weight: bold;
    margin-top: 0.83em;
    margin-bottom: 0.83em;
    margin-left: 0;
    margin-right: 0;
}
img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    min-width: 45em;
}
// -----------------

#write {
    counter-reset: h1
}

h1 {
    counter-reset: h2
}

h2 {
    counter-reset: h3
}

h3 {
    counter-reset: h4
}

h4 {
    counter-reset: h5
}

h5 {
    counter-reset: h6
}

/** put counter result into headings */
h1:before {
    counter-increment: h1;
}

h2:before {
    counter-increment: h2;
    content: counter(h2) ". "
}

h3:before,
h3.md-focus.md-heading:before /** override the default style for focused headings */ {
    counter-increment: h3;
    content: counter(h2) "." counter(h3) ". "
}

h4:before,
h4.md-focus.md-heading:before {
    counter-increment: h4;
    content: counter(h2) "." counter(h3) "." counter(h4) ". "
}

h5:before,
h5.md-focus.md-heading:before {
    counter-increment: h5;
    content: counter(h2) "." counter(h3) "." counter(h4) "." counter(h5) ". "
}

h6:before,
h6.md-focus.md-heading:before {
    counter-increment: h6;
    content: counter(h2) "." counter(h3) "." counter(h4) "." counter(h5) "." counter(h6) ". "
}

/** override the default style for focused headings */
h3.md-focus:before,
h4.md-focus:before,
h5.md-focus:before,
h6.md-focus:before,
h3.md-focus:before,
h4.md-focus:before,
h5.md-focus:before,
h6.md-focus:before {
    color: inherit;
    border: inherit;
    border-radius: inherit;
    position: inherit;
    left:initial;
    float: none;
    top:initial;
    font-size: inherit;
    padding-left: inherit;
    padding-right: inherit;
    vertical-align: inherit;
    font-weight: inherit;
    line-height: inherit;
}
// -----------------
.embed-container {
    position: relative;
     /* set the aspect ratio here as (height / width) * 100% */
    height: 0;
    overflow: hidden;
    max-width: 100%;
}
   
.embed-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
}

.html-resize {
    resize: both;
    overflow: auto;
    border: solid gray;
    border-width: thin;
}

.menu-nav .remark-ej{
    background-color: lightseagreen;
}
' > src/styles.scss
echo 'extends /modules/pug/blocks/index
block pug_javascript
    -
        let titulo = "INDEX",
            formato = "CSS-A-"
block pug_styles
    +new_style(`styles.css`)
block html_javascript
    +new_script(`scripts.js`)
block pug_contenido
    +ejercicios("01","Animaciones básicas")
    :markdown-it(html)
        ## Este es un título.

        ## Esto es cóigo de bloque:
        ```python
        from manimlib.imports import *
        self.play(Write("Hola mundo"))
        ```

        Esto es un `codigo` en linea.

        ## Esta es una fórmula
        $$\Large
            \lim_{n\to\infty}\sum_{i=0}^{n}f\left(a+\frac{i(b-a)}{n}\right)\left(\frac{b-a}{n}\right) = \int_a^b f(x)
        $$

        Esta es una imagen:      
        ![Ejemplo](./static/e1-1.png)
    +img("im1.jpg")
' > src/index.pug

# docs
echo '(function(){
    const titulo = document.getElementById("titulo")
    titulo.style.color = "red"
    titulo.addEventListener("click",()=>alert("Hiciste click en el título"))
})()
' > src/scripts.ts

# modules
#-------------PUG
#-------------------INDEX
echo 'include /modules/pug/functions/functions
include /modules/pug/mixins/mixins
block pug_javascript
doctype
html
    head
        title=`${titulo}`
        include /modules/pug/static/meta_static
        block pug_styles
        link(rel="stylesheet" href="prism/prism.css")
        link(rel="icon" href="favicon.ico")
    body
        .contenido
            h1#titulo=`${titulo}`
            .menu-nav
                a(href="#downer").remark-ej=`Index`
                +menu_nav_index(...lista_ejercicios)
            block pug_contenido
            hr
            .menu-nav#downer
                a(href="#titulo").remark-ej=`Index`
                +menu_nav_index(...lista_ejercicios)
        block html_javascript
        include /modules/pug/static/js_static
        script(src="prism/prism.js")
' > modules/pug/blocks/index.pug
#-------------------EJERCICIO
echo 'include /modules/pug/functions/functions
include /modules/pug/mixins/mixins
block pug_javascript
doctype
html
    head
        title=`${titulo}`
        include /modules/pug/static/meta_static
        block pug_styles
        link(rel="stylesheet" href="../prism/prism.css")
        link(rel="icon" href="../favicon.ico")
    body
        .contenido
            h1#titulo=`${titulo}`
            .menu-nav
                a(href="../index.html")=`Index`
                +menu_nav(...lista_ejercicios)
            code.header(style="text-align:center; display:block")
                a(href="#downer")=`${formato}`
            block pug_contenido
            hr
            code.header(style="text-align:center; display:block")
                a(href="#titulo")=`${formato}`
            .menu-nav#downer
                a(href="../index.html")=`Index`
                +menu_nav(...lista_ejercicios)
        block html_javascript
        include /modules/pug/static/js_static
        script(src="../prism/prism.js")
' > modules/pug/blocks/ejercicios.pug


echo '//- include /modules/pug/functions/functions
-
    let title = undefined,
        codepen_user = "zavden"
mixin codepen(index,height_window=310,user=codepen_user)
    -let url = codepen_list[index-1]
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${index}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
mixin codepen_url(url,text="",height_window=310,user=codepen_user,editable="true")
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
mixin ejercicios(url,nombre="",explicacion="")
    .ejercicio #[a(href=`ejercicios/ejercicios-${url}.html` class="link-ejercicios")=`Ejercicio ${url}`]#[span=` - ${nombre}`] 
        p=`${explicacion}`
mixin new_style(url)
    link(rel="stylesheet" href=url)
mixin new_script(url)
    script(src=url)
mixin menu_nav(...arr_ejercicios)
    each ej in arr_ejercicios
        if ej == nej
            if title === undefined
                a(href=`ejercicios-${ej}.html`).remark-ej=`Ej-${ej}`
            else
                a(href=`ejercicios-${ej}.html`).remark-ej=`${title}`
        else
            if title === undefined
                a(href=`ejercicios-${ej}.html`)=`Ej-${ej}`
            else
                a(href=`ejercicios-${ej}.html`)=`${title}`
mixin menu_nav_index(...arr_ejercicios)
    each ej in arr_ejercicios
        if ej == nej
            if title === undefined
                a(href=`ejercicios/ejercicios-${ej}.html`).remark-ej=`Ej-${ej}`
            else
                a(href=`ejercicios/ejercicios-${ej}.html`).remark-ej=`${title}`
        else
            if title === undefined
                a(href=`ejercicios/ejercicios-${ej}.html`)=`Ej-${ej}`
            else
                a(href=`ejercicios/ejercicios-${ej}.html`)=`${title}`
mixin html_emb_ej(name,padding="300px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=`../ejemplos/${name}/` frameborder="0" allowfullscreen)
mixin html_emb(name,padding="300px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=name frameborder="0" allowfullscreen)
mixin img(src)
    img(src=`./static/${src}` style=`width: 100%`)
mixin img_path(src)
    img(src=`${src}` style=`width: 100%`)
mixin img_e(src)
    img(src=`../static/${src}` style=`width: 100%`)
mixin md_emb(number,padding="1000px")
    .embed-container(style=`padding-bottom: ${padding};`).html-resize
        iframe.html-resize(src=`../markdown/md-${number}.html` frameborder="0" allowfullscreen)

mixin codepen_live(index,height_window=310,user=codepen_user)
    -let url = codepen_list[index-1]
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${index}`
    p(class="codepen" data-height=`${height_window}` 
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      data-editable="true"
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)
mixin codepen_url_live(url,text="",height_window=310,user=codepen_user,editable="true")
    .ejercicio
        a(href=`https://codepen.io/${user}/pen/${url}`)=`Ejercicio ${text}`
    p(class="codepen" data-height=`${height_window}` 
      data-editable="true"
      data-theme-id="default" data-default-tab="css,result" 
      data-user=user data-slug-hash=`${url}` 
      style=`height: ${height_window}px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;`)


' > modules/pug/mixins/mixins.pug
echo 'script(async src="https://static.codepen.io/assets/embed/ei.js")
script(defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js" integrity="sha384-y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz" crossorigin="anonymous")
script(defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous")
script.
    document.addEventListener("DOMContentLoaded", function() {
        renderMathInElement(document.body, {
              delimiters: [
                  {left: "$$", right: "$$", display: true},
                  {left: "\\[", right: "\\]", display: true},
                  {left: "$", right: "$", display: false},
                  {left: "\\(", right: "\\)", display: false}
              ]
        });
    });
' > modules/pug/static/js_static.pug

echo 'meta(cjarset="UTF-8")
meta(name="viewport" content="width=device-width, initial-scale=1.0")
meta(http-equiv="X-UA-Compatible" content="ie=edge")
link(rel="stylesheet" href="https://necolas.github.io/normalize.css/8.0.0/normalize.css")
link(rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css" integrity="sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq" crossorigin="anonymous")
' > modules/pug/static/meta_static.pug

echo '
{
  "compilerOptions": {
    "target": "ES2018",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "strictNullChecks":false,
    "forceConsistentCasingInFileNames": true, 
    "outDir": "docs/",
    "rootDir": "src/",
  },
  "exclude": ["templates","node_modules", "**/*.spec.ts"],
}
' > tsconfig.json

echo '<p style="text-decoration-line: underline overline; text-align:center; font-size: 4em; text-underline-offset: 20px"> Título</p>

# Primer titulo

![imagen](../static/e1-1.png)
' > templates/markdown/md.md

echo '-
    const n_ej = NE

    const range = (start, end) => {
        if(start >= end) return [start]
        return [start, ...range(start + 1, end)]
    }
    const zeroPad = (num, places) => String(num).padStart(places, 0)

    const list_ej = range(1,n_ej)
    let lista_ejercicios = []
    list_ej.forEach(e => lista_ejercicios.push(zeroPad(e,2)))

    const zip_arrs = (arr1, arr2) =>{
        const new_arr = []
        for(let i=0; i<arr1.length; i++){
            let ar = [arr1[i], arr2[i]]
            new_arr.push(ar)
        }
        return new_arr
    }
' > templates/functions.pug

#----------------
make next-e
make next-h
make init
