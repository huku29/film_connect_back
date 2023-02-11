require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

class GetFilmData

  BASE_URL = "https://api.themoviedb.org/3"

  def initialize
    @api_key = ENV['VITE_TMDB_API_KEY']
    # @connection = Faraday.new(ssl: { ca_path: "/usr/local/etc/openssl@3" }, params: { api_key: @api_key, language: "ja" })
  end

  def search_films(search_word, page)
    @connection = Faraday.new(ssl: { ca_path: "/usr/local/etc/openssl@3" }, params: { api_key: @api_key, language: "ja" })
    @connection.params[:query] = search_word
    @connection.params[:page] = page
    response = @connection.get("#{BASE_URL}/search/movie")
    response.body
  end

  def search_films_by_english(search_word, page)
    @connection = Faraday.new(ssl: { ca_path: "/usr/local/etc/openssl@3" }, params: { api_key: @api_key, language: "en" })
    @connection.params[:query] = search_word
    @connection.params[:page] = page
    response = @connection.get("#{BASE_URL}/search/movie")
    response.body
  end


  def detail_film(film_id)
    @connection = Faraday.new(ssl: { ca_path: "/usr/local/etc/openssl@3" }, params: { api_key: @api_key, language: "ja"})
    @connection.params[:film_id] = film_id
    response = @connection.get("#{BASE_URL}/movie/#{film_id}")
    response.body
  end
  

  def detail_film_by_english(film_id)
    @connection = Faraday.new(ssl: { ca_path: "/usr/local/etc/openssl@3" }, params: { api_key: @api_key, language: "en"})
    @connection.params[:film_id] = film_id
    response = @connection.get("#{BASE_URL}/movie/#{film_id}")
    response.body
  end




  class << self
    def client
      GetFilmData.new
    end

    def search_films(search_word, page)
      client.search_films(search_word, page)
    end

    def search_films_by_english(search_word, page)
      client.search_films_by_english(search_word, page)
    end

    def detail_film(film_id)
      client.detail_film(film_id)
    end

    def detail_film_by_english(film_id)
      client.detail_film_by_english(film_id)
    end

  end
  
end