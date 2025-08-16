# hack-club-transit-authority
Week 1 for Roulette!

Game Spins: Interface Based, Clicker, Urban

Gameplay:
Players start with a small amount of money, and have a short time between each round to click to generate power. The goal is to efficiently generate power through a combination of clicks and upgrades to their transit system.

Features:
Players upgrade 5 core system stats:
 - Capacity
 - Speed
 - Frequency
 - Reliability
 - Efficiency
Players use a windows xp style interface to navigate the different apps (power generation, transit apps, etc)

Upgrade System:
Prices of upgrades increase linearly with each level, starting at 50.
The maximum level for each stat is 10
Your system's level affects automatic power and money generation. It is determined by the lowest level upgrade of your system.

Power Generation Mechanics:
Each turn has a limited time for generating power.
Money Calculation:
  - Base money: level * 15
  - Bonus money: (powerGenerated - powerRequired) * 2

