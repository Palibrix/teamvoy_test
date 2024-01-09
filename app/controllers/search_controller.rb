require 'json'
require 'open-uri'

class SearchController < ApplicationController

  def index
    # Getting live data
    @data = JSON.parse(URI.open('https://gist.githubusercontent.com/g3d/d0b84a045dd6900ca4cb/raw/d837b786a3b7c5a57c7ef059e4ba8a8fe1a76195/data.json').read)
    @data.each do |entry|
      entry.transform_values! {|s| s.downcase}
    end

    @query = params[:query] || ''
    @results = search(@data, @query)
  end

  private

  def search(data, query)
    # Split the query into terms
    @terms = query.downcase.split

    # Filter the data based on the terms
    scored_data = data.map do |entry|
      # Adding results and evaluating a score
      score = @terms.sum do |term|
        if term.start_with?('-')
          term = term[1..]
          # Subtraction 200 from score so that they will never be shown in that grid. Not like Bing or Google, huh)
          entry['Name'].include?(term) || entry['Type'].include?(term) || entry['Designed by'].include?(term) ? -200 : 0


          # Imagine we have "b", "bash" and "cobol". We are searching for "b". What should be higher? Exactly
        elsif entry['Name'] == term
          entry['Name'] == term ? 2 : 0

        else
          # "Support for exact matches, eg. Interpreted "Thomas Eugene", which should match "BASIC", but not "Haskell""
          # Yep, I think that's not really possible with scoring system, but "BASIC" will be higher than "Haskell" in results,
          # because Thomas Eugene will add 2 to the score of "BASIC", but "Thomas" alone will add 1 to "Haskel"

          # Ofc, you can show only best scoring results in this way, but... What the point of scoring here?
          entry['Name'].include?(term) || entry['Type'].include?(term) || entry['Designed by'].include?(term) ? 1 : 0
        end
      end
      { entry: entry, score: score }
    end

    # Filter the entries by score
    filtered_data = scored_data.select { |item| item[:score] >= 1 }

    sorted_data = filtered_data.sort_by { |item| -item[:score] }

    # Group the entries by score
    sorted_data.group_by { |item| item[:score] }

  end
end
