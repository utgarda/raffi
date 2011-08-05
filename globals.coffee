w = window
w.paper = Raphael("canvas", "100%", "100%")
w.width = "100%"
w.height = "100%"
c = paper.rect(0, 0, "100%", "100%", 0).attr
  fill: "#efefef"
  stroke: "none"
Raphael.getColor.reset()
w.cwidth = c.getBBox().width
w.cheight = c.getBBox().height

# math
w.abs = Math.abs
w.acos = Math.acos
w.asin = Math.asin
w.atan = Math.atan
w.ceil = Math.ceil
w.cos = Math.cos
w.exp = Math.exp
w.floor = Math.floor
w.log = Math.log
w.max = Math.max
w.min = Math.min
w.pi = Math.PI
w.pow = Math.pow
w.random = Math.random
w.round = Math.round
w.sin = Math.sin
w.sqrt = Math.sqrt
w.tan = Math.tan

# raphael
w.circle = (x,y,r) ->
  paper.circle(x,y,r)
w.rect = (x,y,w,h,r) ->
  paper.rect(x,y,w,h,r)
w.ellipse = (x,y,rx,ry) ->
  paper.ellipse(x,y,rx,ry)
w.image = (url,x,y,w,h) ->
  paper.image(url, x, y, w, h)
w.text = (x,y,str) ->
  paper.text(x,y,str)
w.path = (str) ->
  paper.path(str)
w.getColor =-> Raphael.getColor()
w.set = paper.set
w.clear = paper.clear

# axis, tics, labels
w.createAxis = (width,height,ticwidth) ->
  if (width == "100%")
    width = cwidth
  if (height == "100%")
    height = cheight
  axis = set()
  grid = set()
  labels = set()
  o = [40, height-40]
  ox = [width-40, 40]
  axis.push path "M" + o[0] + " " + o[1] + "L" + ox[0] + " " + o[1] 
  axis.push path "M" + o[0] + " " + o[1] + "L" + o[0] + " " + o[0] 
  tic = (x,y,w,h) ->
    p1 = [x, y]
    p2 = [x-w, y+h]
    path "M" + p1[0] + " " + p1[1] + "L" + p2[0] + " " + p2[1]
  xtics = set()
  ytics = set()
  xmarks = Math.ceil( width / ticwidth)
  ymarks = Math.ceil( height / ticwidth)
  for i in [1..xmarks]
    inc= i * ticwidth
    grid.push path "M" + inc + " 0L" + inc + " " + height
  for i in [1..ymarks]
    inc= i * ticwidth
    grid.push path "M0 " + inc + "L" + width + " " + inc
  for i in [0..xmarks-3]
    inc= 40+i*ticwidth
    if i % 2 == 1
      xtics.push tic(inc,height-40,0,8)
    else
      xtics.push tic(inc,height-40,0,12)
      labels.push text(inc,height-16,inc + "")
  for i in [0..ymarks-4]
    inc= 40+i*ticwidth
    if i % 2 == 1
      ytics.push tic(40,height-inc,8,0)
    else
      ytics.push tic(40,height-inc,12,0)
      labels.push text(14,height-inc,inc + "")
  axis.push xtics
  axis.push ytics

  # axis defaults
  axis.attr stroke: "#aaa"
  grid.attr stroke: "#e0e0e0"
  labels.attr stroke: "#666"
  
  return { axis, grid, labels }

# duration syntactic sugar
Raphael.el.anim = (obj) ->
  if (obj.duration != undefined)
    duration = obj.duration
    delete obj.duration
    this.animate(obj, duration)
  else
    this.animate(obj)

w.randomPath = (length, j, dotsy) ->
  random_path = ""
  x = 10
  y = 0
  dotsy[j] = dotsy[j] || []
  for i in [0..length]
    dotsy[j][i] = round(random() * 200)
    if (i)
      random_path += "C" + [x + 10, y, (x += 20) - 10, (y = 240 - dotsy[j][i]), x, y]
    else
      random_path += "M" + [10, (y = 240 - dotsy[j][i])]
  return random_path
