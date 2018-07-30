module ChartHelper
  DEFAULT_COLORS = {
    "Apprentice Cartographer's Sextant" => "#4A483E",
    "Blessed Orb" => "#8C6B38",
    "Cartographer's Chisel" => "#87795E",
    "Chaos Orb" => "#9B7640",
    "Chromatic Orb" => "#4B3C47",
    "Divine Orb" => "#53422B",
    "Exalted Orb" => "#9D743D",
    "Gemcutter's Prism" => "#3D372D",
    "Glassblower's Bauble" => "#4F8FC3",
    "Jeweller's Orb" => "#635E5C",
    "Journeyman Cartographer's Sextant" => "#C79B47",
    "Master Cartographer's Sextant" => "#972C1E",
    "Mirror of Kalandra" => "#5E5A53",
    "Orb of Alchemy" => "#C69239",
    "Orb of Alteration" => "#266FD4",
    "Orb of Annulment" => "#0F40E3",
    "Orb of Augmentation" => "#2A4C84",
    "Orb of Chance" => "#41456E",
    "Orb of Fusing" => "#474946",
    "Orb of Regret" => "#A5AAAB",
    "Orb of Scouring" => "#B5B7BF",
    "Orb of Transmutation" => "#1E64BB",
    "Regal Orb" => "#468AC8",
    "Silver Coin" => "#985891",
    "Vaal Orb" => "#C03C14"
  }

  def default_order
    [
      "Chaos Orb",
      "Orb of Fusing",
      "Orb of Alchemy",
      "Exalted Orb",
      "Orb of Annulment",

      "Jeweller's Orb",
      "Chromatic Orb",

      "Regal Orb",
      "Blessed Orb",
      "Divine Orb",
      "Glassblower's Bauble",
      "Gemcutter's Prism",
      "Orb of Scouring",
      "Orb of Regret",
      "Vaal Orb",

      "Cartographer's Chisel",
      "Apprentice Cartographer's Sextant",
      "Journeyman Cartographer's Sextant",
      "Master Cartographer's Sextant",

      "Mirror of Kalandra",

      "Orb of Transmutation",
      "Orb of Alteration",
      "Orb of Chance",
      "Orb of Augmentation",
      "Silver Coin"
    ].freeze
  end

  def color_for(currency)
    DEFAULT_COLORS[currency]
  end

  def diff(data)
    return '-' if data.second.blank?
    format_number(data.first.last - data.second.last)
  end

  def diff_percent(data)
    return '-' if data.second.blank?
    result = ((data.first.last - data.second.last).to_f / data.second.zero? ? 1 : data.second.last.to_f * 100.to_f).round
    format_number(result, true)
  end

  def color_for_chart(currency)
    case currency
    when "Vaal Orb"
      "#CC1F1A"
    when "Chaos Orb"
      "#DE751F"
    end
  end

  private
  def format_number(number, suffix=false)
    result_as_string = number.positive? ? number.to_s.prepend("+") : number.to_s
    result_as_string = number_to_human(number, :format => '%n%u', :units => { :thousand => 'K' }) if number >= 1000
    result_as_string = suffix ? result_as_string << "%" : result_as_string
    content_tag(
      :li,
      result_as_string,
      class: "#{number_color(number)} text-center text-xl font-bold"
    )
  end

  def number_color(number)
    if number.positive?
      'text-green'
    elsif number.negative?
      'text-red'
    else
      'text-yellow-dark'
    end
  end
end
