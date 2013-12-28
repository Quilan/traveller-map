class System < ActiveRecord::Base
  # attr_accessible :title, :body
  # attr_accessible is removed in rails 4 and replaced by strong parameters. Ask Joe if you don't know how to use this
  # attr_accessible :name, :col, :row, :size, :atmosphere, :temperature, :hydrographics, :population, :government, :law,
  #                 :starport, :tech, :bases, :trade_codes, :travel_code, :contraband, :notes, :links

  serialize :contraband
  serialize :trade_codes
  serialize :links
  serialize :bases
  WORLD_SIZES = {
    0 => "~800km",
    1 => "~1,600km",
    2 => "~3,200km",
    3 => "~4,800km",
    4 => "~6,400km",
    5 => "~8,000km",
    6 => "~9,600km",
    7 => "~11,200km",
    8 => "~12,800km",
    9 => "~14,400km",
    10 => "~16,000km"
  }
  WORLD_GRAVITIES = {
    0 => "Negligible",
    1 => "~0.05G",
    2 => "~0.15G",
    3 => "~0.25G",
    4 => "~0.35G",
    5 => "~0.45G",
    6 => "~0.7G",
    7 => "~0.9G",
    8 => "~1.0G",
    9 => "~1.25G",
    10 => "~1.4G"
  }

  def show_size
    return WORLD_SIZES[self.size]
  end
  def show_gravity
    return WORLD_GRAVITIES[self.size]
  end
  def size_risk
    if (self.size <= 6 || self.size >= 9 )
      return "yellow" 
    else
      return "green"
    end
  end
  def size_message
    if self.size <= 6
      return "WARNING: LOW-GRAVITY ENVIRONMENT"
    elsif self.size >= 9
      return "WARNING: HIGH-GRAVITY ENVIRONMENT"
    else
      return ""
    end
  end

  WORLD_ATMOSPHERES = {
    0 => "None",
    1 => "Trace",
    2 => "Very Thin, Tainted",
    3 => "Very Thin",
    4 => "Thin, Tainted",
    5 => "Thin",
    6 => "Standard",
    7 => "Standard, Tainted",
    8 => "Dense",
    9 => "Dense, Tainted",
    10 => "Exotic",
    11 => "Corrosive",
    12 => "Insidious",
    13 => "Dense, High",
    14 => "Thin, Low",
    15 => "Unusual"
  }

  def show_atmosphere
    return WORLD_ATMOSPHERES[self.atmosphere]
  end
  def atmosphere_risk
    # raise self.atmosphere.inspect
    if [0,1,11,12].include? self.atmosphere
      return "red"
    elsif [2,3,4,7,9,10,13,14,15].include? self.atmosphere
      return "yellow"
    else
      return "green"
    end
  end
  def atmosphere_message
    if [0,1].include? self.atmosphere
      return "WARNING: NEAR-VACUUM ENVIRONMENT"
    elsif [2].include? self.atmosphere
      return "WARNING: RESPIRATORS AND FILTERS REQUIRED"
    elsif [3].include? self.atmosphere
      return "WARNING: RESPIRATORS REQUIRED"
    elsif [4,7,9].include? self.atmosphere
      return "WARNING: ATMOSPHERIC CONTAMINANTS PRESENT"
    elsif [10].include? self.atmosphere
      return "WARNING: PERSONAL AIR SUPPLY REQUIRED"
    elsif [11,12].include? self.atmosphere
      return "WARNING: EXTREME CORROSION HAZARD"
    elsif [13,14].include? self.atmosphere
      return "WARNING: NOT ALL ALTITUDES BREATHABLE"
    elsif [15].include? self.atmosphere
      return "WARNING: ANOMALOUS ATMOSPHERIC CONDITIONS"
    else
      return ""
    end
  end

  WORLD_HYDROGRAPHICS = {
    0 => "0-5%",
    1 => "6-15%",
    2 => "16-25%",
    3 => "26-35%",
    4 => "36-45%",
    5 => "46-55%",
    6 => "56-65%",
    7 => "66-75%",
    8 => "76-85%",
    9 => "86-95%",
    10 => "96-100%"
  }
  WORLD_HYDROGRAPHIC_DESCRIPTIONS = {
    0 => "Desert world",
    1 => "Dry world",
    2 => "A few small seas",
    3 => "Small seas and oceans",
    4 => "Wet world",
    5 => "Large oceans",
    6 => "World-spanning oceans",
    7 => "Earth-like oceans",
    8 => "Water world",
    9 => "Small islands and archipelagos",
    10 => "Almost entirely water"
  }

  def show_hydrographics
    return "#{WORLD_HYDROGRAPHICS[self.hydrographics]} - #{WORLD_HYDROGRAPHIC_DESCRIPTIONS[self.hydrographics]}"
  end


  WORLD_POPULATION = {
    0 => "0",
    1 => "1-100",
    2 => "100-1,000",
    3 => "1,000-10,000",
    4 => "10,000-100,000",
    5 => "100,000-1,000,000",
    6 => "1,000,000-10,000,000",
    7 => "10,000,000-100,000,000",
    8 => "100,000,000-1,000,000,000",
    9 => "1,000,000,000-10,000,000,000",
    10 => "10,000,000,000+"
  }

  def show_population
    return WORLD_POPULATION[self.population]
  end

  WORLD_GOVERNMENT = {
    0 => "None",
    1 => "Company/Corporation",
    2 => "Participating Democracy",
    3 => "Self-perpetuating Oligarchy",
    4 => "Representative Democracy",
    5 => "Feudal Technocracy",
    6 => "Captive Government",
    7 => "Balkanised",
    8 => "Civil Service Bureaucracy",
    9 => "Impersonal Bureaucracy",
    10 => "Charismatic Dictator",
    11 => "Non-charismatic Leader",
    12 => "Charismatic Oligarchy",
    13 => "Religious Dictatorship"
  }
  def show_government
    return WORLD_GOVERNMENT[self.government]
  end
  def government_risk
    case self.government
    when 0, 7, 10
      return "yellow"
    else
      return "green"
    end
  end

  def show_law_level
    return self.law
  end
  def law_risk
    if self.law.between?(1,8)
      return "green"
    else
      return "yellow"
    end
  end

  def show_contraband
    if self.contraband.present?
      return self.contraband
    else
      return ["None"]
    end
  end

  def show_starport
    return self.starport
  end
  def starport_risk
    case self.starport
    when "A", "B", "C", "D"
      return "green"
    when "E"
      return "yellow"
    else
      return "red"
    end
  end

  WORLD_TECHNOLOGY = {
    0 => "Stone Age",
    1 => "Bronze/Iron Age",
    2 => "Renaissance",
    3 => "Early 19th Century",
    4 => "Industrial Revolution",
    5 => "Mid-20th Century",
    6 => "Early Spaceflight",
    7 => "21st Century",
    8 => "Fusion Era",
    9 => "Gravtech",
    10 => "Early Stellar",
    11 => "Jump-2",
    12 => "Mid-Stellar",
    13 => "Jump-4",
    14 => "Jump-5",
    15 => "High Stellar"
  }

  def show_tech
    return "#{self.tech} - #{WORLD_TECHNOLOGY[self.tech]}"
  end

  WORLD_BASES= {
    "Navy" => "Navy Base",
    "Scout" => "Scout Base",
    "TAS" => "TAS Hostel",
    "Research" => "Research Outpost",
    "Consulate" => "Imperial Consulate",
    "Gas Giant" => "Gas Giant present",
    "Pirate" => "WARNING: PIRATE ACTIVITY REPORTED"
  }

  def show_bases
    bases = []
    self.bases.each do |base|
      bases << WORLD_BASES[base]
    end
    bases << "None" if bases.blank?
    return bases
  end

  def show_trade_codes
    return self.trade_codes
  end

end
