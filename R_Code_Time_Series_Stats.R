# Install the following packages if you have not already:
install.packages('raster')
install.packages('sp')
install.packages('rgdal')

# Once or if the packages are installed, then load them into R:
library(raster)
library (sp)
library(rgdal)

# Set your working directory:
setwd('C:/Directory')

# Read in your multi-band satellite imagery stack:
# Each band should represent a different image collected from a different time/date:
Imagery <- stack('Imagery.tif')

# Alternatively, you can read in each satellite image individually:
Img1 <- raster("Image_01.tif")
Img2 <- raster("Image_02.tif")
Img3 <- raster("Image_03.tif")
Img4 <- raster("Image_04.tif")

# Stack (composite) your time-series of images into one multi-band raster, if you loaded them individually:
ImgComp <- stack(Img1, Img2, Img3, Img4)

# Calculate various time-series statistics on your image stack:
TimeSeries_Mean <- calc(ImgComp, fun = mean)
TimeSeries_STD <- calc(ImgComp, fun = sd)
TimeSeries_CV <- calc(ImgComp, fun = cv)
TimeSeries_Min <- calc(ImgComp, fun = min)
TimeSeries_Max <- calc(ImgComp, fun = max)
TimeSeries_Median <- calc(ImgComp, fun = median)

# Stack your derived time-series statistics back into one multi-band raster:
TimeSeries_Raster <- stack(TimeSeries_Mean, TimeSeries_STD, TimeSeries_CV, TimeSeries_Min, TimeSeries_Max, TimeSeries_Median)

# View/plot your time-series statistical rasters:
plot(TimeSeries_Raster)

# Export your time-series raster as a decimal floating point raster: 
writeRaster(TimeSeries_Raster, 'C:/TimeSeries_Raster.tif', datatype= 'FLT4S')
