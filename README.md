# Debris Fishing

## Project Title

Debris Fishing

## Summary

A huge number of satellites in Earth's orbit support our day-to-day life on the ground. However, satellites are constantly under the threat of space debris. We have made it possible for people to learn about the threat of space debris through the experience of fishing, comparing space debris floating in space to fish in the ocean.

## How I Addressed This Challenge

Space debris is increasing year by year, and satellites are constantly under the threat of space debris. We have developed a system that allows us to learn about the threat of space debris through the experience of fishing, comparing space debris floating in space to fish in the ocean.

The system consists of two applications.

The first is a space debris simulator. It simulates the effect of more than 100 million pieces of debris, including tiny untraceable ones, and visualize them as fish swimming in the ocean. This allows us to learn about the threat of debris numbers.

The second is a virtual fishing application. Using a device with a modified reel, we can experience "fishing". The number of times you need to reel in to catch a target is proportional to the kinetic energy of the target. You can compare the kinetic energy of the debris to that of a swimming fish. This allows us to learn about the threat of debris impact.

Our goal is to create a trend in the world to get serious about reducing space debris through this system.

## How I Developed This Project

From the orbit information of tracked space debris, the debris distribution was determined and the number of debris affecting the ISS was determined. Using these parameters, the motion of the debris, including small untracked objects, was simulated and visualized using Processing.
The virtual fishing application read the operation of the reel device and animated it in conjunction with the operation.

## How I Used Space Agency Data in This Project

From the trajectory information of the tracked space debris, the distribution of space debris was investigated and reflected in the parameters of the space debris simulator.

## Project Demo

https://drive.google.com/file/d/1mifvply8zOekq_85St42-tfdOxS7MFSj/view?usp=sharing

## Project Code

https://github.com/saco-2020/SpaceHungry

## Data & Resources

- SPACEBIRDS
  - https://worldwind.arc.nasa.gov/spacebirds/
  - https://worldwind.arc.nasa.gov/spacebirds/data/TLE.json
- Orbital Debris Quarterly News, Volume 24, Issue 2, April 2020
  - https://orbitaldebris.jsc.nasa.gov/quarterly-news/pdfs/odqnv24i2.pdf
- 出典：国土地理院ウェブサイト
  - https://maps.gsi.go.jp/development/tilejump.html#seamlessphoto/9/455/201
  - データソース：Landsat8画像（GSI,TSIC,GEO Grid/AIST）, Landsat8画像（courtesy of the U.S. Geological Survey）, 海底地形（GEBCO）

## Tags
#debris, #processing, #simulator
