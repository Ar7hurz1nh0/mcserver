# from .optimizeimages import pngnq, optipng

basepath = "/mnt/d/etec/cdmd+1.19"
WORLD = "CALL DOS MULEKE DOIDO"
worlds[WORLD] = basepath + "/world"

renders["overworld_nw"] = {
    "world": WORLD,
    "title": "Overworld NW",
    "rendermode": smooth_lighting,
    "imgformat": "webp",
    "imgquality": 70,
    "defaultzoom": 1,
    "northdirection": "upper-right"
}

renders["overworld_ne"] = {
    "world": WORLD,
    "title": "Overworld NE",
    "rendermode": smooth_lighting,
    "imgformat": "webp",
    "imgquality": 70,
    "defaultzoom": 1,
    "northdirection": "upper-left"
}

renders["nether"] = {
    "world": WORLD,
    "title": "Nether",
    "rendermode": nether_smooth_lighting,
    "dimension": "nether",
    "imgformat": "webp",
    "imgquality": 70,   
    "defaultzoom": 1,
}

renders["end"] = {
    "world": WORLD,
    "title": "end",
    "rendermode": [Base(), EdgeLines(), SmoothLighting(strength=0.5)],
    "dimension": "end",
    "imgformat": "webp",
    "imgquality": 70,   
    "defaultzoom": 1,
}

# processes = 12
outputdir = basepath + "/mcmap"
texturepath = basepath + "/versions/1.19/client-1.19.jar"   