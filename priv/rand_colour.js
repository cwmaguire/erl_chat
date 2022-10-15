var colours = [
  'Absolutezero',
  'AcidGreen',
  'Aero',
  'AfricanViolet',
  'AirSuperiorityBlue',
  'AliceBlue',
  'Alizarin',
  'AlloyOrange',
  'Almond',
  'AmaranthDeepPurple',
  'AmaranthPink',
  'AmaranthPurple',
  'Amazon',
  'Amber',
  'Amethyst',
  'AndroidGreen',
  'AntiqueBrass',
  'AntiqueBronze',
  'AntiqueFuchsia',
  'AntiqueRuby',
  'AntiqueWhite',
  'Apricot',
  'Aqua',
  'Aquamarine',
  'ArcticLime',
  'ArtichokeGreen',
  'ArylideYellow',
  'AshGray',
  'AtomicTangerine',
  'Aureolin',
  'Azure',
  'BabyBlue',
  'BabyBlueEyes',
  'BabyPink',
  'BabyPowder',
  'Baker-MillerPink',
  'Bananamania',
  'BarnRed',
  'BattleshipGrey',
  'BeauBlue',
  'Beaver',
  'Beige',
  'BdazzledBlue',
  'BigDipO’ruby',
  'Bisque',
  'Bistre',
  'BistreBrown',
  'BitterLemon',
  'Black',
  'BlackBean',
  'BlackCoral',
  'BlackOlive',
  'Blackshadows',
  'BlanchedAlmond',
  'Blast-offBronze',
  'BleuDefrance',
  'BlizzardBlue',
  'BloodRed',
  'Blue',
  'BlueBell',
  'Blue-gray',
  'BlueJeans',
  'BlueSapphire',
  'Blue-violet',
  'BlueYonder',
  'Bluetiful',
  'Blush',
  'Bole',
  'Bone',
  'BrickRed',
  'BrightLilac',
  'BrightMaroon',
  'BrightNavyBlue',
  'Bronze',
  'BrownSugar',
  'BudGreen',
  'Buff',
  'Burgundy',
  'Burlywood',
  'BurnishedBrown',
  'BurntOrange',
  'BurntSienna',
  'BurntUmber',
  'Byzantine',
  'Byzantium',
  'CadetBlue',
  'CadetGrey',
  'CadmiumGreen',
  'CadmiumOrange',
  'CaféAuLait',
  'CaféNoir',
  'CambridgeBlue',
  'Camel',
  'CameoPink',
  'Canary',
  'CanaryYellow',
  'CandyPink',
  'Capri',
  'Cardinal',
  'CaribbeanGreen',
  'Carmine',
  'CarnationPink',
  'Carnelian',
  'CarolinaBlue',
  'CarrotOrange',
  'Catawba',
  'Cedarchest',
  'Celadon',
  'Celeste',
  'Cerise',
  'Cerulean',
  'CeruleanBlue',
  'CeruleanFrost',
  'Champagne',
  'ChampagnePink',
  'Charcoal',
  'CharmPink',
  'CherryBlossomPink',
  'Chestnut',
  'ChiliRed',
  'ChinaPink',
  'ChineseRed',
  'ChineseViolet',
  'ChineseYellow',
  'Cinereous',
  'Cinnabar',
  'Cinnamonsatin',
  'Citrine',
  'Citron',
  'Claret',
  'Coffee',
  'Columbiablue',
  'CongoPink',
  'CoolGrey',
  'Copper',
  'CopperPenny',
  'CopperRed',
  'CopperRose',
  'Coquelicot',
  'Coral',
  'CoralPink',
  'Cordovan',
  'Corn',
  'CornflowerBlue',
  'Cornsilk',
  'CosmicCobalt',
  'CosmicLatte',
  'CoyoteBrown',
  'CottonCandy',
  'Cream',
  'Crimson',
  'Cultured',
  'Cyan',
  'CyberGrape',
  'CyberYellow',
  'Cyclamen',
  'DarkBrown',
  'DarkByzantium',
  'DarkCyan',
  'DarkElectricBlue',
  'DarkGoldenrod',
  'DarkJungleGreen',
  'DarkKhaki',
  'DarkLava',
  'DarkMagenta',
  'DarkOliveGreen',
  'DarkOrange',
  'DarkOrchid',
  'DarkPurple',
  'DarkRed',
  'DarkSalmon',
  'DarkSeaGreen',
  'DarkSienna',
  'DarkSkyBlue',
  'DarkSlateBlue',
  'DarkSlateGray',
  'DarkSpringGreen',
  'DarkTurquoise',
  'DarkViolet',
  'DavysGrey',
  'DeepCerise',
  'DeepChampagne',
  'DeepChestnut',
  'DeepJungleGreen',
  'DeepPink',
  'DeepSaffron',
  'DeepSkyBlue',
  'Deepspacesparkle',
  'DeepTaupe',
  'Denim',
  'DenimBlue',
  'Desert',
  'DesertSand',
  'DimGray',
  'DodgerBlue',
  'Drab',
  'DrabDarkBrown',
  'DukeBlue',
  'DutchWhite',
  'Ebony',
  'Ecru',
  'EerieBlack',
  'Eggplant',
  'Eggshell',
  'ElectricLime',
  'ElectricPurple',
  'ElectricViolet',
  'Emerald',
  'Eminence',
  'EnglishLavender',
  'EnglishRed',
  'EnglishVermillion',
  'EnglishViolet',
  'Erin',
  'EtonBlue',
  'Fallow',
  'FaluRed',
  'Fandango',
  'FandangoPink',
  'Fawn',
  'FernGreen',
  'FieldDrab',
  'FieryRose',
  'Finn',
  'Firebrick',
  'FireEngineRed',
  'Flame',
  'Flax',
  'Flirt',
  'FloralWhite',
  'FrenchBeige',
  'FrenchBistre',
  'FrenchBlue',
  'FrenchFuchsia',
  'FrenchLilac',
  'FrenchLime',
  'FrenchMauve',
  'FrenchPink',
  'FrenchRaspberry',
  'FrenchSkyBlue',
  'FrenchViolet',
  'Frostbite',
  'Fuchsia',
  'Fulvous',
  'Fuzzywuzzy'];

function random_colour(){
  let len = colours.length;
  let rand = Math.floor(Math.random() * len);
  return colours[rand];
}

