class LiteraryPeriods
  
  MAPPING = {
    'Middle Ages' => 500..1500,
    'Tudor Literature' => 1485..1603,
    'Early Modern' => 1500..1800,
    'Elizabethan' => 1558..1603,
    'Seventeenth Century' => 1600..1700,
    'Early Seventeenth Century' => 1603..1660,
    'Civil War and Commonwealth' => 1641..1660,
    'Long Eighteenth Century' => 1660..1789,
    'Restoration' => 1660..1714,
    'Augustan' => 1700..1745,
    'Eighteenth Century' => 1700..1800,
    'Age of Sensibility' => 1740..1798,
    'Industrial Revolution' => 1760..1840,
    'Romantic' => 1785..1832,
    'French Revolution' => 1789..1815,
    'Nineteenth Century' => 1800..1900,
    'Reform and Counterrevolution' => 1815..1848,
    'Victorian' => 1837..1901,
    'Aestheticism and Decadence' => 1870..1901,
    'Twentieth Century' => 1900..2000,
    'Edwardian' => 1901..1914,
    'Modernism' => 1910..1945,
    'Interwar' => 1914..1939,
    'Post-WWII' => 1945..1989
  }
  
  # "year" will be converted to an integer
  # returns an array of arrays where each array is composed of:
  # first item -- label (String)
  # second item -- year range (Range)
  def self.map(year)
    year = year.to_i
    MAPPING.select{|k,v| year >= v.min and year <= v.max }
  end
  
end