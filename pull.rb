#!/Users/bwilson/.rvm/rubies/ruby-1.9.2-p290/bin/ruby

base_url = "http://image.eveonline.com/Character/CHARID_SIZE.jpg"

size = "128"
# id = 90896000

mine = [90895484]

id = 90895000

pages      = 10
num_images = 100
per_row    = 6

def write_page(url, characters, sidebar)

page = <<-eos
<head>
    <meta charset="utf-8">
    <title>Bootstrap, from Twitter</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
      b { color: #009; }
      td { text-align: center; }
    </style>
    <link href="http://twitter.github.com/bootstrap/assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="../assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
  </head>
  <body>

    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="/">Eve Mugshots</a>
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#top">Home</a></li>
              <li><a href="#about">About</a></li>
              <li><a href="#contact">Contact</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    
    <a id='top' />
    <div class="container">
      <div class='row'>
        <div class='span9'>
      #{characters}
        </div>
        <div class='span3'>
        #{sidebar}
        </div>
      </div>
  <h1 id='about'>About Eve Mugshots</h1>
  <p>Eve Mugshots is just my way of looking at a bunch of character images of other Eve Characters around that of my avatars.
  </body>
</html>
eos

  File.open(url,'w') {|f| f.write(page)}
end

links = "<ul class=' nav nav-tabs nav-stacked'>"
start = 0
pages.times do |j|
  page = "page_#{j.to_s}.html"
  links << "\n        <li><a href='#{page}'>#{(id + start).to_s} - #{(id + start + num_images).to_s}</a></li>"
  start += num_images
end

sidebar = links + "\n      </ul>"

write_page('index.html', sidebar, '')  

pages.times do |j|
  characters = "<h1>Characters #{id} - #{id + num_images}</h1><table>"
  num_images.times do |i|
    id += 1
    characters << "\n      </tr>\n      <tr>" if i % per_row == 0 and i != 0
    char_id = (mine.include?(id)) ? "<b>#{i + 1}) #{id}</>" : "#{i + 1}) #{id}"
    characters << "\n        <td><a href='#{base_url.gsub('CHARID', (id).to_s).gsub('SIZE','1024')}'><img src='#{base_url.gsub('CHARID', (id).to_s).gsub('SIZE',size)}' /></a><p>#{char_id}</p></td>"
  end
  page = "page_#{j.to_s}.html"
  write_page(page, "#{characters}</table>", sidebar)
end
