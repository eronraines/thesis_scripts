### 
###
# This code pulls the potential vegetation pattern information for a set of spatial points
###
###
require(rgdal)
require(raster)
# this is the shapefile of FAO-UNESCO soil map, download ESRI shapfile, put in 
# directory, point here
NZ_PV <-raster("/Users/eronraines/Desktop/Chapter 3 data/lris-new-zealand-potential-vegetation-grid-version-GTiff (1)/new-zealand-potential-vegetation-grid-version.tif") 
# assigning spatial points to query the shapefile with
# these coordinates roughly relate the spatial extent of the Tararua Range as 
# observed using Google Earth Pro
# in WGS 1984
tar_x_coords <- c(175.687867,175.415374, 175.004008,175.083160,175.406016)
tar_y_coords <- c(-40.423299,-40.630564, -41.020848,-41.095103,-40.873529)
extent <- cbind(tar_x_coords,tar_y_coords) 
# this generates longitude/latitude values within the coordinates to call the 
# climate data from the Tararua Range
set.seed(1)
lon2 <- runif(1000000, min(tar_x_coords),max(tar_x_coords)) 
lat2 <- runif(1000000, min(tar_y_coords),max(tar_y_coords)) 
points<-cbind(lon2,lat2)
##
## this chunk manipulates points and soil map data
##
# converts points to formate that can query
pointtoplot <- data.frame(x=points[,1],y=points[,2]) 
pointtoplot <- SpatialPoints(cbind(x=points[,1],y=points[,2]),
                             proj4string = CRS("+proj=longlat +datum=WGS84 +no_
                                               defs +ellps=WGS84 +towgs84=0,0,0
                                               "))

combine_PV <-extract(NZ_PV,pointtoplot)












tab <-tabulate(combine$c.2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..2..)
ID <- c("1.	Kauri/northern broadleaved forest ",
        "2.	Rimu/tawa-kamahi forest",
        "3.	Kahikatea-pukatea-tawa forest",
        "4.	Matai-kahikatea-totara forest ",
        "5.	Kahikatea-matai/tawa-mahoe forest ",
        "6.	Matai-totara-kahikatea-rimu/broadleaf-fuchsia forest",
        "7.	Hall’s totara/broadleaf forest",
        "8.	Hall’s totara/silver beech–kamahi–southern rata forest ",
        "9.	Hall’s totara-miro-rimu/kamahi-silver beech-southern rata forest",
        "10.	Hall’s totara-miro/kamahi-southern rata-broadleaf forest",
        "11.	Kahikatea-totara forest",
        "12.	Rimu-miro/kamahi-red beech-hard beech forest",
        "13.	Rimu-miro/tawari-red beech-kamahi-tawa forest",
        "14.	Rimu-matai-miro-totara/kamahi forest",
        "15.	Rimu-miro-totara/kamahi forest",
        "16.	Silver beech forest",
        "17.	Red beech-silver beech forest",
        "18.	Black/mountain beech-red beech forest",
        "19.	Mountain beech forest",
        "20.	Matai-totara/black/mountain beech forest",
        "21.	Scrub, tussock-grassland, and herbfield above treeline",
        "22.	Low forest, woodland and shrubland below treeline",
        "23.	Wetland",
        "24.	Dunelands")
description <- c("northern North Island – kauri, kahikatea, rimu and/or totara emergent over a diverse canopy dominated by varying mixtures of taraire (most abundant at lower elevations and more northern sites), kohekohe (low to middle elevations) and tawa (lower elevations in the south, middle to higher elevations in the north). Other widespread tree species include hinau, pukatea, rewarewa, and miro. Puriri is locally abundant at lower elevations, particularly on alluvial surfaces, and towai is abundant at higher elevations. Tanekaha is locally abundant, particularly on disturbed sites.",
  "central and southern North Island – rimu, miro and totara with less frequent kahikatea and matai, emergent over a canopy dominated by tawa and kamahi with widespread hinau, rewarewa and mahoe. Pukatea is common, particularly in valley bottoms, and kohekohe is often abundant at lower elevations except in drier climates. Black beech is locally common, generally forming discrete enclaves on dry ridges as in hill-country north of Gisborne and inland from Wanganui.",
  "lowland alluvium and floodplains of North Island and northern and eastern South Island – generally consisting of abundant kahikatea with varying mixtures of other species. The most widespread of the latter include tawa and pukatea, while matai, rimu and totara are generally restricted to better-drained soils. Titoki and puriri are locally abundant, occurring in greatest numbers on poorly drained soils in the drier lowlands of the North Island. The abundance of all of these latter species may have been higher in pre-human forests that predicted here, given the greater ability of kahikatea to regenerate in disturbed or secondary forests, with the latter potentially over-represented in the compositional data from some highly modified landscapes. Kauri probably also once occurred in these forests in the north as far south as the northern Waikato and coastal Bay of Plenty.",
  "plains of Canterbury and inland Southland – abundant matai and kahikatea, the former more abundant on well-drained sites along with some totara, but the latter dominating on poorly-drained sites. Broad-leaved trees are much less abundant and are predicted to include titoki, tawa and maires on more northern sites, and tarata in dry climates, particularly in the eastern South Island. More local species included pokaka (poorly-drained sites), mahoe, broadleaf and fuchsia.",
  "dry dune land and low hill country in Hawkes Bay, Manawatu, Wairarapa and coastal Marlborough and Canterbury, including Banks Peninsula – scattered kahikatea and matai with occasional rimu and totara, emergent over a variable canopy of tawa, mahoe, titoki, hinau, maires, pukatea, and puriri. Tarata is locally abundant on Banks Peninsula, but titoki is rare and tawa, maires and puriri are absent.",
  "inland foothills and loess-mantled downs from south-Canterbury to Southland – matai, totara, kahikatea and rimu, with miro also common in the south, emergent over a canopy in which many broadleaved species typical of high rainfall climates are lacking, particularly from about the Otago Peninsula north. Broadleaf, fuchsia and tarata are the most common species, but kamahi is widespread in the south. Pokaka is locally abundant, particularly on poorly drained soils.",
  "montane sites lacking beech including the Hauhungaroa Range, southern Ruahine and northern Tararua Ranges, Taranaki, inland Marlborough, south Canterbury and Otago. Hall’s totara and kaikawaka are the most abundant conifers, although the latter is absent around Lake Taupo and in the northern Tararua Ranges – matai and mountain toatoa are more local. The canopy is dominated by broadleaf with local fuchsia and/or kamahi, although the latter is generally restricted to regions with wetter climates and is largely absent where dry föhn winds are a feature of the climate. ",
  "Buller and northern West Coast south to about the Taramakau River, mostly on the Paparoa and Victoria Ranges. Hall’s totara and kaikawaka emergent through a canopy of silver beech, kamahi and southern rata. Scattered rimu occur at the lowest elevations and mountain beech, broadleaf and pink pine are more common at higher elevations.",
  "extensive on terraces and lower hill slopes in high-rainfall climates of Westland and Fiordland from about the Mahitahi River south. Conifers such as rimu and miro are more abundant at lower elevations and on terraces, while Hall’s totara is more common at higher elevations. Silver beech is patchy in distribution in the north, but elsewhere grows in mixture with kamahi, southern rata, broadleaf, fuchsia, mountain beech and pokaka, the latter two particularly common on more poorly drained soils. ",
  "occurs in wet, steep hill country in the Westland beech gap. Scattered emergent conifers include Hall’s totara, which is ubiquitous, occasional rimu and miro that are more common at lower elevations, and kaikawaka, pink pine and mountain toatoa more common at higher elevations. The often dense broadleaved canopy is dominated by kamahi and southern rata along with abundant broadleaf and quintinia and occasional fuchsia and pokaka. Tall shrubs of Olearia, Brachyglottis and Dracophyllum become common close to the treeline.",
  "predicted to occur in inland, frost-prone basins in dry climate of Canterbury and eastern Otago that are now completely deforested. Most broadleaved and lowland conifer species are excluded by the severe minimum temperatures, and kahikatea, Hall’s totara and broadleaf are the only species predicted to occur in abundance. Matai may also have been present, but reliable information on its tolerance to extreme cold temperatures is lacking.",
  "lowland forests of wet, cool climates from the Grey Valley north to the Tararua and Aorangi Ranges, with local occurrences in north Taranaki. Scattered rimu, miro and Hall’s totara are emergent over a canopy dominated by kamahi, red beech, hard beech and/or silver beech, the latter particularly at higher elevation. Silver beech is of very restricted distribution in north Taranaki. Quintinia and southern rata are much less abundant than where beeches are absent, and mountain beech occurs locally, mostly on sites with skeletal, infertile, or poorly drained soils.",
  "northern hill-country particularly in the Urewera and western Raukumara Ranges, but with local occurrences further north on the Hapuakohe and Hunua Ranges. Rimu and miro occur as scattered individuals emergent over a canopy dominated by tawari, kamahi, tawa and beeches. Hard beech is widespread at lower elevation, including in the northern outliers, while red beech and silver beech are largely restricted to the Bay of Plenty, with the latter more abundant at higher elevations. ",
  "occurs on the tephra mantled plateau surrounding Lake Taupo, and on the ring-plains of the Tongariro and Taranaki volcanoes. Conifers are dominant with abundant rimu, miro and totara—matai and kahikatea are also widespread, reaching their greatest abundance on sites with sandy and poorly drained soils respectively. Kamahi is widespread in the understorey along with tawa, although the latter is excluded from depressions where cold air ponding leads to intense frost. Other widespread understorey species include hinau, black and white maires, fuchsia and mahoe.",
  "is widespread on terraces with moderately drained soils in beech-free parts of Westland, the Catlins, and on Stewart Island. Rimu, miro and totara are the most abundant conifers, while matai occurs on freely drained soils, and kahikatea on poorly drained soils. Kamahi is the most common tree species in the sub-canopy, along with southern rata, and scattered broadleaf, pokaka, fuchsia, tarata and quintinia. ",
  "occurs mostly in the southern South Island east of the main divide, but also forms almost pure treeline forests at higher elevation in the northern South Island and the Tararua Ranges. Silver beech is universally dominant with Hall’s totara widespread, generally in low numbers. Other conifers such as rimu, miro and kahikatea also occur sporadically at lower elevations in wet climates along with kamahi in the sub-canopy. Locally abundant species include red beech, mountain beech and broadleaf.",
  "widespread at lower to middle-elevations from the Maruia Valley to the Nelson Lakes, and in hill-country from the northern Kaimanawa Mountains to the southwestern Urewera Ranges. Although small numbers of emergent miro, rimu and totara are predicted to occur through much of this forest, red and silver beech are by far the dominant species. Mountain beech is widespread but in much lower numbers, and hard beech is very local. Kamahi is widespread but rarely abundant.",
  "occurs in the northern Ruahine Range, inland Marlborough, and inland parts of North Canterbury south to the Waimakariri River. Hall’s totara and kaikawaka are both present in low number, although the latter is more restricted in distribution. Red beech tends to be more abundant at lower elevations, but mountain beech becomes dominant towards treeline.",
  "is largely confined to sites east of major mountain ranges where dry föhn winds and cold temperatures produce highly stressful conditions, most notably around the South Island’s southern lakes, in inland Canterbury and those parts of the Kaimanawa Mountains that lie east of the Tongariro volcanoes. Silver beech, Hall’s totara, broadleaf and pokaka occur sporadically at lower elevations and/or where rainfall is higher, but mountain beech occurs alone on the most stress-prone sites.",
  "occurs at low to middle elevations in dry climates in eastern parts of both main islands. While black/mountain beech dominates the canopy, emergent conifers are widespread in low numbers and include matai, totara, kahikatea, and on wetter sites, rimu and miro. Pokaka is locally abundant on poorly drained soils.",
  "is most extensive about the South Island’s main divide, but significant areas also occur on the North Island’s volcanoes, and along the crests of the Kaimanawa Mountains and Ruahine and Tararua Ranges. New Zealand tree lines are lower by some 100-200 m than tree lines in equivalent climatic zones elsewhere (Wardle 1985) and giant snow tussocks and shrubs tend to occupy the resulting zone.  Large herbs (e.g., mountain flax, Ranunculus, Celmisia and Aciphylla) and low shrubs (e.g., Coprosma, Myrsine, Gaultheria, Dracophyllum, Lepidothamnus and snow totara) share dominance with the tussocks, especially in the lower part of the zone.  Beech tree lines tend to be abrupt, especially in the drier eastern mountains.  However, in wetter areas and where the tree line forest is non-beech (mostly mountain totara, cedar, southern rata and kamahi), the limit of tall trees tends to be lower yet again, and a highly diverse collection of small trees and shrubs forms a diffuse, often impenetrable forest-shrub zone.",
  " occurs in the drought- and frost-prone inland basins and wide river valleys of Marlborough, Canterbury and Otago. Available evidence suggests that low stature conifers such as bog-pine and mountain toatoa dominated on many sites, including older, poorer, and/or poorly drained soils on valley and basin floors, along with shrubs such as Dracophyllum and manuka.  Kanuka was probably dominant on dry outwash gravels, while more fertile soils supported open-canopied semi-deciduous woodland or low forest of small-leaved Olearia, Hoheria, Plagianthus and Sophora, with understoreys of Carmichaelia, small-leaved Coprosma, Discaria, Melicope, Myrsine, and numerous lianes. Grassland was largely confined to recent floodplains, but there were abrupt transitions to local herbaceous cover on saline and calcareous substrates. ",
  "widespread, but most extensive in the lowlands of Northland, Waikato, coastal Bay of Plenty, and Southland. Saltmarsh was dominant around estuaries and lagoons, with mangroves forming scrub to low forest communities on mudflats and estuarine channels north of approximately 38oS.  Elsewhere, jointed rush or oioi and various reeds, sedges, creeping herbs and chenopods form a wide range of communities from tall reed beds to open sparsely colonised mudflats. The lowland freshwater swamps dominated by raupo and flax that characterise so much of the lowland at present were probably of limited extent before forest clearance.  Many areas now in flax or raupo were originally in tall forested wetlands dominated by kahikatea, rimu, pokaka and/or puketea.  On highly acid wetland soils, low scrub of stunted manuka, bog pine, silver pine or small leaved coprosmas often dominated, with patches of restiad or sphagnum bogland in the poorest drained sites.  Vegetation on large raised bogs was generally dominated by restiads (Sporodanthus in the north; Empodisma in the south) together with Gleichenia fern, although manuka was nearly always present as scattered individuals or a stunted overstorey.",
  "widespread, but most extensive along the west coast of the North Island in Northland, Auckland, Waikato and Manawatu, and in coastal Canterbury and Southland.  Unstable fore-dunes were generally dominated by pingao and spinifex, while more stable dunes supported the sand tussock Austrofestuca littoralis. More stable areas supported a number of sprawling shrubs (Coprosma, Pimelia and Muehlenbeckia) and sand-binding herbs (Calystegia and Euphorbia).  With time these areas were probably invaded first by small tree species such as kanuka, manuka, ngaio and akeake, and then by larger species such as pohutukawa in the north and southern rata in wetter southern districts. With continued stability, such communities would have probably developed eventually into forest similar to that on adjacent landscapes. For example, pre-human forest at on the sand spit at Mangawhai contained totara, matai, lacebark (Hoheria sp.), maire and titoki (Enright & Anderson 1988)."
  
  )




table <-cbind(tab,ID,description)
colnames(table) <-c("count","plant type", "description")

write.csv(table,"/Users/eronraines/Desktop/Chapter 3 data/TAR_RANGE_PV.csv")
