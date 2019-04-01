module ChartHelper
  DEFAULT_COLORS = {
    "Apprentice Cartographer's Sextant" => '#ced4da',
    'Blessed Orb' => '#efd282',
    "Cartographer's Chisel" => '#a5b1c2',
    'Chaos Orb' => '#f5cd79',
    'Chromatic Orb' => '#9475c3',
    'Divine Orb' => '#fdd673',
    'Exalted Orb' => '#f3c461',
    "Gemcutter's Prism" => '#7353c4',
    "Glassblower's Bauble" => '#4F8FC3',
    "Jeweller's Orb" => '#DAE1E7',
    "Journeyman Cartographer's Sextant" => '#C79B47',
    "Master Cartographer's Sextant" => '#f03e3e',
    'Mirror of Kalandra' => '#5E5A53',
    'Orb of Alchemy' => '#f7d691',
    'Orb of Alteration' => '#266FD4',
    'Orb of Annulment' => '#0F40E3',
    'Orb of Augmentation' => '#2779BD',
    'Orb of Chance' => '#1864ab',
    'Orb of Fusing' => '#B8C2CC',
    'Orb of Regret' => '#A5AAAB',
    'Orb of Scouring' => '#B5B7BF',
    'Orb of Transmutation' => '#1E64BB',
    'Regal Orb' => '#468AC8',
    'Silver Coin' => '#a287ca',
    'Vaal Orb' => '#E3342F'
  }.freeze

  def color_for(chart_preference)
    user_custom_color = chart_preference['color']

    if user_custom_color != 'default'
      user_custom_color
    else
      DEFAULT_COLORS[chart_preference['currency']]
    end
  end

  def diff(data)
    return '-' if data[-2].blank?

    data.last.last - data[-2].last
  end

  def diff_percent(data)
    return '-' if data[-2].blank?

    ((data.last.last - data[-2].last).to_f / (data[-2].last.zero? ? 1 : data[-2].last.to_f) * 100.to_f).round
  end

  def convert_thousand_to_human(value)
    number_to_human(value, format: '%n%u', units: { thousand: 'K' })
  end

  def default_colors
    DEFAULT_COLORS
  end

  private

  def format_number(number, suffix = false)
    return '-' if number.is_a?(String)

    result_as_string = number.positive? ? number.to_s.prepend('+') : number.to_s
    result_as_string = number_to_human(number, format: '%n%u', units: { thousand: 'K' }) if number >= 1000
    result_as_string = suffix ? result_as_string << '%' : result_as_string
    result_as_string = '-' if result_as_string == '0' || result_as_string == '0%'

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
