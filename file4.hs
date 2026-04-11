data Hero = Hero 
  {
    heroName :: HeroName2
    , heroElement :: Element
    , heroLevel :: Level 
    , heroStats :: HeroStats
  }

data Element = Fire | Ice | Lightning | Arcane
data HeroClass = Warrior | Mage | Healer | Rogue
data Rarity = Common | Rare | Legendary
data HeroStats = HeroStats HeroClass Rarity
data HeroName2 = SimpleName String | NameWithTitle String String

type HeroFilter = Hero -> Bool
type HeroName = String
type Title = String
type Level = Int 
type ClassName = String
type HeroIdentity = (HeroName, Title)
newtype HeroNameNT = HeroNameNT String
newtype TitleNT = TitleNT String

greetNT :: HeroNameNT -> TitleNT -> String
greetNT (HeroNameNT n) (TitleNT t) = 
  n ++ ", " ++ t "!" 

isLegendary :: HeroFilter
isLegendary hero = 
  case heroStats hero of 
    HeroStats _ Legendary -> True
    _ -> False

--isFire :: HeroFilter
--isFire hero = heroElement hero == Fire

greet :: HeroName -> Title -> String
greet n t = n ++ ", " ++ t ++ "!"

myHero = Hero { heroName = NameWithTitle "Diluc" "Darknight Hero"
  , heroLevel = 90
  , heroStats = HeroStats Warrior Legendary
  , heroElement = Fire}


myHero2 = Hero (SimpleName "Amber")
  Fire 40 (HeroStats Warrior Rare)

getElement :: Hero -> Element
getElement (Hero _ e _ _) = e 

getLevel :: Hero -> Int 
getLevel (Hero _ _ l _) = l

showHeroName2 :: HeroName2 -> String
showHeroName2 (SimpleName n) = n 
showHeroName2 (NameWithTitle n t) = n ++ " " ++ t

showHeroClass :: HeroClass -> String
showHeroClass Warrior = "Warrior"
showHeroClass Mage = "Mage"
showHeroClass Healer = "Healer"

showHeroRarity :: Rarity -> String
showHeroRarity Common = "Common"
showHeroRarity Rare = "Rare"
showHeroRarity Legendary = "Legendary"

showHeroStats :: HeroStats -> String 
showHeroStats (HeroStats cls rarity) =
  showHeroRarity rarity ++ showHeroClass cls 

elementSymbol :: Element -> Char
elementSymbol Fire = 'F'
elementSymbol Ice = 'I'
elementSymbol Lightning = 'L'
elementSymbol Arcane = 'A'

getHeroName :: HeroIdentity -> HeroName
getHeroName hero = fst hero

getHeroTitle :: HeroIdentity -> Title
getHeroTitle hero = snd hero

heroCard :: HeroName -> Title -> Level -> ClassName -> String
heroCard hname title lvl cls = hname ++ " " ++ title
  ++ " [" ++ show lvl ++ "] " ++ cls